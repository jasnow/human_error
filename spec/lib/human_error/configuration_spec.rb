require 'rspectacular'
require 'human_error/configuration'

class     HumanError
describe  Configuration, singletons: true do
  it 'can set the url mappings' do
    configuration = Configuration.instance
    configuration.url_mappings = 'whateeeeeever'

    expect(configuration.url_mappings).to eql 'whateeeeeever'
  end

  it 'can convert itself into a hash' do
    configuration              = Configuration.instance
    configuration.url_mappings = {
      'external_documentation_urls'  => 'blah',
      'developer_documentation_urls' => 'asdf',
    }

    expect(configuration.to_h).to eql(
      external_documentation_urls:  'blah',
      developer_documentation_urls: 'asdf',
    )
  end
end
end
