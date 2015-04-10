require 'human_error/errors/crud_errors/resource_persistence_error'
require 'human_error/errors/crud_errors/resource_not_found_error'
require 'human_error/errors/crud_errors/association_error'

class   HumanError
module  RescuableResource
  module ClassMethods
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Style/GuardClause
    def rescue_resource(resource_name, from:, via:)
      resource_class_name = resource_name.classify
      lookup_library      = via

      if from.include? 'persistence'
        rescue_from 'ActiveRecord::RecordInvalid',
                    'ActiveRecord::RecordNotSaved' do |exception|
          human_error = lookup_library.convert(exception,
                                               resource_name: resource_class_name,
                                               action:        action_name)

          render json:   human_error,
                 status: human_error.http_status
        end
      end

      if from.include? 'not_found'
        rescue_from 'ActiveRecord::RecordNotFound' do |exception|
          human_error = lookup_library.convert(exception,
                                               resource_name: resource_class_name,
                                               action:        action_name)

          render json:   human_error,
                 status: human_error.http_status
        end
      end

      if from.include? 'association'
        rescue_from 'ActiveRecord::InvalidForeignKey' do |exception|
          human_error = lookup_library.convert(exception,
                                               resource_name: resource_class_name,
                                               action:        action_name)

          render json:   human_error,
                 status: human_error.http_status
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
