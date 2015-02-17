class   HumanError
module  Persistable
  module ClassMethods
    def find(*ids)
      super
    rescue ActiveRecord::RecordNotFound
      ids = case e.message
            when /\ACouldn't find .* without an ID\z/
              []
            when /\ACouldn't find .* with \'.*\'=([a-f0-9\-]+)/
              [Regexp.last_match(1)]
            when /\ACouldn't find all .* with \'.*\': ((?:[a-f0-9\-]+(?:, )?)+)/
              Regexp.last_match(1).split(', ')
            end

      raise HumanError::Errors::ResourceNotFoundError.new(
        resource_name: Persistable.human_error_resource_name(self),
        resource_id:   ids)
    end
  end

  def save!(*args)
    super
  rescue ActiveRecord::InvalidForeignKey
    association_info_pattern = /DETAIL:  Key \((.*)_id\)=\(([a-f0-9\-]+)\)/
    association_name, association_id = e.message.
                                         match(association_info_pattern) \
                                         [1..-1]

    raise HumanError::Errors::AssociationError.new(
      resource_name:    Persistable.human_error_resource_name(self.class),
      association_name: association_name,
      association_id:   association_id,
      attributes:       attributes)
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    raise HumanError::Errors::ResourcePersistenceError.new(
      resource_name: Persistable.human_error_resource_name(self.class),
      attributes:    attributes,
      errors:        errors.full_messages)
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
