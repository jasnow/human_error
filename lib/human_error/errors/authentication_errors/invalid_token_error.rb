require 'human_error/errors/request_error'
require 'human_error/errors/authentication_error'

class   HumanError
module  Errors
class   InvalidTokenError < RequestError
  include AuthenticationError

  attr_accessor :authentication_token

  def http_status
    401
  end

  def developer_message
    'The token you attempted to use for this request is invalid for this resource.  Please double-check and try again.'
  end

  def developer_details
    { token: '[FILTERED]' }
  end

  def friendly_message
    'Sorry! You are not authorized to view this.'
  end
end
end
end
