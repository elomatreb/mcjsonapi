module Mcjsonapi
  class API
    attr_reader :host, :port, :username

    def initialize(options = {})
      # Validation
      raise "Username and password are needed." if options[:username].nil? && options[:password].nil?
      raise "Password is needed." if options[:password].nil?
      raise "Username is needed." if options[:username].nil?

      # Assigning variables
      @host = options[:host] || "localhost"
      @port = options[:port] || 20059

      @username = options[:username]
      @password = options[:password]
    end
  end
end
