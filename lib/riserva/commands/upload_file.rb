module Riserva::Commands
  class UploadFile < ApplicationCommand
    def initialize(storage)
      super()
      @storage = storage
    end

    def call(path)
      return broadcast(:invalid) unless super

      success? ? broadcast(:ok, @path) : broadcast(:failed, @path)
    end

    private

    def success?
      upload && verify
    end

    def upload
      @storage.upload(@path, @path.basename)
    end

    def verify
      @storage.verify(@path.basename, @path)
    end
  end
end
