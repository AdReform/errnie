require 'errnie/services/base'

gem 'bugsnag', '~> 6.5'
require 'bugsnag'

class Errnie
  module Services
    class Bugsnag < Base
      def notify(&block)
        ::Bugsnag.notify(error, auto_notify, &block)
      end

      def error
        @exception_or_error_message
      end

      def options
        @raw_options
      end

      private

      def auto_notify
        bugsnag_options[:auto_notify]
      end

      def bugsnag_options
        @bugsnag_options ||= @raw_options.fetch(:bugsnag_options, {})
      end
    end
  end
end
