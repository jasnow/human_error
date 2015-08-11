require 'rspectacular'
require 'human_error'
require 'active_record/errors'

describe HumanError do
  let(:original_error) do
    ActiveRecord::RecordNotFound.new("Couldn't find resource with 'id'=3")
  end

  it 'can lookup errors' do
    expect(HumanError.fetch('InvalidTokenError')).to eql HumanError::Errors::InvalidTokenError
  end

  it 'can raise an error' do
    expect { HumanError.raise('InvalidTokenError') }.to \
      raise_error HumanError::Errors::InvalidTokenError
  end
end
