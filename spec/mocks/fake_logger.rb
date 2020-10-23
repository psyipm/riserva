# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    allow(Riserva).to receive(:logger) { spy("Riserva::Log") }
  end
end
