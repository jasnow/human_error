class   HumanError
module  Persistable
  module ClassMethods
    def find(*ids)
      super
    rescue ActiveRecord::RecordNotFound => e
      ids = case e.message
            when /\ACouldn't find .* without an ID\z/
              []
            when /\ACouldn't find .* with \'.*\'=(\d+)/
              [$1]
            when /\ACouldn't find all .* with \'.*\': ((?:\d+(?:, )?)+)/
              $1.split(', ')
            end

      raise HumanError::Errors::ResourceNotFoundError.new(
        resource_name:    Persistable.human_error_resource_name(self),
        resource_id:      ids)
    end
  end

  def save!(*args)
    super
  rescue ActiveRecord::InvalidForeignKey => e
    association_info_pattern = %r{DETAIL:  Key \((.*)_id\)=\((\d+)\)}
    association_name, association_id = e.message.
                                         match(association_info_pattern) \
                                         [1..-1]

    raise HumanError::Errors::AssociationError.new(
      resource_name:    Persistable.human_error_resource_name(self.class),
      association_name: association_name,
      association_id:   association_id,
      attributes:       attributes)
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    raise HumanError::Errors::ResourcePersistenceError.new(
      resource_name:    Persistable.human_error_resource_name(self.class),
      attributes:       attributes,
      errors:           errors.full_messages)
  end

  def self.human_error_resource_name(klass)
    last_part_of_class_name = /::(\w+)\z/

    klass.
      name[last_part_of_class_name, 1].
      underscore.
      humanize.
      downcase
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
end
