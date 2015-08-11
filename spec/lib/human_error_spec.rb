require 'rspectacular'
require 'human_error'
require 'active_record/errors'

describe HumanError do
  let(:original_error) do
    ActiveRecord::RecordNotFound.new("Couldn't find resource with 'id'=3")
  end

  it 'can create an instance of HumanError' do
    expect(HumanError.new).to be_a HumanError
  end

  it 'can configure each instance', singletons: HumanError::Configuration do
    human_error = HumanError.new do |config|
                    config.api_version = 'foo'
    end

    expect(human_error.configuration.api_version).to eql 'foo'
  end

  it 'can lookup errors' do
    human_error = HumanError.new

    expect(human_error.fetch('InvalidTokenError')).to eql HumanError::Errors::InvalidTokenError
  end

  it 'can lookup errors based on the local configuration', singletons: HumanError::Configuration do
    human_error = HumanError.new do |config|
      config.api_version = 'foo'
    end

    fetched_error = human_error.convert(original_error)

    expect(fetched_error.api_version).to eql 'foo'
  end

  it 'can override values in the global configuration with values in the local' \
     'configuration when looking up an error', singletons: HumanError::Configuration do

    HumanError.configure do |config|
      config.api_version = 'bar'
    end

    human_error = HumanError.new do |config|
      config.api_version = 'foo'
    end

    fetched_error = human_error.convert(original_error)

    expect(fetched_error.api_version).to eql 'foo'
  end

  it 'can override values in the local configuration with explicit values passed when' \
     'looking up an error', singletons: HumanError::Configuration do

    human_error = HumanError.new do |config|
      config.api_version = 'foo'
    end

    fetched_error = human_error.convert(original_error, api_version: 'bar')

    expect(fetched_error.api_version).to eql 'bar'
  end

  it 'can raise an error' do
    human_error = HumanError.new

    expect { human_error.raise('InvalidTokenError') }.to \
      raise_error HumanError::Errors::InvalidTokenError
  end
end
