module Riserva::Commands
  class CalculateChecksum < ApplicationCommand
    attr_reader :checksum_path, :md5sum

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
      @md5sum = Digest::MD5.hexdigest(File.read(@path))
      @checksum_path = "#{@path}.md5sum"
      system("echo #{@md5sum} > #{@checksum_path}")
    end
  end
end
