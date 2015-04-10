require 'human_error/errors/resource_not_found_error'

module  HumanError
module  VerifiableModel
  module ClassMethods
    def verify_model_exists(model_name = nil, options = {})
      exceptions   = options[:except] || %i{create index}
      model_name ||= name[/::(\w+)Controller\z/, 1].
                       singularize.
                       downcase

      before_action except: exceptions do
        model = public_send(model_name)

        resource_not_found_error = Errors::ResourceNotFoundError.new(
          resource_name: model_name,
          resource_id:   params[:id],
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
