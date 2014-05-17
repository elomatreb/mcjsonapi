require "mcjsonapi/version"

module Mcjsonapi
  class API
    def initialize(options = {})
      raise "Username and password are needed." if options.empty?
      raise "Password is needed." if options[:password].nil?
      raise "Username is needed." if options[:username].nil?
    end
  end
end
