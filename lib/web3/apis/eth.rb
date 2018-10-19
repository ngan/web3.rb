require "web3/apis/abstract"

module Web3
  module APIs
    class Eth < Abstract
      SyncStatus = Struct.new(
        :starting_block,
        :current_block,
        :highest_block
      )

      define_call :eth_protocolVersion,
        as: :protocol_version,
        output: :string

      define_call :eth_syncing, as: :syncing do |web3|
        if output = web3.request(web3.build_payload(:eth_syncing))
          SyncStatus.new(
            output["startingBlock"].to_i(16),
            output["currentBlock"].to_i(16),
            output["highestBlock"].to_i(16)
          )
        else
          false
        end
      end

      define_call :eth_coinbase,
        as: :coinbase,
        output: :string

      define_call :eth_mining,
        as: :mining,
        output: :boolean

      define_call :eth_hashrate,
        as: :hashrate,
        output: :integer

      define_call :eth_gasPrice,
        as: :gas_price,
        output: :integer

      define_call :eth_accounts,
        as: :accounts

      define_call :eth_blockNumber,
        as: :block_number,
        output: :integer

      define_call :eth_getBalance,
        as: :get_balance,
        inputs: [:string!, :default_block]

      define_call :eth_getStorageAt,
        as: :get_storage_at,
        inputs: [:string!, :integer!, :default_block],
        output: :string

      define_call :eth_getTransactionCount,
        as: :get_transaction_count,
        inputs: [:string!, :default_block],
        output: :integer

      define_call :eth_getBlockTransactionCountByHash,
        as: :get_block_transaction_count_by_hash,
        inputs: :string!,
        output: :integer

      define_call :eth_getBlockTransactionCountByNumber,
        as: :get_block_transaction_count_by_number,
        inputs: :default_block!,
        output: :integer

      define_call :eth_getUncleCountByBlockHash,
        as: :get_uncle_count_by_block_hash,
        inputs: :string!,
        output: :integer

      define_call :eth_getUncleCountByBlockNumber,
        as: :get_uncle_count_by_block_number,
        inputs: :default_block!,
        output: :integer

      define_call :eth_getCode,
        as: :get_code,
        inputs: [:string!, :default_block],
        output: :string

      define_call :eth_sign,
        as: :sign,
        inputs: [:string!, :string!],
        output: :string

      define_call :eth_sendTransaction,
        as: :send_transaction,
        inputs: :transaction!,
        output: :string

      define_call :eth_sendRawTransaction,
        as: :send_raw_transaction,
        inputs: :string!,
        output: :string!

      define_call :eth_call,
        as: :call,
        inputs: :transaction!,
        output: :string

      define_call :eth_estimateGas,
        as: :estimate_gas,
        inputs: :transaction!,
        output: :integer

      define_call :eth_getBlockByHash,
        as: :get_block_by_hash,
        inputs: [:string!, :boolean!]

      define_call :eth_getBlockByNumber,
        as: :get_block_by_number,
        inputs: [:default_block!, :boolean!]

      define_call :eth_getTransactionByHash,
        as: :get_transaction_by_hash,
        inputs: :string!

      define_call :eth_getTransactionByBlockHashAndIndex,
        as: :get_transaction_by_block_hash_and_index,
        inputs: [:string!, :integer!]

      define_call :eth_getTransactionByBlockNumberAndIndex,
        as: :get_transaction_by_block_number_and_index,
        inputs: [:default_block!, :integer!]

      define_call :eth_getTransactionReceipt,
        as: :get_transaction_receipt,
        inputs: :string!

      define_call :eth_getUncleByBlockHashAndIndex,
        as: :get_uncle_by_block_hash_and_index,
        inputs: [:string!, :integer]

      define_call :eth_getUncleByBlockNumberAndIndex,
        as: :get_unclde_by_block_number_and_index,
        inputs: [:default_block!, :integer]

      define_call :eth_newFilter,
        as: :new_filter,
        inputs: :filter!,
        output: :integer

      define_call :eth_newBlockFilter,
        as: :new_block_filter,
        output: :integer

      define_call :eth_newPendingTransactionFilter,
        as: :new_pending_transaction_filter,
        output: :integer

      define_call :eth_uninstallFilter,
        as: :uninstall_filter,
        inputs: :integer!,
        output: :boolean

      define_call :eth_getFilterChanges,
        as: :get_filter_changes,
        inputs: :integer!

      define_call :eth_getFilterLogs,
        as: :get_filter_logs,
        inputs: :integer!

      define_call :eth_getLogs,
        as: :get_logs,
        inputs: :filter!

      define_call :eth_getWork,
        as: :get_work

      define_call :eth_submitWork,
        as: :submit_work,
        inputs: [:string!, :string!, :string!],
        output: :boolean

      define_call :eth_submitHashrate,
        as: :submit_hashrate,
        inputs: [:string!, :string!],
        output: :boolean
    end
  end
end
