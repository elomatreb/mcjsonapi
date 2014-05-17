require "spec_helper"

describe Mcjsonapi do
  before do
    # You need a local Minecraft server running on localhost:20059 with these
    # JSONAPI credentials to run the tests.
    @username = "testuser"
    @password = "password"
  end

  describe "instance" do
    describe "with invalid information" do
      describe "without any information" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new }.to raise_error("Username and password are needed.")
        end
      end

      describe "without password" do
        it "should raise an error" do
          expect { Mcjsonapi::API.new username: @username }.to raise_error("Password is needed.")
        end
      end

      describe "without username" do
        it "should raise an exception" do
          expect { Mcjsonapi::API.new password: @password }.to raise_error("Username is needed.")
        end
      end
    end
  end
end
