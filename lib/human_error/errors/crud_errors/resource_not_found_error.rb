require 'human_error/errors/crud_error'
require 'human_error/errors/request_error'

module  HumanError
module  Errors
class   ResourceNotFoundError < RequestError
  include CrudError

  def http_status
    404
  end

  def knowledgebase_article_id
    '1234567890'
  end

  def developer_message
    "The #{resource_name} you attempted to #{action} for this request is either not authorized for the authenticated user or does not exist."
  end

  def developer_details
    { "#{resource_name}_id" => resource_id }
  end

  def friendly_message
    "Sorry! The #{resource_name} you tried to #{action} does not exist."
  end
end
end
end
