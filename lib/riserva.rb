# frozen_string_literal: true

require 'riserva/version'
require 'active_support/core_ext/string/inflections'
require 'active_support/time'
require 'pathname'
require 'parallel'

module Riserva
  autoload :Config, 'riserva/config'
  autoload :Log, 'riserva/log'

  module Commands
    autoload :ApplicationCommand, 'riserva/commands/application_command'
    autoload :Backup, 'riserva/commands/backup'
    autoload :Clean, 'riserva/commands/clean'
    autoload :CreateArchive, 'riserva/commands/create_archive'
    autoload :UploadFile, 'riserva/commands/upload_file'
  end

  module Listeners
    autoload :ApplicationListener, 'riserva/listeners/application_listener'
    autoload :Backup, 'riserva/listeners/backup'
    autoload :Clean, 'riserva/listeners/clean'
    autoload :CreateArchive, 'riserva/listeners/create_archive'
    autoload :UploadFile, 'riserva/listeners/upload_file'
  end

  module Storage
    autoload :ApplicationStorage, 'riserva/storage/application_storage'
    autoload :Dropbox, 'riserva/storage/dropbox'
    autoload :GoogleDrive, 'riserva/storage/google_drive'
  end

  def self.logger
    Riserva::Log.new.logger
  end

  def self.version
    "Riserva v#{Riserva::VERSION}"
  end
end
