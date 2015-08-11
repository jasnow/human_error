require 'human_error/errors/crud_error'

class   HumanError
module  Errors
class   ResourceNotFoundError < RuntimeError
  include Error
  include CrudError

  def self.convert(original_error, overrides = {})
    initialization_parameters = {}

    case original_error.class.name
    when 'ActiveRecord::RecordNotFound'
      initialization_parameters = {
        resource_id: case original_error.message
                     when /\ACouldn't find .* without an ID\z/
                       []
                     when /\ACouldn't find .* with \'.*\'=([a-f0-9\-]+)/
                       [Regexp.last_match(1)]
                     when /\ACouldn't find all .* with \'.*\': ((?:[a-f0-9\-]+(?:, )?)+)/
                       Array(Regexp.last_match(1).split(', '))
                     end,
      }
    end

    new(initialization_parameters.merge(overrides))
  end

  def http_status
    404
  end

  def title
    'Resource Not Found'
  end

  def detail
    "The #{resource_name} you attempted to #{action} for this request is either " \
    'not authorized for the authenticated user or does not exist.'
  end

  def source
    { "#{resource_name_underscored}_id" => resource_id }
  end

  def action
    @action || 'access'
  end
end
end
end
