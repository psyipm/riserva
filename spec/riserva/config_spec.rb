# frozen_string_literal: true

RSpec.describe Riserva::Config do
  it 'should config value by yaml path' do
    path = described_class.read('storage.google_drive.secrets')
    expect(path).to match(/google_drive_secrets.json/)
  end

  it 'should read folders' do
    described_class.folders.each do |folder|
      expect(folder.is_a?(Pathname)).to eq true
    end
  end

  it 'should read storages' do
    described_class.storages.each do |storage|
      expect(storage.is_a?(Riserva::Storage::ApplicationStorage)).to eq true
    end
  end
end
