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

  it 'can lookup errors' do
    human_error = HumanError.new

    expect(human_error.fetch('RequestError')).to be_a HumanError::Errors::RequestError
  end

  it 'can lookup errors based on the local configuration' do
    human_error = HumanError.new do |config|
      config.api_version = 'foo'
    end

    fetched_error = human_error.fetch('RequestError')

    expect(fetched_error.api_version).to eql 'foo'
  end

  it 'can override values in the global configuration with values in the local configuration when looking up an error' do
    HumanError.configure do |config|
      config.api_version = 'bar'
    end

    human_error = HumanError.new do |config|
      config.api_version = 'foo'
    end

    fetched_error = human_error.fetch('RequestError')

    expect(fetched_error.api_version).to eql 'foo'
  end

  it 'can override values in the local configuration with explicit values passed when looking up an error' do
    human_error = HumanError.new do |config|
      config.api_version = 'foo'
    end

    fetched_error = human_error.fetch('RequestError', api_version: 'bar')

    expect(fetched_error.api_version).to eql 'bar'
  end

  it 'can raise an error' do
    human_error = HumanError.new

    expect { human_error.raise('RequestError') }.to raise_error HumanError::Errors::RequestError
  end
end