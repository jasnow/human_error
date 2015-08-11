require 'rspectacular'
require 'human_error/errors/authentication_errors/invalid_username_or_password_error'

class     HumanError
module    Errors
describe  InvalidUsernameOrPasswordError do
  let(:error) { InvalidUsernameOrPasswordError.new }

  it 'has a status of 401' do
    expect(error.http_status).to eql 401
  end

  it 'has a code of 1004' do
    expect(error.code).to eql 1004
  end

  it 'has a knowledgebase article ID of 1234567890' do
    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'can output the developer message' do
    expect(error.detail).to eql 'Either the username or password passed in ' \
                                           'or this request is invalid.  Please ' \
                                           'double-check and try again.'
  end

  it 'can output the developer details' do
    error = InvalidUsernameOrPasswordError.new username: 'neo'

    expect(error.source).to eql(username: 'neo', password: '[FILTERED]')
  end

  it 'can output the friendly message' do
    expect(error.friendly_message).to eql 'Either your email or password is ' \
                                          'incorrect.  Please double-check and try again.'
  end
end
end
end
