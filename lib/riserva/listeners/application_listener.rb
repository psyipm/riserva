require 'wisper'

module Riserva::Listeners
  class ApplicationListener
    attr_reader :files

    def initialize
      @files = Set.new
    end

    def start(*args)
      Riserva.logger.info(progname) { ['Starting', *args].join(': ') }
    end

    def ok(file, *args)
      @files << Pathname.new(file)

      Riserva.logger.info(progname) { ["OK: #{file}", *args].join(': ') }
    end

    def invalid(message = nil)
      Riserva.logger.debug(progname) { ['Invalid', message].compact.join(': ') }
    end

    def failed(file = nil)
      Riserva.logger.error(progname) { ['Failed', file].compact.join(': ') }
    end

    protected

    def progname
      command = self.class.name.split('::').last
      worker = Parallel.worker_number.presence

      [command, worker].compact.join(' ')
    end
  end
end
