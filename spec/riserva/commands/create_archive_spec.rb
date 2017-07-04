require 'spec_helper'

RSpec.describe Riserva::Commands::CreateArchive do
  let(:command) { described_class.new }
  let(:tmpdir) { mktmpdir }

  def mktmpdir
    Pathname.new(Dir.mktmpdir)
  end

  before(:each) do
    expect(command).to receive(:create_archive).at_least(:once).and_return(true)
  end

  it 'should create archive with valid location' do
    command.call(tmpdir)
    expect(command.files.first).to match("#{tmpdir.basename}.tar.bz2")
  end

  it 'should store a list of created files' do
    dirs = Array.new(3) { mktmpdir }
    expect(dirs.uniq.count).to eq 3

    dirs.each { |dir| command.call(dir) }

    expect(command.files.count).to eq 3
    dirs.each do |dir|
      files = command.files.grep Regexp.new(dir.basename.to_s)
      expect(files.count).to eq 1
    end
  end
end
