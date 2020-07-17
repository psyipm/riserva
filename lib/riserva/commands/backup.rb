require 'parallel'

module Riserva::Commands
  class Backup < ApplicationCommand
    MAX_THREADS = 5

    def initialize
      super
    end

    def call
      perform

      broadcast(:ok)
    rescue StandardError => e
      broadcast(:failed)
      raise e
    end

    private

    def perform
      Parallel.map(Riserva::Config.folders, in_threads: MAX_THREADS) do |folder|
        push_to_cloud archivator.call(folder).files
      end
    end

    def archivator
      @archivator ||= Riserva::Commands::CreateArchive.new
    end

    def push_to_cloud(files)
      Riserva::Config.storages.each do |storage|
        files.map { |file| upload_file(storage, file) }
      end
    end

    def upload_file(storage, file)
      uploader(storage).call(file)
    end

    def uploader(storage)
      @uploaders ||= {}
      @uploaders[storage.title] ||= Riserva::Commands::UploadFile.new(storage)
    end
  end
end
