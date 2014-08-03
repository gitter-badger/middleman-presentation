# encoding: utf-8
RSpec.configure do |config|
  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
