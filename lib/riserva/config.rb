# frozen_string_literal: true

require 'yaml'

module Riserva
  class Config
    DEFAULT_PATH = 'config/riserva.yml'

    def initialize
      @path = ENV['RISERVA_CONFIG'] || DEFAULT_PATH
    end

    def self.read(yaml_path)
      new.read(yaml_path)
    end

    def read(yaml_path)
      keys = yaml_path.split('.')
      config.dig(*keys)
    end

    def self.folders
      read('folders').map { |folder| Pathname.new(folder) }
    end

    def self.storages
      read('storage').keys.map do |storage|
        klass = "Riserva::Storage::#{storage.camelize}"
        klass.safe_constantize&.new
      end.compact
    end

    private

    def config
      @config ||= YAML.load_file(@path)
    end
  end
end
