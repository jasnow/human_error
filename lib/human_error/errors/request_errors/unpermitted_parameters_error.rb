class   HumanError
module  Errors
class   UnpermittedParametersError < RuntimeError
  include Error
  include CrudError

  attr_accessor :parameters

  def self.convert(original_error, overrides = {})
    initialization_parameters = {}

    case original_error.class.name
    when 'ActionController::UnpermittedParameters'
      initialization_parameters = {
        parameters: Array(original_error.params),
      }
    end

    new(initialization_parameters.merge(overrides))
  end

  def initialize(**attrs)
    self.parameters = Array(attrs.delete(:parameters))

    super(**attrs)
  end

  def http_status
    400
  end

  def title
    'Unpermitted Parameters'
  end

  def detail
    "Attempting to #{action} a #{resource_name} with the following parameters is " \
    "not allowed: #{parameters.join(', ')}"
  end

  def source
    {
      'unpermitted_parameters' => parameters,
    }
  end
end
end
end
