require 'errnie/services/base'

gem 'bugsnag', '~> 6.5'
require 'bugsnag'

class Errnie
  module Services
    class Bugsnag < Base
      def notify(&block)
        if block_given?
          ::Bugsnag.notify(error, auto_notify, &block)
        elsif @metadata && !@metadata.empty?
          ::Bugsnag.notify(error, auto_notify) do |notification|
            notification.add_tab(:metadata, @metadata)
          end
        else
          ::Bugsnag.notify(error, auto_notify)
        end
      end

      def error
        @exception_or_error_message
      end

      private

      def auto_notify
        @service_options[:auto_notify]
      end
    end
  end
end
