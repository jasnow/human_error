require 'human_error/errors/request_error'
require 'human_error/errors/authentication_error'

class   HumanError
module  Errors
class   InvalidUsernameOrPasswordError < RequestError
  include AuthenticationError

  attr_accessor :username

  def http_status
    401
  end

  def detail
    'Either the username or password passed in or this request is invalid.  Please ' \
    'double-check and try again.'
  end

  def source
    { username: username, password: '[FILTERED]' }
  end

  def friendly_message
    'Either your email or password is incorrect.  Please double-check and try again.'
  end
end
end
end
