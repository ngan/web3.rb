module Web3
  module Types
    class Abstract
      attr_reader :warns

      def self.filter(value, warns = true)
        new(warns).filter(value)
      end

      def initialize(warns)
        @warns = warns
      end

      def filter(value)
        raise NotImplementedError
      end

      def warn_coercion!
        if warns
          warn "WARNING: Coercing #{value.inspect} (#{value.class}) to #{self.class.name}"
        end
      end
    end
  end
end
