class   HumanError
module  VerifiableResource
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

    base.before_action except: %i{index create} do
      model = public_send(self.class.singular_resource_name)

      resource_not_found_error = HumanError.build(
        'ResourceNotFoundError',
        resource_name: self.class.singular_resource_name,
        resource_id:   [params[:id]],
        action:        action_name,
      )

      fail resource_not_found_error unless model.persisted?
    end
  end
end
end
