require 'rspectacular'
require 'human_error/errors/crud_errors/resource_not_found_error'
require 'active_record/errors'

class     HumanError
module    Errors
describe  ResourceNotFoundError do
  it 'has a status of 404' do
    error = ResourceNotFoundError.new

    expect(error.http_status).to eql 404
  end

  it 'has a code' do
    error = ResourceNotFoundError.new

    expect(error.code).to eql 'errors.resource_not_found_error'
  end

  it 'has a title' do
    error = ResourceNotFoundError.new

    expect(error.title).to eql 'Resource Not Found'
  end

  it 'includes the resource name and action in the detail' do
    error = ResourceNotFoundError.new resource_name: 'black leather trenchcoat',
                                      action:        'bullet time'

    expect(error.detail).to eql 'The black leather trenchcoat you attempted ' \
                                           'to bullet time for this request is either ' \
                                           'not authorized for the authenticated user ' \
                                           'or does not exist.'
  end

  it 'includes the resource name and action in the source' do
    error = ResourceNotFoundError.new resource_name: 'black leather trenchcoat',
                                      resource_id:   123

    expect(error.source).to eql('black_leather_trenchcoat_id' => 123)
  end

  it 'can accept an array of IDs' do
    error = ResourceNotFoundError.new resource_name: 'black leather trenchcoat',
                                      resource_id:   %w{123 456}

    expect(error.source).to eql('black_leather_trenchcoat_id' => %w{123 456})
  end

  it 'can convert an "ActiveRecord::RecordNotFound" with no IDs' do
    record_not_found_error = ActiveRecord::RecordNotFound.new \
                               "Couldn't find resource without an ID"
    error                  = ResourceNotFoundError.convert(record_not_found_error)

    expect(error.resource_name).to eql nil
    expect(error.resource_id).to   eql []
  end

  it 'can convert an "ActiveRecord::RecordNotFound" with one ID' do
    record_not_found_error = ActiveRecord::RecordNotFound.new \
                               "Couldn't find resource with 'id'=123"
    error                  = ResourceNotFoundError.convert(record_not_found_error)

    expect(error.resource_name).to eql nil
    expect(error.resource_id).to   eql %w{123}
  end

  it 'can convert an "ActiveRecord::RecordNotFound" with multiple IDs' do
    record_not_found_error = ActiveRecord::RecordNotFound.new \
                               "Couldn't find all resource with 'id': 123, 456, 789"
    error                  = ResourceNotFoundError.convert(record_not_found_error)

    expect(error.resource_name).to eql nil
    expect(error.resource_id).to   eql %w{123 456 789}
  end

  it 'can convert an "ActiveRecord::RecordNotFound" while overriding attributes' do
    record_not_found_error = ActiveRecord::RecordNotFound.new \
                               "Couldn't find resource with 'id'=123"
    error                  = ResourceNotFoundError.convert(record_not_found_error,
                                                           resource_name: 'my_resource')

    expect(error.resource_name).to eql 'my_resource'
    expect(error.resource_id).to   eql %w{123}
  end
end
end
end
