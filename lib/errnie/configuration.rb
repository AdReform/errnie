class Errnie
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    configuration
  end

  class Configuration
    attr_accessor :default_service

    def initialize
      @default_service = 'Bugsnag'
    end
  end
end
