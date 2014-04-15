require 'json'
require 'human_error/configuration'
require 'human_error/error_code_directory'

module  HumanError
module  Error
  attr_accessor :api_version,
                :api_error_documentation_url,
                :knowledgebase_url,
                :code

  def initialize(**args)
    self.api_version                 = configuration.api_version
    self.api_error_documentation_url = configuration.api_error_documentation_url
    self.knowledgebase_url           = configuration.knowledgebase_url

    args.each do |variable, value|
      self.send("#{variable}=", value)
    end
  end

  def code
    @code || ErrorCodeDirectory.lookup(self.class.name)
  end

  def to_json
    JSON.dump(as_json)
  end

  def wrap(other)
    wrapped_error = new "#{other.class.name}: #{other.message}"
    wrapped_error.set_backtrace other.backtrace
    wrapped_error
  end

  private

  def configuration
    HumanError.configuration
  end
end
end
