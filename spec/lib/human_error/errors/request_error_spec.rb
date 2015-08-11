require 'rspectacular'
require 'human_error/errors/request_error'

class     HumanError
module    Errors
describe  RequestError do
  it 'can generate error data' do
    request_error = RequestError.new(
      http_status:                 'flibbity',
      code:                        'jibbit',
      developer_message:           'I cannot receive any satisfaction',
      source:                      'But perhaps if I attempt it one more time, I can',
      friendly_message:            'receive what I need',
      knowledgebase_article_id:    '87654321',
      api_version:                 'janky',
      api_error_documentation_url: 'asimof',
      knowledgebase_url:           'jinkies')

    expect(request_error.as_json).to eql(
      error: {
        status:                      'flibbity',
        code:                        'jibbit',
        developer_documentation_uri: 'asimof/jibbit?version=janky',
        customer_support_uri:        'jinkies/87654321',
        developer_message_key:       'errors.request.error.developer',
        developer_message:           'I cannot receive any satisfaction',
        developer_details:           'But perhaps if I attempt it one more time, I can',
        friendly_message_key:        'errors.request.error.friendly',
        friendly_message:            'receive what I need',
      })
  end

  it 'can extract configuration from the global config if it is not passed in' do
    HumanError.configure do |config|
      config.api_version                 = 'janky'
      config.api_error_documentation_url = 'asimof'
      config.knowledgebase_url           = 'jinkies'
    end

    request_error = RequestError.new(
      http_status:              'flibbity',
      code:                     'jibbit',
      developer_message:        'I cannot receive any satisfaction',
      source:                   'But perhaps if I attempt it one more time, I can',
      friendly_message:         'receive what I need',
      knowledgebase_article_id: '87654321')

    expect(request_error.as_json).to eql(
      error: {
        status:                      'flibbity',
        code:                        'jibbit',
        developer_documentation_uri: 'asimof/jibbit?version=janky',
        customer_support_uri:        'jinkies/87654321',
        developer_message_key:       'errors.request.error.developer',
        developer_message:           'I cannot receive any satisfaction',
        developer_details:           'But perhaps if I attempt it one more time, I can',
        friendly_message_key:        'errors.request.error.friendly',
        friendly_message:            'receive what I need',
      })
  end

  it 'can override the global config if it is set, but an explicit value is passed in' do
    HumanError.configure do |config|
      config.api_version                 = 'janky'
      config.api_error_documentation_url = 'asimof'
      config.knowledgebase_url           = 'jinkies'
    end

    request_error = RequestError.new(
      http_status:                 'flibbity',
      code:                        'jibbit',
      developer_message:           'I cannot receive any satisfaction',
      source:                      'But perhaps if I attempt it one more time, I can',
      friendly_message:            'receive what I need',
      knowledgebase_article_id:    '87654321',
      api_version:                 'hanky',
      api_error_documentation_url: 'hasimof',
      knowledgebase_url:           'hinkies')

    expect(request_error.as_json).to eql(
      error: {
        status:                      'flibbity',
        code:                        'jibbit',
        developer_documentation_uri: 'hasimof/jibbit?version=hanky',
        customer_support_uri:        'hinkies/87654321',
        developer_message_key:       'errors.request.error.developer',
        developer_message:           'I cannot receive any satisfaction',
        developer_details:           'But perhaps if I attempt it one more time, I can',
        friendly_message_key:        'errors.request.error.friendly',
        friendly_message:            'receive what I need',
      })
  end
end
end
end
