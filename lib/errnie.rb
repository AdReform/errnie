require 'errnie/version'
require 'errnie/configuration'
require 'errnie/errors'
require 'errnie/services/base'

class Errnie
  def self.notify(exception_or_error_message, service: nil, metadata: {}, service_options: {}, &block)
    service = service || configuration.default_service
    new(service).notify(exception_or_error_message, metadata: metadata, service_options: service_options, &block)
  end

  def initialize(service)
    @service = service
    @adapter_klass = adapter_for_service
  end

  def notify(exception_or_error_message, metadata: {}, service_options: {}, &block)
    adapter = @adapter_klass.new(exception_or_error_message, metadata: metadata, service_options: service_options)
    adapter.notify(&block)
  end

  private

  def default_service
    self.class.configuration.default_service
  end

  def adapter_for_service
    load_adapter

    begin
      Services.const_get(@service.to_s)
    rescue NameError
      raise Errors::UnsupportedService.new("#{@service} is not a supported error service")
    end
  end

  def load_adapter
    path_to_adapter = "errnie/services/#{@service.downcase}"
    begin
      require path_to_adapter
    rescue Gem::LoadError => e
      raise Gem::LoadError, "Specified '#{@service}' for error service, but the gem is not loaded. Add `gem '#{e.name}'` to your Gemfile (and ensure its version is at the minimum required by Errnie)."
    rescue LoadError => e
      raise LoadError, "Could not load '#{path_to_adapter}'. Make sure that the service is valid.", e.backtrace
    end
  end
end


