class   HumanError
module  Errors
class   ParameterMissingError < RuntimeError
  include Error

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
    "#{parameter} is a required parameter, but you did not supply it."
  end

  def source
    {
      'required_parameter' => parameter,
    }
  end
end
end
end
