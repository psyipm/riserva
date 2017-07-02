require 'dropbox_content_hasher'

module Riserva::Commands
  class CalculateChecksum < ApplicationCommand
    attr_reader :checksum_path, :checksum

    def initialize(path)
      @path = Pathname.new(path)
    end

    def call
      return broadcast(:invalid) unless valid?

      if calculate_checksum
        broadcast(:ok, self)
      else
        broadcast(:failed)
      end
    end

    private

    def valid?
      @path.file?
    end

    def calculate_checksum
      @checksum = DropboxContentHasher.calculate(@path)
      @checksum_path = "#{@path}.checksum"
      system("echo #{@checksum} > #{@checksum_path}")
    end
  end
end
