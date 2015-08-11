require 'human_error/configuration'
require 'human_error/error'
require 'human_error/errors/authentication_error'
require 'human_error/errors/authentication_errors/duplicate_authentication_error'
require 'human_error/errors/authentication_errors/invalid_token_error'
require 'human_error/errors/authentication_errors/invalid_username_or_password_error'
require 'human_error/errors/crud_error'
require 'human_error/errors/crud_errors/association_error'
require 'human_error/errors/crud_errors/resource_not_found_error'
require 'human_error/errors/crud_errors/resource_persistence_error'
require 'human_error/errors/request_errors/parameter_missing_error'
require 'human_error/errors/request_errors/unpermitted_parameters_error'
require 'human_error/rescuable_resource'
require 'human_error/verifiable_resource'
require 'human_error/version'

class   HumanError
  def self.fetch(error_type)
    Object.const_get("HumanError::Errors::#{error_type}")
  end

  def self.build(error_type, overrides = {})
    fetch(error_type).new(overrides)
  end

  def self.convert(original_error, overrides = {})
    case original_error.class.name
    when 'ActiveRecord::InvalidForeignKey'
      fetch('AssociationError').convert(original_error, overrides)
    when 'ActiveRecord::RecordNotFound'
      fetch('ResourceNotFoundError').convert(original_error, overrides)
    when 'ActiveRecord::RecordInvalid',
         'ActiveRecord::RecordNotSaved'
      fetch('ResourcePersistenceError').convert(original_error, overrides)
    when 'ActionController::ParameterMissing',
      fetch('ParameterMissingError').convert(original_error, overrides)
    when 'ActionController::UnpermittedParameters'
      fetch('UnpermittedParametersError').convert(original_error, overrides)
    end
  end

  def self.raise(error_type, **args)
    Kernel.raise build(error_type, **args)
  end
end
