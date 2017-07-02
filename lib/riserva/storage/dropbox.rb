# frozen_string_literal: true

require 'json'
require 'dropbox_api'

module Riserva::Storage
  class Dropbox
    def initialize(secrets = nil)
      @secrets = secrets || config_secrets
    end

    def upload(local_file, remote_file)
      session.upload(
        File.join(upload_path, remote_file),
        IO.read(local_file)
      )
    end

    def download(remote_file, local_file)
      session.download(File.join(upload_path, remote_file)) do |stream|
        Pathname.new(local_file).write(stream)
      end
    end

    private

    def session
      @session ||= ::DropboxApi::Client.new(token)
    end

    def token
      JSON.parse(File.read(@secrets))['bearer']
    end

    def config_secrets
      Riserva::Config.read('storage.dropbox.secrets')
    end

    def upload_path
      Riserva::Config.read('storage.dropbox.upload_path')
    end
  end
end
