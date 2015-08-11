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
end
end
end
