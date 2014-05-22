require 'rspectacular'
require 'human_error/errors/crud_errors/association_error'

class     HumanError
module    Errors
describe  AssociationError do
  let(:error) { AssociationError.new }

  it 'has a status of 422' do
    expect(error.http_status).to eql 422
  end

  it 'has a code of 1009' do
    expect(error.code).to eql 1009
  end

  it 'has a knowledgebase article ID of 1234567890' do
    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'includes the resource name and action in the developer message' do
    error = AssociationError.new association_name: 'black leather trenchcoat',
                                 resource_name:    'Neo'

    expect(error.developer_message).to eql "The black leather trenchcoat that you attempted to associate with the Neo was not valid."
  end

  it 'includes the resource name and action in the developer details' do
    error = AssociationError.new association_name: 'black leather trenchcoat',
                                 resource_name:    'Neo',
                                 attributes:       'what is the matrix',
                                 association_id:   '123'

    expect(error.developer_details).to eql(
      'Neo'                         => 'what is the matrix',
      'black leather trenchcoat id' => '123',
    )
  end

  it 'includes the resource name and action in the friendly message' do
    error = AssociationError.new association_name: 'black leather trenchcoat',
                                 resource_name:    'Neo'

    expect(error.friendly_message).to eql "Sorry! There was a problem when we tried to set the black leather trenchcoat on that Neo."
  end
end
end
end
