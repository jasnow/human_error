require 'rspectacular'
require 'human_error/errors/crud_errors/resource_not_found_error'

class     HumanError
module    Errors
describe  ResourceNotFoundError do
  let(:error) { ResourceNotFoundError.new }

  it 'has a status of 404' do
    expect(error.http_status).to eql 404
  end

  it 'has a code of 1005' do
    expect(error.code).to eql 1005
  end

  it 'has a knowledgebase article ID of 1234567890' do
    expect(error.knowledgebase_article_id).to eql '1234567890'
  end

  it 'includes the resource name and action in the developer message' do
    error = ResourceNotFoundError.new resource_name: 'black leather trenchcoat',
                                      action:        'bullet time'

    expect(error.developer_message).to eql "The black leather trenchcoat you attempted to bullet time for this request is either not authorized for the authenticated user or does not exist."
  end

  it 'includes the resource name and action in the developer details' do
    error = ResourceNotFoundError.new resource_name: 'black leather trenchcoat',
                                      resource_id:   123

    expect(error.developer_details).to eql("black_leather_trenchcoat_id" => 123)
  end

  it 'can accept an array of IDs' do
    error = ResourceNotFoundError.new resource_name: 'black leather trenchcoat',
                                      resource_id:   %w{123 456}

    expect(error.developer_details).to eql("black_leather_trenchcoat_id" => %w{123 456})
  end

  it 'includes the resource name and action in the friendly message' do
    error = ResourceNotFoundError.new resource_name: 'black leather trenchcoat',
                                      action:        'bullet time'

    expect(error.friendly_message).to eql "Sorry! The black leather trenchcoat you tried to bullet time does not exist."
  end
end
end
end
