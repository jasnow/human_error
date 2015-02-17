require 'human_error/errors/crud_errors/resource_persistence_error'
require 'human_error/errors/crud_errors/resource_not_found_error'
require 'human_error/errors/crud_errors/association_error'

class   HumanError
module  RescuableResource
  module ClassMethods
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Style/GuardClause
    def rescue_resource(_resource_name, from:, via:)
      lookup_library = via

      if from.include? 'persistence'
        rescue_from HumanError::Errors::ResourcePersistenceError do |e|
          error = lookup_library.fetch(
                  'ResourcePersistenceError',
                  resource_name: e.resource_name,
                  attributes:    e.attributes,
                  errors:        e.errors,
                  action:        action_name)

          render json:   error,
                 status: error.http_status
        end
      end

      if from.include? 'not_found'
        rescue_from HumanError::Errors::ResourceNotFoundError do |e|
          resource_id = e.resource_id.is_a?(Array) ? e.resource_id : [e.resource_id]

          error = lookup_library.fetch(
                  'ResourceNotFoundError',
                  resource_name: e.resource_name,
                  resource_id:   resource_id,
                  action:        action_name)

          render json:   error,
                 status: error.http_status
        end
      end

      if from.include? 'association'
        rescue_from HumanError::Errors::AssociationError do |e|
          error = lookup_library.fetch(
                  'AssociationError',
                  resource_name:    e.resource_name,
                  association_name: e.association_name,
                  association_id:   e.association_id,
                  attributes:       e.attributes)

          render json:   error,
                 status: error.http_status
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Style/GuardClause
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
end
