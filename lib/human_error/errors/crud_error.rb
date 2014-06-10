class   HumanError
module  Errors
module  CrudError
  attr_accessor :resource_name,
                :action,
                :resource_id

  def initialize(resource_name: nil, action: nil, resource_id: nil, **args)
    self.resource_name = resource_name
    self.action        = action || 'persist'
    self.resource_id   = resource_id

    super **args
  end
end
end
end
