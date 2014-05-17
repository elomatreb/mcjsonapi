require "spec_helper"

describe "Mcjsonapi:" do
  # You need a local Minecraft server running on localhost:20059 with these
  # JSONAPI credentials to run the tests.
  let(:username) { "testuser" }
  let(:password) { "password" }

  describe "new instance" do
    describe "with invalid information" do
      describe "without any information" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new }.to raise_error("Username and password are needed.")
        end
      end

      describe "without password" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new username: username }.to raise_error("Password is needed.")
        end
      end

      describe "without username" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new password: password }.to raise_error("Username is needed.")
        end
      end
    end

    describe "with valid information" do
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
        let(:api) { Mcjsonapi::API.new port: 25565, username: username, password: password }

        it "should use the given port" do
          expect(api.port).to eq 25565
        end
      end
    end
  end
end
