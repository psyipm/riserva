# frozen_string_literal: true

require 'notifier'

module Riserva::Listeners
  class Backup < ApplicationListener
    def initialize
      notify('Starting backup...')
      Riserva.logger.info(Riserva.version) { 'Starting backup...' }
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
      Notifier.notify(image: notification_icon, title: 'Riserva', message: message)
    end

    def enabled?
      Riserva::Config.read('system_notifications')
    end

    def notification_icon
      Riserva::Config.read('notification_icon') || 'media-floppy-symbolic'
    end
  end
end
