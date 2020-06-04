class Errnie
  module Services
    class Base
      def initialize(exception_or_error_message, metadata: {}, service_options: {})
        @exception_or_error_message = exception_or_error_message
        @metadata = metadata
        @service_options = service_options
      end

      def notify
      end

      def error
      end

      def options
      end
    end
  end
end
