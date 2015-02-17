require 'human_error/errors/crud_error'
require 'human_error/errors/request_error'

class   HumanError
module  Errors
class   AssociationError < RequestError
  include CrudError

  attr_accessor :association_name,
                :association_id,
                :attributes

  def http_status
    422
  end

  def developer_message
    "The #{association_name} that you attempted to associate with " \
    "the #{resource_name} was not valid."
  end

  def developer_details
    {
      resource_name            => attributes,
      "#{association_name} id" => association_id,
    }
  end

  def friendly_message
    "Sorry! There was a problem when we tried to set the #{association_name} on " \
    "that #{resource_name}."
  end
end
end
end
