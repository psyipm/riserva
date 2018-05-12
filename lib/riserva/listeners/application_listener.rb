require 'wisper'

module Riserva::Listeners
  class ApplicationListener
    attr_reader :files

    def initialize
      @files = Set.new
    end

    def ok(file)
      @files << Pathname.new(file)

      Riserva.logger.info(progname) { "OK: #{file}" }
    end

    def failed
      Riserva.logger.error(progname) { 'Failed' }
    end

    protected

    def progname
      self.class.name.split('::').last
    end
  end
end
