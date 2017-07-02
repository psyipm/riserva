module Riserva::Commands
  class CreateArchive < ApplicationCommand
    attr_reader :archive_name

    def initialize(path = nil)
      build_path(path)
      subscribe(Riserva::Listeners::CreateArchive.new)
    end

    def call(path = nil)
      build_path(path)
      return broadcast(:invalid) unless valid?

      file = archive_name

      create_archive(file) ? broadcast(:ok, file) : broadcast(:failed)
    end

    private

    def build_path(path = nil)
      @path = Pathname.new(path) unless path.nil?
    end

    def valid?
      @path.directory?
    end

    def create_archive(file)
      system("tar cjf #{file} -C #{@path.parent} #{@path.basename}")
    end

    def archive_name
      time_prefix = Time.now.getlocal.strftime('%Y%m%d_%H%M')
      filename = @path.basename.to_s.downcase

      File.join(archive_location, "#{time_prefix}_#{filename}.tar.bz2")
    end

    def archive_location
      location = Pathname.new(Riserva::Config.read('storage_location'))
      location.mkpath unless location.exist?
      location
    end
  end
end
