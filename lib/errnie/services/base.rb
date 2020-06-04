class Errnie
  module Services
    class Base
      def initialize(exception_or_error_message, raw_options={})
        @exception_or_error_message = exception_or_error_message
        @raw_options = raw_options
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
