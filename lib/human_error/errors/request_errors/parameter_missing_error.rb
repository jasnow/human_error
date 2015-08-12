class   HumanError
module  Errors
class   ParameterMissingError < RuntimeError
  include Error
  include CrudError

  attr_accessor :parameter

  def self.convert(original_error, overrides = {})
    initialization_parameters = {}

    case original_error.class.name
    when 'ActionController::ParameterMissing'
      initialization_parameters = {
        parameter: original_error.param,
      }
    end

    new(initialization_parameters.merge(overrides))
  end

  def http_status
    400
  end

  def title
    'Missing Parameter'
  end

  def detail
    "When attempting to #{action} a #{resource_name}, '#{parameter}' is a " \
    'required parameter.'
  end

  def source
    {
      'required_parameter' => parameter,
    }
  end
end
end
end
