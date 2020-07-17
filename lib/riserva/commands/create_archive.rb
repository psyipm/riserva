module Riserva::Commands
  class CreateArchive < ApplicationCommand
    def call(path)
      broadcast(:start, "folder: #{path}")
      return broadcast(:invalid, "`#{@path}` is not a directory") unless super

      file = archive_name
      create_archive(file) ? broadcast(:ok, file) : broadcast(:failed)
    end

    private

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
