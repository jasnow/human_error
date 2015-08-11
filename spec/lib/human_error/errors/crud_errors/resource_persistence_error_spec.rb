require 'rspectacular'
require 'human_error/errors/crud_errors/resource_persistence_error'
require 'active_support'
require 'active_model'
require 'active_record/errors'
require 'active_record/validations'

class HumanErrorTestModel
  include ActiveModel::Model
  include ActiveModel::AttributeMethods

  attr_accessor :some_attribute

  validates_presence_of :some_attribute

  def attributes
    {
      'some_attribute' => @some_attribute,
    }
  end
end

class     HumanError
module    Errors
describe  ResourcePersistenceError do
  it 'has a status of 422' do
    error = ResourcePersistenceError.new

    expect(error.http_status).to eql 422
  end

  it 'has a code of 1006' do
    error = ResourcePersistenceError.new

    expect(error.code).to eql 1006
  end

  it 'has a title' do
    error = ResourcePersistenceError.new

    expect(error.title).to eql 'Resource Persistence Error'
  end

  it 'has a knowledgebase article ID of 1234567890' do
    error = ResourcePersistenceError.new

    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'includes the resource name and action in the developer message' do
    error = ResourcePersistenceError.new resource_name: 'black leather trenchcoat',
                                         action:        'bullet time'

    expect(error.detail).to eql 'One or more of the attributes on the black ' \
                                           'leather trenchcoat you attempted to bullet ' \
                                           'time is invalid.'
  end

  it 'includes the resource name and action in the developer details' do
    error = ResourcePersistenceError.new errors:     'lots of errors',
                                         attributes: 'what is the matrix'

    expect(error.source).to eql('errors'     => 'lots of errors',
                                'attributes' => 'what is the matrix')
  end

  it 'can convert an "ActiveRecord::RecordNotSaved"' do
    record                     = HumanErrorTestModel.new
    record.valid?
    resource_persistence_error = ActiveRecord::RecordNotSaved.new('message', record)
    error                      = ResourcePersistenceError.
                                   convert(resource_persistence_error)

    expect(error.attributes).to eql('some_attribute' => nil)
    expect(error.errors).to     eql ["Some attribute can't be blank"]
  end

  it 'can convert an "ActiveRecord::RecordInvalid"' do
    record                     = HumanErrorTestModel.new
    record.valid?
    resource_persistence_error = ActiveRecord::RecordInvalid.new(record)
    error                      = ResourcePersistenceError.
                                   convert(resource_persistence_error)

    expect(error.attributes).to eql('some_attribute' => nil)
    expect(error.errors).to     eql ["Some attribute can't be blank"]
  end
end
end
end
