# frozen_string_literal: true

require 'bundler/setup'
require 'riserva'
require 'wisper/rspec/matchers'
require 'mocks/fake_logger'

require 'pry-byebug'

ENV['RISERVA_CONFIG'] = 'spec/mocks/config/riserva.yml'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include(Wisper::RSpec::BroadcastMatcher)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
