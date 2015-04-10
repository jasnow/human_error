require 'human_error/errors/crud_error'
require 'human_error/errors/request_error'

class   HumanError
module  Errors
class   AssociationError < RequestError
  include CrudError

  attr_accessor :association_name,
                :association_id,
                :attributes

  def self.convert(original_error, overrides = {})
    initialization_parameters = {}

    case original_error.class.name
    when 'ActiveRecord::InvalidForeignKey'
      message_info_pattern = /DETAIL:  Key \((.*)_id\)=\(([a-f0-9\-]+)\)/
      message_info         = original_error.
                               message.
                               match(message_info_pattern)[1..-1]

      initialization_parameters = {
        association_name: message_info[0],
        association_id:   message_info[1],
      }
    end

    new(initialization_parameters.merge(overrides))
  end

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
