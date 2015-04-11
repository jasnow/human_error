require 'human_error/errors/crud_errors/resource_not_found_error'

class   HumanError
module  VerifiableModel
  module ClassMethods
    def verify_model_exists(model_name = nil, options = {}, via: HumanError.new)
      exceptions     = options[:except] || %i{create index}
      lookup_library = via
      model_name   ||= name[/::(\w+)Controller\z/, 1].
                         singularize.
                         downcase

      before_action except: exceptions do
        model = public_send(model_name)

        resource_not_found_error = lookup_library.build(
          'ResourceNotFoundError',
          resource_name: model_name,
          resource_id:   [params[:id]],
          action:        action_name,
        )

        fail resource_not_found_error unless model.persisted?
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
end
