require 'human_error/error'

class   HumanError
module  Errors
class   RequestError < RuntimeError
  include HumanError::Error
end
end
end
