class   HumanError
module  RescuableResource
  module ClassMethods
    def plural_resource_name
      name[/(\w+)Controller\z/, 1].
      underscore.
      pluralize.
      downcase
    end

    def singular_resource_name
      name[/(\w+)Controller\z/, 1].
      underscore.
      singularize.
      downcase
    end
  end

  def self.included(base)
    base.extend ClassMethods

    base.rescue_from 'ActiveRecord::RecordInvalid',
                     'ActiveRecord::RecordNotSaved',
                     'ActiveRecord::RecordNotFound',
                     'ActiveRecord::InvalidForeignKey',
                     'ActionController::ParameterMissing',
                     'ActionController::UnpermittedParameters' do |exception|
      human_error = HumanError.convert(exception,
                                       resource_name: self.class.singular_resource_name,
                                       action:        action_name)

      render json:   human_error,
             status: human_error.http_status
    end

    base.rescue_from 'HumanError::Error' do |exception|
      render json:   exception,
             status: exception.http_status
    end
  end
end
end
