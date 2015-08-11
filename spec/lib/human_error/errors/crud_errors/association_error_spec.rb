require 'rspectacular'
require 'human_error/errors/crud_errors/association_error'
require 'active_record/errors'

class     HumanError
module    Errors
describe  AssociationError do
  let(:foreign_key_error) do
    ActiveRecord::InvalidForeignKey.new('DETAIL:  Key (resource_id)=(123)')
  end

  it 'has a status of 422' do
    error = AssociationError.new

    expect(error.http_status).to eql 422
  end

  it 'has a code' do
    error = AssociationError.new

    expect(error.code).to eql 'errors.association.error'
  end

  it 'has a title' do
    error = AssociationError.new

    expect(error.title).to eql 'Association Error'
  end

  it 'has a knowledgebase article ID of 1234567890' do
    error = AssociationError.new

    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'includes the resource name and action in the developer message' do
    error = AssociationError.new association_name: 'black leather trenchcoat',
                                 resource_name:    'Neo'

    expect(error.detail).to eql 'The black leather trenchcoat that you ' \
                                           'attempted to associate with the Neo was ' \
                                           'not valid.'
  end

  it 'includes the resource name and action in the developer details' do
    error = AssociationError.new association_name: 'black leather trenchcoat',
                                 resource_name:    'Neo',
                                 attributes:       'what is the matrix',
                                 association_id:   '123'

    expect(error.source).to eql(
      'Neo'                         => 'what is the matrix',
      'black leather trenchcoat id' => '123',
    )
  end

  it 'can convert an "ActiveRecord::InvalidForeignKey"' do
    error = AssociationError.convert(foreign_key_error)

    expect(error.resource_name).to    eql nil
    expect(error.association_name).to eql 'resource'
    expect(error.association_id).to   eql '123'
  end

  it 'can convert an "ActiveRecord::InvalidForeignKey" while overriding attributes' do
    error = AssociationError.convert(foreign_key_error, resource_name: 'my_resource')

    expect(error.resource_name).to    eql 'my_resource'
    expect(error.association_name).to eql 'resource'
    expect(error.association_id).to   eql '123'
  end
end
end
end
