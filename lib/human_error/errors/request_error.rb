require 'human_error/error'
require 'human_error/utilities/string'

module  HumanError
module  Errors
class   RequestError < RuntimeError
  include HumanError::Error

  attr_accessor :http_status,
                :developer_message,
                :developer_details,
                :friendly_message

  def as_json(options = {})
    {
      error: {
        status:                      http_status,
        code:                        code,
        developer_documentation_uri: developer_documentation_uri,
        customer_support_uri:        customer_support_uri,
        developer_message_key:       developer_message_key,
        developer_message:           developer_message,
        developer_details:           developer_details,
        friendly_message_key:        friendly_message_key,
        friendly_message:            friendly_message,
      }
    }
  end

  private

  def base_message_key
    HumanError::Utilities::String.
      underscore(self.class.name).
      gsub(%r{\A[^/]+/}, '').
      gsub(%r{[_/]}, '.')
  end

  def developer_message_key
    "#{base_message_key}.developer"
  end

  def friendly_message_key
    "#{base_message_key}.friendly"
  end
end
end
end
