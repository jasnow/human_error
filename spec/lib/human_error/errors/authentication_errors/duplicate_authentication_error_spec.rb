require 'rspectacular'
require 'human_error/errors/authentication_errors/duplicate_authentication_error'

class     HumanError
module    Errors
describe  DuplicateAuthenticationError do
  let(:error) { DuplicateAuthenticationError.new(provider:         'flibbity',
                                                 provider_user_id: '12345',
                                                 user_id:          '54321',) }

  it 'has a status of 409' do
    expect(error.http_status).to eql 409
  end

  it 'has a code of 1008' do
    expect(error.code).to eql 1008
  end

  it 'has a knowledgebase article ID of 1234567890' do
    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'can output the developer message' do
    expect(error.developer_message).to eql 'The authentication you attempted to register has already been registered by another user. We do not currently support allowing multiple users to be connected to the same authentication.'
  end

  it 'can output the developer details' do
    expect(error.developer_details).to eql(
      {
        'provider'          => 'flibbity',
        'provider_user_id'  => '12345',
        'user_id'           => '54321',
      }
    )
  end

  it 'can output the friendly message' do
    expect(error.friendly_message).to eql 'Sorry! Someone else has already registered this flibbity login.'
  end
end
end
end
