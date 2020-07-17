require 'spec_helper'

RSpec.describe Riserva::Commands::Backup do
  let(:command) { described_class.new }

  it 'should broadcast ok' do
    expect { command.call }.to broadcast(:ok)
  end

  it 'should broadcast `failed` and forward exception' do
    allow(command).to receive(:push_to_cloud).and_raise(StandardError.new('test error'))

    expect { expect { command.call }.to broadcast(:failed) }.to raise_error(StandardError, 'test error')
  end
end
