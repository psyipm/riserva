require 'wisper'

module Riserva::Commands
  class ApplicationCommand
    include Wisper::Publisher

    class NotImplementedError < StandardError; end

    def initialize
      subscribe(build_listener.new)
    end

    def files
      listeners.first.files
    end

    def call(path)
      @path = Pathname.new(path)
      valid?
    end

    private

    def valid?
      @path.exist?
    end

    def build_listener
      class_name = self.class.name.split('::').last
      listener = "Riserva::Listeners::#{class_name}".safe_constantize
      raise NotImplementedError if listener.nil?

      listener
    end
  end
end
