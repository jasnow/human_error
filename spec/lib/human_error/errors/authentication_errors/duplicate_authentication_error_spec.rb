require 'rspectacular'
require 'human_error/errors/authentication_errors/duplicate_authentication_error'

class     HumanError
module    Errors
describe  DuplicateAuthenticationError do
  let(:error) do
    DuplicateAuthenticationError.new(provider:         'flibbity',
                                     provider_user_id: '12345',
                                     user_id:          '54321')
  end

  it 'has a status of 409' do
    expect(error.http_status).to eql 409
  end

  it 'has a code' do
    expect(error.code).to eql 'errors.duplicate_authentication_error'
  end

  it 'has a title' do
    expect(error.title).to eql 'Duplicate Authentication'
  end

  it 'can output the developer message' do
    expect(error.detail).to eql 'The authentication you attempted to ' \
                                           'register has already been registered by ' \
                                           'another user. We do not currently support ' \
                                           'allowing multiple users to be connected to ' \
                                           'the same authentication.'
  end

  it 'can output the developer details' do
    expect(error.source).to eql(
              'provider'         => 'flibbity',
              'provider_user_id' => '12345',
              'user_id'          => '54321',
    )
  end
end
end
end
