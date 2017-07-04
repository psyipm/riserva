require 'spec_helper'
require 'tempfile'

RSpec.describe Riserva::Commands::PushToCloud do
  let(:files_count) { 3 }
  let(:files) { Set.new(Array.new(files_count) { Pathname.new(tmpfile) }) }
  let(:storage) { object_double(Riserva::Storage::Dropbox.new, upload: true, verify: true) }
  let(:command) { described_class.new(files) }

  def tmpfile
    Tempfile.new
  end

  it 'should not be valid if file does not exist' do
    files << 'does/not/exist'
    command = described_class.new(files)

    expect { command.call(storage) }.to broadcast(:invalid)
  end

  it 'should be success if all files uploaded' do
    expect { command.call(storage) }.to broadcast(:ok, command)
    expect(command.success?).to eq true
  end

  it 'should broadcast failed if not all files uploaded' do
    expect(command).to receive(:success?).and_return(false)
    expect { command.call(storage) }.to broadcast(:failed, command)
  end
end
