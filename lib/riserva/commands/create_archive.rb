module Riserva::Commands
  class CreateArchive < ApplicationCommand
    attr_reader :archive_name

    def initialize(path)
      @path = Pathname.new(path)
    end

    def call
      return broadcast(:invalid) unless valid?

      if create_archive
        broadcast(:ok, @archive_name)
      else
        broadcast(:failed)
      end
    end

    private

    def valid?
      @path.directory?
    end

    def create_archive
      system("tar cjf #{archive_name} -C #{@path.parent} #{@path.basename}")
    end

    def archive_name
      time_prefix = Time.now.getlocal.strftime('%Y%m%d_%H%M')
      filename = @path.basename.to_s.downcase

      @archive_name ||= File.join(archive_location, "#{time_prefix}_#{filename}.tar.bz2")
    end

    def archive_location
      location = Pathname.new(Riserva::Config.read('storage_location'))
      location.mkpath unless location.exist?
      location
    end
  end
end
