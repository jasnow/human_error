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
                    config.url_mappings = 'foo'
    end

    expect(human_error.configuration.url_mappings).to eql 'foo'
  end

  it 'can lookup errors' do
    human_error = HumanError.new

    expect(human_error.fetch('InvalidTokenError')).to eql HumanError::Errors::InvalidTokenError
  end

  it 'can raise an error' do
    human_error = HumanError.new

    expect { human_error.raise('InvalidTokenError') }.to \
      raise_error HumanError::Errors::InvalidTokenError
  end
end
