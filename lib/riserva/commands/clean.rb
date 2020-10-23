module Riserva::Commands
  class Clean < ApplicationCommand
    def call
      storages.each do |storage|
        broadcast(:start_cleaning, storage)

        if storage.clean
          broadcast(:ok)
        else
          broadcast(:failed, storage)
        end
      end
    end

    private

    def storages
      Riserva::Config.storages
    end
  end
end
