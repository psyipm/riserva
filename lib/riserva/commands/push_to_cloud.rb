# frozen_string_literal: true

module Riserva::Commands
  class PushToCloud < ApplicationCommand
    attr_reader :storage, :files

    def initialize(files)
      @files = Set.new files.map { |f| Pathname.new(f) }
    end

    def call(storage)
      @storage = storage
      return broadcast(:invalid) unless valid?

      @files.map { |file| uploader.call(file) }

      success? ? broadcast(:ok, self) : broadcast(:failed, self)
    end

    def success?
      uploader.files == @files
    end

    private

    def valid?
      @files.map(&:exist?).all?
    end

    def uploader
      @uploader ||= Riserva::Commands::UploadFile.new(@storage)
    end
  end
end
