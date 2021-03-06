require 'human_error/errors/crud_error'

class   HumanError
module  Errors
class   AssociationError < RuntimeError
  include Error
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

  def title
    'Association Error'
  end

  def detail
    "The #{association_name} that you attempted to associate with " \
    "the #{resource_name} was not valid."
  end

  def source
    {
      resource_name            => attributes,
      "#{association_name} id" => association_id,
    }
  end
end
end
end
