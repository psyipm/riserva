# frozen_string_literal: true

require 'riserva/version'

module Riserva
  autoload :Config, 'riserva/config'

  module Commands
    autoload :ApplicationCommand, 'riserva/commands/application_command'
    autoload :CreateArchive, 'riserva/commands/create_archive'
  end
end
