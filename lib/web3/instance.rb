require "web3/apis"
require "web3/apis/net"
require "web3/apis/eth"

module Web3
  class Instance
    RPC_VERSION = "2.0".freeze

    extend APIs

    api :net, APIs::Net
    api :eth, APIs::Eth

    attr_reader :provider

    def initialize(provider)
      @provider = provider
    end

    def request(payload)
      response = @provider.send_sync(payload)

      if response["id"] != payload["id"]
        raise "Received different response id"
      end

      response["result"]
    end

    def build_payload(endpoint, params = [], id = nil)
      {
        id: id,
        jsonrpc: RPC_VERSION,
        method: endpoint,
        params: params
      }
    end
  end
end
