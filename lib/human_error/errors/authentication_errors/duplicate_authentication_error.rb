require 'human_error/errors/authentication_error'

class   HumanError
module  Errors
class   DuplicateAuthenticationError < RuntimeError
  include Error
  include AuthenticationError

  attr_accessor :provider,
                :provider_user_id,
                :user_id

  def http_status
    409
  end

  def detail
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
end
end
end
