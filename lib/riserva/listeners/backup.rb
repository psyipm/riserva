require 'notifier'

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
      return unless enabled?
      Notifier.notify(image: 'media-floppy-symbolic', title: 'Riserva', message: message)
    end

    def enabled?
      Riserva::Config.read('system_notifications')
    end
  end
end
