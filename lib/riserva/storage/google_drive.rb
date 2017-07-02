# frozen_string_literal: true

require 'google_drive'

module Riserva::Storage
  class GoogleDrive
    def initialize(secrets = nil)
      @secrets = secrets || config_secrets
    end

    def upload(local_file, remote_file)
      session.upload_from_file(local_file, remote_file, convert: false)
    end

    def download(remote_file, local_file)
      file = session.file_by_title(remote_file)
      file.download_to_file(local_file)
    end

    private

    def session
      @session ||= ::GoogleDrive::Session.from_service_account_key(@secrets)
    end

    def config_secrets
      Riserva::Config.read('storage.google_drive.secrets')
    end
  end
end
