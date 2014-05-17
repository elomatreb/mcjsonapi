require "mcjsonapi/version"

module Mcjsonapi
  class API
    attr_reader :host, :port

    def initialize(options = {})
      # Validation
      raise "Username and password are needed." if options[:username].nil? && options[:password].nil?
      raise "Password is needed." if options[:password].nil?
      raise "Username is needed." if options[:username].nil?

      # Assigning variables
      @host = options[:host] || "localhost"
      @port = options[:port] || 20059
    end
  end
end
