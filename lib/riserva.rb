# frozen_string_literal: true

require 'riserva/version'

module Riserva
  autoload :Config, 'riserva/config'

  module Commands
    autoload :ApplicationCommand, 'riserva/commands/application_command'
    autoload :CreateArchive, 'riserva/commands/create_archive'
    autoload :CalculateChecksum, 'riserva/commands/calculate_checksum'
  end

  module Storage
    autoload :GoogleDrive, 'riserva/storage/google_drive'
  end
end
