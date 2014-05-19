module Mcjsonapi
  class API
    attr_reader :host, :port, :username

    def initialize(options = {})
      # Validation
      raise ArgumentError, "Username and password are needed." if options[:username].nil? && options[:password].nil?
      raise ArgumentError, "Password is needed." if options[:password].nil?
      raise ArgumentError, "Username is needed." if options[:username].nil?

      # Assigning variables
      @host = options[:host] || "localhost"
      @port = options[:port] || 20059

      @username = options[:username]
      @password = options[:password]
    end

    def generate_key(method)
      Digest::SHA256.hexdigest @username+method+@password
    end
  end
end
