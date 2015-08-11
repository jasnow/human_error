require 'human_error/error'
require 'human_error/errors/authentication_error'
require 'human_error/errors/authentication_errors/duplicate_authentication_error'
require 'human_error/errors/authentication_errors/invalid_token_error'
require 'human_error/errors/authentication_errors/invalid_username_or_password_error'
require 'human_error/errors/crud_error'
require 'human_error/errors/crud_errors/association_error'
require 'human_error/errors/crud_errors/resource_not_found_error'
require 'human_error/errors/crud_errors/resource_persistence_error'
require 'human_error/rescuable_resource'
require 'human_error/verifiable_model'
require 'human_error/version'

class   HumanError
  def initialize
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
    Kernel.raise build(error_type, **args)
  end
end
