# frozen_string_literal: true

require 'google_drive'

module Riserva::Storage
  class GoogleDrive < ApplicationStorage
    def upload(local_file, remote_file)
      session.upload_from_file(local_file.to_s, remote_file, convert: false)
    end

    def download(remote_file, local_file)
      file = session.file_by_title(remote_file.to_s)
      file.download_to_file(local_file)
    end

    def verify(remote_file, local_file)
      file = session.file_by_title(remote_file.to_s)
      checksum = Digest::MD5.hexdigest(IO.read(local_file))

      file.md5_checksum == checksum
    end

    def clean
      return unless time_to_keep

      session.files.each do |file|
        file.delete if file.created_time < time_to_keep.ago
      end
    end

    private

    def session
      @session ||= ::GoogleDrive::Session.from_service_account_key(secrets)
    end
  end
end
