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

    def time_to_keep
      value = Riserva::Config.read([:storage, title, :days_to_keep].join('.'))
      return unless value

      value.days
    end
  end
end
