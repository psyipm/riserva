RSpec.describe Riserva::Commands::Clean do
  subject(:command) { described_class.new }

  let(:google_drive) { spy("GoogleDrive", clean: true) }
  let(:dropbox) { spy("Dropbox", clean: true) }

  before do
    allow(command).to receive(:storages) { [google_drive, dropbox] }
  end

  it "broadcasts ok" do
    expect { command.call }.to broadcast(:ok)
  end

  it "broadcasts failed" do
    allow(dropbox).to receive(:clean) { false }

    expect { command.call }.to broadcast(:failed, dropbox)
  end
end
