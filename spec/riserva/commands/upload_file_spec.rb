# frozen_string_literal: true

require 'tempfile'

RSpec.describe Riserva::Commands::UploadFile do
  let(:files_count) { 3 }
  let(:files) { Set.new(Array.new(files_count) { Pathname.new(tmpfile) }) }
  let(:storage) { Riserva::Storage::GoogleDrive.new }
  let(:command) { described_class.new(storage) }

  def tmpfile
    Tempfile.new
  end

  it 'should not be valid if file does not exist' do
    expect { command.call('does/not/exist') }.to broadcast(:invalid)
  end

  it 'should not be success if file upload failed' do
    expect(command).to receive(:upload).and_return(false)
    expect { command.call(tmpfile) }.to broadcast(:failed)
  end

  it 'should not be success if file verification failed' do
    expect(command).to receive(:upload).and_return(true)
    expect(command).to receive(:verify).and_return(false)

    expect { command.call(tmpfile) }.to broadcast(:failed)
  end

  it 'should be success if file uploaded and verified' do
    expect(command).to receive(:upload).and_return(true)
    expect(command).to receive(:verify).and_return(true)

    expect { command.call(tmpfile) }.to broadcast(:ok)
  end

  it 'should store uploaded files list' do
    expect(command).to receive(:success?).at_least(:once).and_return(true)
    expect(files.count).to eq files_count

    files.each { |file| command.call(file) }
    expect(command.files.count).to eq files_count

    expect(files).to eq command.files
  end
end
