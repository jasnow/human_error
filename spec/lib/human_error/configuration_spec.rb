require 'rspectacular'
require 'human_error/configuration'

class     HumanError
describe  Configuration, singletons: true do
  it 'can set the API version' do
    configuration = Configuration.instance
    configuration.api_version = 'whateeeeeever'

    expect(configuration.api_version).to eql 'whateeeeeever'
  end

  it 'can set the API error documentation URL' do
    configuration = Configuration.instance
    configuration.api_error_documentation_url = 'whateeeeeever'

    expect(configuration.api_error_documentation_url).to eql 'whateeeeeever'
  end

  it 'can set the knowledgebase URL' do
    configuration = Configuration.instance
    configuration.knowledgebase_url = 'whateeeeeever'

    expect(configuration.knowledgebase_url).to eql 'whateeeeeever'
  end

  it 'can convert itself into a hash' do
    configuration                             = Configuration.instance
    configuration.knowledgebase_url           = 'knowledgebase_url'
    configuration.api_error_documentation_url = 'api_error_documentation_url'
    configuration.api_version                 = 'api_version'

    expect(configuration.to_h).to eql(
      knowledgebase_url:           'knowledgebase_url',
      api_error_documentation_url: 'api_error_documentation_url',
      api_version:                 'api_version')
  end
end
end
