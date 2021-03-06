require 'rspectacular'
require 'human_error/errors/authentication_errors/invalid_username_or_password_error'

class     HumanError
module    Errors
describe  InvalidUsernameOrPasswordError do
  let(:error) { InvalidUsernameOrPasswordError.new }

  it 'has a status of 401' do
    expect(error.http_status).to eql 401
  end

  it 'has a code' do
    expect(error.code).to eql 'errors.invalid_username_or_password_error'
  end

  it 'has a title' do
    expect(error.title).to eql 'Invalid Username/Password'
  end

  it 'can output the detail' do
    expect(error.detail).to eql 'Either the username or password passed in ' \
                                           'or this request is invalid.  Please ' \
                                           'double-check and try again.'
  end

  it 'can output the source' do
    error = InvalidUsernameOrPasswordError.new username: 'neo'

    expect(error.source).to eql(username: 'neo', password: '[FILTERED]')
  end
end
end
end
