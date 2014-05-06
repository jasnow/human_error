require 'rspectacular'
require 'human_error'

describe HumanError do
  it 'can create an instance of HumanError' do
    expect(HumanError.new).to be_a HumanError
  end

  it 'can configure each instance' do
    human_error = HumanError.new do |config|
                    config.api_version = 'foo'
                  end

    expect(human_error.configuration.api_version).to eql 'foo'
  end
end
