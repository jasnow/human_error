require 'human_error/errors/crud_error'
require 'human_error/errors/request_error'

class   HumanError
module  Errors
class   ResourcePersistenceError < RequestError
  include CrudError

  attr_accessor :errors,
                :attributes

  def self.convert(original_error, overrides = {})
    initialization_parameters = {}

    case original_error.class.name
    when 'ActiveRecord::RecordInvalid',
         'ActiveRecord::RecordNotSaved'

      initialization_parameters = {
        attributes: original_error.record.attributes,
        errors:     original_error.record.errors.full_messages,
      }
    end

    new(initialization_parameters.merge(overrides))
  end

  def http_status
    422
  end

  def detail
    "One or more of the attributes on the #{resource_name} you attempted " \
    "to #{action} is invalid."
  end

  def source
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
