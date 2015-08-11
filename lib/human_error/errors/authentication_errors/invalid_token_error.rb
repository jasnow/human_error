require 'human_error/errors/authentication_error'

class   HumanError
module  Errors
class   InvalidTokenError < RuntimeError
  include Error
  include AuthenticationError

  attr_accessor :authentication_token

  def http_status
    401
  end

  def detail
    'The token you attempted to use for this request is invalid for this resource.  ' \
    'Please double-check and try again.'
  end

  def source
    { token: '[FILTERED]' }
  end
end
end
end
