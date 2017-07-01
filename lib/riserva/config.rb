# frozen_string_literal: true

require 'safe_yaml'

module Riserva
  class Config
    DEFAULT_PATH = 'config/riserva.yml'

    def initialize
      SafeYAML::OPTIONS[:default_mode] = :safe

      @path = ENV['RISERVA_CONFIG'] || DEFAULT_PATH
    end

    def self.read(yaml_path)
      new.read(yaml_path)
    end

    def read(yaml_path)
      keys = yaml_path.split('.')
      config.dig(*keys)
    end

    private

    def config
      @config ||= YAML.load_file(@path)
    end
  end
end
