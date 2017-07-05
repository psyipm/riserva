require 'wisper'

module Riserva::Listeners
  class ApplicationListener
    attr_reader :files

    def initialize
      @files = Set.new
    end

    def ok(file)
      @files << Pathname.new(file)
    end
  end
end
