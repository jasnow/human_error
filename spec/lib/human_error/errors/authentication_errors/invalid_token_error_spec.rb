require 'rspectacular'
require 'human_error/errors/authentication_errors/invalid_token_error'

class     HumanError
module    Errors
describe  InvalidTokenError do
  let(:error) { InvalidTokenError.new }

  it 'has a status of 401' do
    expect(error.http_status).to eql 401
  end

  it 'has a code of 1003' do
    expect(error.code).to eql 1003
  end

  it 'has a knowledgebase article ID of 1234567890' do
    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'can output the developer message' do
    expect(error.developer_message).to eql 'The token you attempted to use for this request is invalid for this resource.  Please double-check and try again.'
  end

  it 'can output the developer details' do
    expect(error.developer_details).to eql(token: '[FILTERED]')
  end

  it 'can output the friendly message' do
    expect(error.friendly_message).to eql 'Sorry! You are not authorized to view this.'
  end
end
end
end
