# frozen_string_literal: true

module Riserva::Storage
  class ApplicationStorage
    def initialize(secrets = nil)
      @secrets = secrets || config_secrets
    end

    def title
      self.class.name.split('::').last.underscore
    end

    protected

    attr_reader :secrets

    def config_secrets
      Riserva::Config.read([:storage, title, :secrets].join('.'))
    end
  end
end
