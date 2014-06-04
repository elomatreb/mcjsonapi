require "spec_helper"

describe "Mcjsonapi:" do
  # You need a local Minecraft server running on localhost:20059 with these
  # JSONAPI credentials to run the tests.
  let(:username) { "username" }
  let(:password) { "password" }

  describe "new instance" do
    describe "with invalid information" do
      describe "without any information" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new }.to raise_error(ArgumentError)
        end
      end

      describe "without password" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new username: username }.to raise_error(ArgumentError)
        end
      end

      describe "without username" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new password: password }.to raise_error(ArgumentError)
        end
      end
    end

    describe "with valid information" do
      let(:api) { Mcjsonapi::API.new username: username, password: password }

      it "should use correct username" do
        expect(api.username).to eq username
      end

      describe "with no host given" do
        let(:api) { Mcjsonapi::API.new username: username, password: password }

        it "should assume localhost as default" do
          expect(api.host).to eq "localhost"
        end
      end

      describe "with host given" do
        let(:api) { Mcjsonapi::API.new host: "api.example.com", username: username, password: password }

        it "should use the given host" do
          expect(api.host).to eq "api.example.com"
        end
      end

      describe "with no port given" do
        let(:api) { Mcjsonapi::API.new username: username, password: password }

        it "should assume 20059 as default" do
          expect(api.port).to eq 20059
        end
      end

      describe "with port given" do
        let(:api) { Mcjsonapi::API.new port: 31337, username: username, password: password }

        it "should use the given port" do
          expect(api.port).to eq 31337
        end
      end
    end
  end

  describe "key generation" do
    let(:api) { Mcjsonapi::API.new username: username, password: password }

    describe "with no method parameter" do
      it "should raise an error" do
        expect { api.generate_key }.to raise_error(ArgumentError)
      end
    end

    describe "with correct parameters" do
      it "should return a valid key" do
        expect(api.generate_key "server.version").to eq Digest::SHA256.hexdigest(username+"server.version"+password)
      end
    end
  end

  describe "request" do
    let(:api) { Mcjsonapi::API.new username: username, password: password }

    describe "with no parameters" do
      it "should raise an error" do
        expect { api.call }.to raise_error(ArgumentError)
      end
    end

    describe "with empty (string) parameters" do
      it "should raise an error" do
        expect { api.call "" }.to raise_error(ArgumentError)
      end
    end

    describe "with empty (hash) parameters" do
      it "should raise an error" do
        expect { api.call {} }.to raise_error(ArgumentError)
      end
    end

    describe "with single string parameter" do
      describe "with no existing method" do
        it "should raise an error" do
          expect { api.call "server.ersion" }.to raise_error(Mcjsonapi::APIError)
        end
      end

      describe "with a existing method" do
        it "should return valid data" do
          expect(api.call "server.version").to eq 'git-Bukkit-1.6.4-R2.0-b2918jnks (MC: 1.6.4)'
        end
      end
    end

    describe "with host timeout" do
      it "should raise an exception" do
        expect { api.call "players.online.limit" }.to raise_error(Timeout::Error)
      end
    end
  end
end
