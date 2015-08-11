require 'human_error/errors/request_error'
require 'human_error/errors/authentication_error'

class   HumanError
module  Errors
class   DuplicateAuthenticationError < RequestError
  include AuthenticationError

  attr_accessor :provider,
                :provider_user_id,
                :user_id

  def http_status
    409
  end

  def developer_message
    'The authentication you attempted to register has already been registered by ' \
    'another user. We do not currently support allowing multiple users to be connected ' \
    'to the same authentication.'
  end

  def source
    {
      'provider'         => provider,
      'provider_user_id' => provider_user_id,
      'user_id'          => user_id,
    }
  end

  def friendly_message
    "Sorry! Someone else has already registered this #{provider} login."
  end
end
end
end
