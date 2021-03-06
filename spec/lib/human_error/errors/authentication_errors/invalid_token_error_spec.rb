require 'rspectacular'
require 'human_error/errors/authentication_errors/invalid_token_error'

class     HumanError
module    Errors
describe  InvalidTokenError do
  let(:error) { InvalidTokenError.new }

  it 'has a status of 401' do
    expect(error.http_status).to eql 401
  end

  it 'has a code' do
    expect(error.code).to eql 'errors.invalid_token_error'
  end

  it 'has a title' do
    expect(error.title).to eql 'Invalid Token'
  end

  it 'can output the detail' do
    expect(error.detail).to eql 'The token you attempted to use for this ' \
                                           'request is invalid for this resource.  ' \
                                           'Please double-check and try again.'
  end

  it 'can output the source' do
    expect(error.source).to eql(token: '[FILTERED]')
  end
end
end
end
