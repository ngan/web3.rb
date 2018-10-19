require "web3/types/integer"
require "web3/types/boolean"
require "web3/types/string"
require "web3/types/default_block"
require "web3/types/filter"
require "web3/types/transaction"

module Web3
  module APIs
    class Abstract
      attr_reader :web3

      def self.define_call(endpoint, options, &block)
        method_name = options.fetch(:as, endpoint)
        input_spec = options[:inputs]
        output_spec = options[:output]

        define_method(method_name) do |*input|
          filtered_input = filter_inputs(input, input_spec)
          output = if block_given?
            yield web3, filtered_input
          else
            web3.request(web3.build_payload(endpoint, filtered_input))
          end
          filter_output(output, output_spec)
        end
      end

      def initialize(web3)
        @web3 = web3
      end

      def filter_inputs(input, input_spec)
        specs = Array(input_spec)
        required_inputs = specs.select { |spec| spec.to_s.end_with?("!") }

        if input.size != required_inputs.size
          raise "Expected #{required_inputs.size} param(s), got #{input.size}"
        end

        Array(input).map.with_index do |value, index|
          spec = specs.at(index)
          filter = filter_class(spec)

          if spec.to_s.end_with?("!") && value.nil?
            raise "Expected param ##{index + 1} to be #{filter.name}"
          end

          filter.filter(value)
        end
      end

      def filter_output(output, output_spec)
        output_spec ? filter_class(output_spec).filter(output, false) : output
      end

      def filter_class(spec)
        case spec
          when :integer, :integer! then Web3::Types::Integer
          when :boolean, :boolean! then Web3::Types::Boolean
          when :string, :string! then Web3::Types::String
          when :default_block, :default_block! then Web3::Types::DefaultBlock
          when :transaction, :transaction! then Web3::Types::Transaction
          when :filter, :filter! then Web3::Types::Filter
          else raise "Unknown output type: #{spec}"
        end
      end
    end
  end
end
