module Riserva::Commands
  class Clean < ApplicationCommand
    def call
      Riserva::Config.storages do |storage|
        broadcast(:start_cleaning, storage)

        storage.clean
      end
    end
  end
end