require 'human_error/errors/crud_error'
require 'human_error/errors/request_error'

class   HumanError
module  Errors
class   ResourceNotFoundError < RequestError
  include CrudError

  def http_status
    404
  end

  def developer_message
    "The #{resource_name} you attempted to #{action} for this request is either not authorized for the authenticated user or does not exist."
  end

  def developer_details
    { "#{resource_name_underscored}_id" => resource_id }
  end

  def friendly_message
    "Sorry! The #{resource_name} you tried to #{action} does not exist."
  end

  def action
    @action || 'access'
  end
end
end
end
