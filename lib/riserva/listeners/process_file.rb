module Riserva::Listeners
  class ProcessFile < ApplicationListener
    attr_reader :files

    def initialize
      @files = Set.new
    end

    def ok(file)
      @files << Pathname.new(file)
    end
  end
end
