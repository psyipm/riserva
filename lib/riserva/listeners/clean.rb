module Riserva::Listeners
  class Clean < ApplicationListener
    def initialize
      Riserva.logger.info('Starting cleanup...')
    end

    def ok
      Riserva.logger.info('OK')
    end

    def failed
      Riserva.logger.info('Failed')
    end

    def start_cleaning(storage)
      Riserva.logger.info("Deleting old files on #{storage.title}...")
    end
  end
end
