# frozen_string_literal: true

require 'json'
require 'dropbox_api'
require 'dropbox_content_hasher'

module Riserva::Storage
  class Dropbox < ApplicationStorage
    def upload(local_file, remote_file)
      session.upload(
        File.join('/', remote_file),
        IO.read(local_file)
      )
    end

    def download(remote_file, local_file)
      session.download(File.join('/', remote_file)) do |stream|
        Pathname.new(local_file).write(stream)
      end
    end

    def verify(remote_file, local_file)
      data = session.get_metadata(File.join('/', remote_file))
      checksum = DropboxContentHasher.calculate(local_file)

      data.content_hash == checksum
    end

    def clean
      return unless time_to_keep

      session.list_folder('').entries.each do |file|
        next unless file.client_modified < time_to_keep.ago

        session.delete file.path_lower
      end
    end

    private

    def session
      @session ||= ::DropboxApi::Client.new(token)
    end

    def token
      JSON.parse(File.read(secrets))['bearer']
    end
  end
end
