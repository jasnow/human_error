require 'rspectacular'
require 'human_error/configuration'

module    HumanError
describe  Configuration do
  it 'can set the API version' do
    configuration = Configuration.new
    configuration.api_version = 'whateeeeeever'

    expect(configuration.api_version).to eql 'whateeeeeever'
  end

  it 'can set the API error documentation URL' do
    configuration = Configuration.new
    configuration.api_error_documentation_url = 'whateeeeeever'

    expect(configuration.api_error_documentation_url).to eql 'whateeeeeever'
  end

  it 'can set the knowledgebase URL' do
    configuration = Configuration.new
    configuration.knowledgebase_url = 'whateeeeeever'

    expect(configuration.knowledgebase_url).to eql 'whateeeeeever'
  end
end
end
