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

      data = CGI::escape( JSON.generate options )
      url  = URI("http://#{@host}:#{@port}/api/2/call?json=#{data}")

      response = JSON.parse Net::HTTP.get(url)
      response = response[0]

      if response["is_success"]
        return response["success"]
      else
        raise APIError, "#{response["error"]["message"]}, Code #{response["error"]["code"]}"
      end
    end

  end

  class APIError < StandardError; end
end
