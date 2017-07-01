require 'wisper'

module Riserva::Commands
  class ApplicationCommand
    include Wisper::Publisher

    def self.call(*args, &block)
      run(*args, &block)
      nil
    end

    def self.run(*args)
      command = new(*args)
      yield command if block_given?
      command.call
      command
    end
  end
end
