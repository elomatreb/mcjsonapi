module Mcjsonapi
  class API
    attr_reader :host, :port, :username

    def initialize(options = {})
      raise ArgumentError, "Username and password must be given." if options[:username].nil? || options[:password].nil?

      @host = options[:host] || "localhost"
      @port = options[:port] || 20059

      @username = options[:username]
      @password = options[:password]
    end

    def generate_key(method)
      Digest::SHA256.hexdigest @username+method+@password
    end

    def call(options = {})
      if options.is_a? String
        
        unless options.empty?
          options = { name: options }
        else
          raise ArgumentError, "A method must be given."
        end

      elsif options.is_a? Hash

        if options.empty? || options[:method].nil?
          raise ArgumentError, "A method must be given."
        end

      else
        raise ArgumentError, "A method must be given."
      end
    end
    
  end
end
