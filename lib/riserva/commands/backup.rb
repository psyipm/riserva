module Riserva::Commands
  class Backup < ApplicationCommand
    attr_reader :uploaders

    def initialize
      @uploaders = {}
    end

    def call
      create_archives
      push_to_cloud

      success? ? broadcast(:ok) : broadcast(:failed)
    end

    private

    def success?
      @uploaders.values.map { |uploader| uploader.files == archivator.files }.all?
    end

    def create_archives
      Riserva::Config.folders { |folder| archivator.call(folder) }
    end

    def archivator
      @archivator ||= Riserva::Commands::CreateArchive.new
    end

    def push_to_cloud
      Riserva::Config.storages do |storage|
        archivator.files.each { |file| upload_file(storage, file) }
      end
    end

    def upload_file(storage, file)
      uploader(storage).call(file)
    end

    def uploader(storage)
      @uploaders[storage.title] ||= Riserva::Commands::UploadFile.new(storage)
    end
  end
end
