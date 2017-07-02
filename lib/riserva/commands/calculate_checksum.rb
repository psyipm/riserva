require 'dropbox_content_hasher'

module Riserva::Commands
  class CalculateChecksum < ApplicationCommand
    attr_reader :file_path, :checksum_path, :checksum

    def initialize(file_path)
      @file_path = Pathname.new(file_path)
    end

    def call
      return broadcast(:invalid) unless valid?

      if calculate_checksum
        broadcast(:ok, files)
      else
        broadcast(:failed)
      end
    end

    private

    def files
      [@file_path, @checksum_path]
    end

    def valid?
      @file_path.file?
    end

    def calculate_checksum
      @checksum = DropboxContentHasher.calculate(@file_path)
      @checksum_path = "#{@file_path}.checksum"
      system("echo #{@checksum} > #{@checksum_path}")
    end
  end
end
