module Riserva::Listeners
  class CreateArchive < ApplicationListener
    attr_reader :files

    def initialize
      @files = []
    end

    def ok(archive_name)
      @files << archive_name
    end

    def failed; end

    def invalid; end
  end
end
