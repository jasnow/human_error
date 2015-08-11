require 'rspectacular'
require 'human_error/error'

class CustomError < RuntimeError
  include HumanError::Error
end

class     HumanError
describe  Error do
  it 'can wrap an error with another error' do
    original_error = RuntimeError.new('My Runtime Error Message')
    wrapped_error  = CustomError.wrap(original_error)

    expect(wrapped_error.class.name).to eql 'CustomError'
  end

  it 'can wrap the message of an error by identifying the original error type' do
    original_error = RuntimeError.new('My Runtime Error Message')
    wrapped_error  = CustomError.wrap(original_error)

    expect(wrapped_error.message).to eql 'RuntimeError: My Runtime Error Message'
  end

  it 'can transfer the backtrace of the original error to the wrapped error' do
    original_error = RuntimeError.new('My Runtime Error Message')
    original_error.set_backtrace %w{foo bar baz}
    wrapped_error = CustomError.wrap(original_error)

    expect(wrapped_error.backtrace).to eql %w{foo bar baz}
  end

  it 'can have its message explicitly set when it is generated' do
    error = CustomError.new(message: 'My Message')

    expect(error.message).to eql 'My Message'
  end

  it 'can have its message explicitly set when it is generated' do
    error = CustomError.new
    allow(error).to receive(:detail).
                    and_return('My Developer Message')

    expect(error.message).to eql 'My Developer Message'
  end

  it 'can generate error data' do
    custom_error = CustomError.new(
      http_status:                 'flibbity',
      code:                        'jibbit',
      detail:                      'I cannot receive any satisfaction',
      source:                      'But perhaps if I attempt it one more time, I can',
      knowledgebase_article_id:    '87654321',
      api_version:                 'janky',
      api_error_documentation_url: 'asimof',
      knowledgebase_url:           'jinkies')

    expect(custom_error.as_json).to eql(
      error: {
        status:                      'flibbity',
        code:                        'jibbit',
        developer_documentation_uri: 'asimof/jibbit?version=janky',
        customer_support_uri:        'jinkies/87654321',
        developer_message:           'I cannot receive any satisfaction',
        developer_details:           'But perhaps if I attempt it one more time, I can',
      })
  end

  it 'can extract configuration from the global config if it is not passed in' do
    HumanError.configure do |config|
      config.api_version                 = 'janky'
      config.api_error_documentation_url = 'asimof'
      config.knowledgebase_url           = 'jinkies'
    end

    custom_error = CustomError.new(
      http_status:              'flibbity',
      code:                     'jibbit',
      detail:                   'I cannot receive any satisfaction',
      source:                   'But perhaps if I attempt it one more time, I can',
      knowledgebase_article_id: '87654321')

    expect(custom_error.as_json).to eql(
      error: {
        status:                      'flibbity',
        code:                        'jibbit',
        developer_documentation_uri: 'asimof/jibbit?version=janky',
        customer_support_uri:        'jinkies/87654321',
        developer_message:           'I cannot receive any satisfaction',
        developer_details:           'But perhaps if I attempt it one more time, I can',
      })
  end

  it 'can override the global config if it is set, but an explicit value is passed in' do
    HumanError.configure do |config|
      config.api_version                 = 'janky'
      config.api_error_documentation_url = 'asimof'
      config.knowledgebase_url           = 'jinkies'
    end

    custom_error = CustomError.new(
      http_status:                 'flibbity',
      code:                        'jibbit',
      detail:                      'I cannot receive any satisfaction',
      source:                      'But perhaps if I attempt it one more time, I can',
      knowledgebase_article_id:    '87654321',
      api_version:                 'hanky',
      api_error_documentation_url: 'hasimof',
      knowledgebase_url:           'hinkies')

    expect(custom_error.as_json).to eql(
      error: {
        status:                      'flibbity',
        code:                        'jibbit',
        developer_documentation_uri: 'hasimof/jibbit?version=hanky',
        customer_support_uri:        'hinkies/87654321',
        developer_message:           'I cannot receive any satisfaction',
        developer_details:           'But perhaps if I attempt it one more time, I can',
      })
  end
end
end
