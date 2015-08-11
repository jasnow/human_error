require 'human_error/error'

class   HumanError
module  Errors
class   RequestError < RuntimeError
  include HumanError::Error

  attr_accessor :http_status,
                :detail,
                :source

  def as_json(_options = {})
    {
      error: {
        status:                      http_status,
        code:                        code,
        developer_documentation_uri: developer_documentation_uri,
        customer_support_uri:        customer_support_uri,
        developer_message:           detail,
        developer_details:           source,
      },
    }
  end
end
end
end
