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
      id:                          'identifier',
      http_status:                 'flibbity',
      code:                        'jibbit',
      title:                       'roll dem bones and stones',
      detail:                      'I cannot receive any satisfaction',
      source:                      'But perhaps if I attempt it one more time, I can',
      developer_documentation_url: 'asimof/jibbit?version=janky',
      external_documentation_url:  'jinkies/87654321',
      knowledgebase_article_id:    '87654321',
      api_version:                 'janky',
      api_error_documentation_url: 'asimof',
      knowledgebase_url:           'jinkies')

    expect(custom_error.as_json).to eql(
      errors: [
        {
          id:     'identifier',
          links:  {
            about:         'jinkies/87654321',
            documentation: 'asimof/jibbit?version=janky',
          },
          status: 'flibbity',
          code:   'jibbit',
          title:  'roll dem bones and stones',
          detail: 'I cannot receive any satisfaction',
          source: 'But perhaps if I attempt it one more time, I can',
        }
      ])
  end

  it 'can extract configuration from the global config if it is not passed in',
     singletons: HumanError::Configuration do

    HumanError.configure do |config|
      config.url_mappings = {
        'external_documentation_urls' => {
          'jibbit' => 'http://example.com/edu',
        },
        'developer_documentation_urls' => {
          'jibbit' => 'http://example.com/ddu',
        },
      }
    end

    custom_error = CustomError.new(
      id:                          'identifier',
      http_status:              'flibbity',
      code:                     'jibbit',
      title:                    'roll dem bones and stones',
      detail:                   'I cannot receive any satisfaction',
      source:                   'But perhaps if I attempt it one more time, I can',
      knowledgebase_article_id: '87654321')

    expect(custom_error.as_json).to eql(
      errors: [
        {
          id:     'identifier',
          links:  {
            about:         'http://example.com/edu',
            documentation: 'http://example.com/ddu',
          },
          status: 'flibbity',
          code:   'jibbit',
          title:  'roll dem bones and stones',
          detail: 'I cannot receive any satisfaction',
          source: 'But perhaps if I attempt it one more time, I can',
        }
      ])
  end

  it 'can override the global config if it is set, but an explicit value is passed in',
     singletons: HumanError::Configuration do

    HumanError.configure do |config|
      config.url_mappings = {
        'external_documentation_urls' => {
          'jibbit' => 'http://example.com/edu',
        },
        'developer_documentation_urls' => {
          'jibbit' => 'http://example.com/ddu',
        },
      }
    end

    custom_error = CustomError.new(
      id:                          'identifier',
      http_status:                 'flibbity',
      code:                        'jibbit',
      title:                       'roll dem bones and stones',
      detail:                      'I cannot receive any satisfaction',
      source:                      'But perhaps if I attempt it one more time, I can',
      developer_documentation_url: 'hasimof/jibbit?version=hanky',
      external_documentation_url:  'hinkies/87654321',
      knowledgebase_article_id:    '87654321',
      api_version:                 'hanky',
      api_error_documentation_url: 'hasimof',
      knowledgebase_url:           'hinkies')

    expect(custom_error.as_json).to eql(
      errors: [
        {
          id:     'identifier',
          links:  {
            about:         'hinkies/87654321',
            documentation: 'hasimof/jibbit?version=hanky',
          },
          status: 'flibbity',
          code:   'jibbit',
          title:  'roll dem bones and stones',
          detail: 'I cannot receive any satisfaction',
          source: 'But perhaps if I attempt it one more time, I can',
        }
      ])
  end

  it 'can handle if it finds no URL mappings' do
    custom_error = CustomError.new(
      id:                          'identifier',
      http_status:                 'flibbity',
      code:                        'jibbit',
      title:                       'roll dem bones and stones',
      detail:                      'I cannot receive any satisfaction',
      source:                      'But perhaps if I attempt it one more time, I can',
      knowledgebase_article_id:    '87654321',
      api_version:                 'hanky',
      api_error_documentation_url: 'hasimof',
      knowledgebase_url:           'hinkies')

    expect(custom_error.as_json).to eql(
      errors: [
        {
          id:     'identifier',
          links:  {
            about:         nil,
            documentation: nil,
          },
          status: 'flibbity',
          code:   'jibbit',
          title:  'roll dem bones and stones',
          detail: 'I cannot receive any satisfaction',
          source: 'But perhaps if I attempt it one more time, I can',
        }
      ])
  end
end
end
