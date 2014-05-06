require 'human_error/errors/crud_error'
require 'human_error/errors/request_error'

module  HumanError
module  Errors
class   ResourcePersistenceError < RequestError
  include CrudError

  attr_accessor :errors,
                :attributes

  def http_status
    422
  end

  def knowledgebase_article_id
    '1234567890'
  end

  def developer_message
    "One or more of the attributes on the #{resource_name} you attempted to #{action} is invalid."
  end

  def developer_details
    {
      'errors'     => errors,
      'attributes' => attributes,
    }
  end

  def friendly_message
    "Sorry! We had a problem when tried to #{action} that #{resource_name}."
  end
end
end
end
