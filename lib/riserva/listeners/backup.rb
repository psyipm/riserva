module Riserva::Listeners
  class Backup < ApplicationListener
    def initialize
      notify('Starting backup...')
    end

    def ok
      notify('Backup successfully completed')
    end

    def failed
      notify('Backup failed')
    end

    private

    def notify(message)
      system("notify-send --icon=media-floppy-symbolic --expire-time=10000 'Riserva' '#{message}'")
    end
  end
end
