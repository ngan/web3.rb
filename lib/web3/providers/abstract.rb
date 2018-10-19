module Web3
  module Providers
    class Abstract
      def prepare_request(async)
        raise NotImplementedError
      end

      def send_sync(payload)
        raise NotImplementedError
      end

      def send_async(*)
        raise "Async operations are currently not supported"
      end

      def connected?
        raise NotImplementedError
      end
    end
  end
end
