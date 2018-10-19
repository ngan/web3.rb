require "web3/providers/abstract"
require "uri"
require "net/http"
require "json"

module Web3
  module Providers
    class HTTP < Abstract
      def initialize(options = {})
        @uri = URI.parse(options.fetch(:host, "http://localhost:8545"))
        @timeout = options[:timeout]
        @user = options[:user]
        @password = options[:password]
        @headers = options[:headers]
        @ssl = options.fetch(:ssl, {})

        establish_connection
      end

      def prepare_request(async)
        if async
          raise "Async operations are currently not supported"
        end

        Net::HTTP::Post.new("/".freeze, @headers).tap do |request|
          if @user || @password
            request.basic_auth(@user, @password)
          end
        end
      end

      def send_sync(payload)
        request = prepare_request(false)
        request.body = JSON.generate(payload)
        response = @connection.request(request)

        JSON.parse(response.body)
      end

      def connected?
        send_sync({
          id: 9999999999,
          jsonrpc: "2.0",
          method: "net_listening",
          params: []
        })
        true
      rescue
        false
      end

      private

      def establish_connection
        @connection = Net::HTTP.new(@uri.host, @uri.port)
        @connection.use_ssl = @uri.is_a?(URI::HTTPS)
        @connection.verify_mode = @ssl[:verify_mode]
        @connection.read_timeout = @timeout if @timeout
      end
    end
  end
end
