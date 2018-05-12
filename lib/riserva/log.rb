# frozen_string_literal: true

require 'logger'

module Riserva
  class Log
    attr_reader :logger

    def initialize
      @logger = Logger.new(
        Riserva::Config.read('log.filename') || STDOUT,
        Riserva::Config.read('log.files_to_keep') || 1,
        Riserva::Config.read('log.size') || 100 * 1024
      )

      @logger.datetime_format = datetime_format
      @logger.formatter = formatter
    end

    private

    def formatter
      proc do |severity, datetime, progname, msg|
        "[#{datetime}] #{severity} -- #{progname}: #{msg}\n"
      end
    end

    def datetime_format
      Riserva::Config.read('log.datetime_format') || '%Y-%m-%d %H:%M:%S %Z'
    end
  end
end
