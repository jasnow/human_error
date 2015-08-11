require 'human_error/errors/crud_errors/resource_persistence_error'
require 'human_error/errors/crud_errors/resource_not_found_error'
require 'human_error/errors/crud_errors/association_error'

class   HumanError
module  RescuableResource
  module ClassMethods
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Style/GuardClause
    def rescue_resource(resource_name, via:)
      nice_resource_name = resource_name.humanize.downcase
      lookup_library     = via

        rescue_from 'ActiveRecord::RecordInvalid',
                    'ActiveRecord::RecordNotSaved',
                    'ActiveRecord::RecordNotFound',
                    'ActiveRecord::InvalidForeignKey' do |exception|

          human_error = lookup_library.convert(exception,
                                               resource_name: nice_resource_name,
                                               action:        action_name)

          render json:   human_error,
                 status: human_error.http_status
        end

      rescue_from 'HumanError::Error' do |exception|
        render json:   exception,
               status: exception.http_status
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Style/GuardClause
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
end
