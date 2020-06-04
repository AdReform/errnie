require 'errnie/services/base'

gem 'appsignal', '~> 2.10'
require 'appsignal'

class Errnie
  module Services
    class Appsignal < Base
      def notify(&block)
        ::Appsignal.send_error(error, @metadata, &block)
      end

      def error
        @error ||= klassify_error
      end

      private

      def klassify_error
        if @exception_or_error_message.is_a?(Exception)
          @exception_or_error_message
        else
          RuntimeError.new(@exception_or_error_message.to_s)
        end
      end
    end
  end
end
