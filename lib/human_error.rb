require 'human_error/version'
require 'human_error/error'
require 'human_error/errors'

class   HumanError
  attr_accessor :configuration

  def initialize
    self.configuration = Configuration.new

    yield configuration if block_given?
  end

  def fetch(error_type)
    Object.const_get("HumanError::Errors::#{error_type}")
  end

  def build(error_type, overrides = {})
    overrides = configuration.to_h.merge(overrides)

    fetch(error_type).new(overrides)
  end

  def convert(original_error, overrides = {})
    overrides = configuration.to_h.merge(overrides)

    case original_error.class.name
    when 'ActiveRecord::InvalidForeignKey'
      fetch('AssociationError').convert(original_error, overrides)
    when 'ActiveRecord::RecordNotFound'
      fetch('ResourceNotFoundError').convert(original_error, overrides)
    when 'ActiveRecord::RecordInvalid',
         'ActiveRecord::RecordNotSaved'
      fetch('ResourcePersistenceError').convert(original_error, overrides)
    end
  end

  def raise(error_type, **args)
    error = fetch(error_type).new(**args)

    Kernel.raise error
  end
end
