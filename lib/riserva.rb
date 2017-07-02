# frozen_string_literal: true

require 'riserva/version'

module Riserva
  autoload :Config, 'riserva/config'

  module Commands
    autoload :ApplicationCommand, 'riserva/commands/application_command'
    autoload :CreateArchive, 'riserva/commands/create_archive'
  end

  module Storage
    autoload :ApplicationStorage, 'riserva/storage/application_storage'
    autoload :Dropbox, 'riserva/storage/dropbox'
    autoload :GoogleDrive, 'riserva/storage/google_drive'
  end
end
