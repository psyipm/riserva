# frozen_string_literal: true

require 'riserva/version'
require 'active_support/core_ext/string/inflections'

module Riserva
  autoload :Config, 'riserva/config'

  module Commands
    autoload :ApplicationCommand, 'riserva/commands/application_command'
    autoload :CreateArchive, 'riserva/commands/create_archive'

    autoload :ProcessFile, 'riserva/commands/process_file'
    autoload :UploadFile, 'riserva/commands/upload_file'
  end

  module Listeners
    autoload :ApplicationListener, 'riserva/listeners/application_listener'
    autoload :CreateArchive, 'riserva/listeners/create_archive'
    autoload :ProcessFile, 'riserva/listeners/process_file'
    autoload :UploadFile, 'riserva/listeners/upload_file'
  end

  module Storage
    autoload :ApplicationStorage, 'riserva/storage/application_storage'
    autoload :Dropbox, 'riserva/storage/dropbox'
    autoload :GoogleDrive, 'riserva/storage/google_drive'
  end
end