require 'rspectacular'
require 'human_error/errors/crud_errors/resource_persistence_error'

module    HumanError
module    Errors
describe  ResourcePersistenceError do
  let(:error) { ResourcePersistenceError.new }

  it 'has a status of 422' do
    expect(error.http_status).to eql 422
  end

  it 'has a code of 1006' do
    expect(error.code).to eql 1006
  end

  it 'has a knowledgebase article ID of 1234567890' do
    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'includes the resource name and action in the developer message' do
    error = ResourcePersistenceError.new resource_name: 'black leather trenchcoat',
                                         action:        'bullet time'

    expect(error.developer_message).to eql "One or more of the attributes on the black leather trenchcoat you attempted to bullet time is invalid."
  end

  it 'includes the resource name and action in the developer details' do
    error = ResourcePersistenceError.new errors:      'lots of errors',
                                         attributes:  'what is the matrix'

    expect(error.developer_details).to eql('errors'     => 'lots of errors',
                                           'attributes' => 'what is the matrix')
  end

  it 'includes the resource name and action in the friendly message' do
    error = ResourcePersistenceError.new resource_name: 'black leather trenchcoat',
                                         action:        'bullet time'

    expect(error.friendly_message).to eql "Sorry! We had a problem when tried to bullet time that black leather trenchcoat."
  end
end
end
end
