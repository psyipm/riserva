require 'spec_helper'

RSpec.describe Riserva::Commands::Backup do
  let(:command) { described_class.new }

  it 'should broadcast ok' do
    allow(command).to receive(:success?).and_return(true)
    expect { command.call }.to broadcast(:ok)
  end

  it 'should broadcast failed' do
    allow(command).to receive(:success?).and_return(false)
    expect { command.call }.to broadcast(:failed)
  end
end
