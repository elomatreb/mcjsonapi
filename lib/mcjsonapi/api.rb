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
        if options.empty?
          raise ArgumentError, "A method must be given."
        else
          options = { name: options }
        end
      elsif options.is_a? Hash
        if options.empty? || options[:name].nil?
          raise ArgumentError, "A method must be given."
        end
      else
        raise ArgumentError, "A method must be given."
      end

      options[:username] = @username
      options[:key]      = generate_key(options[:name])

      data = CGI::escape JSON.generate(options)
      
      response = Net::HTTP.get_response URI("http://#{@host}:#{@port}/api/2/call?json=#{data}")

      raise APIError, "The API responded with an HTTP error." unless response.is_a? Net::HTTPOK

      response_data = JSON.parse(response.body)[0]

      if response_data["is_success"]
        return response_data["success"]
      else
        raise APIError, "The API raised an error: #{response_data["error"]["message"]} (Code #{response_data["error"]["code"]})"
      end
    end

  end

  class APIError < StandardError; end
end
