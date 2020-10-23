# frozen_string_literal: true

RSpec.describe Riserva do
  it 'has a version number' do
    expect(Riserva::VERSION).not_to be nil
  end

  it 'requires activesupport time' do
    expect { 1.day.ago }.to_not raise_error
  end
end
