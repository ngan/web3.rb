require "web3/apis/abstract"

module Web3
  module APIs
    class Net < Abstract
      define_call :net_version,
        as: :version,
        output: :string
        
      define_call :net_listening,
        as: :listening,
        output: :boolean

      define_call :net_peerCount,
        as: :peer_count,
        output: :integer
    end
  end
end
