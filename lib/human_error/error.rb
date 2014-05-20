require 'json'
require 'human_error/configuration'
require 'human_error/error_code_directory'
require 'human_error/knowledgebase_id_directory'

class   HumanError
module  Error
  attr_accessor :api_version,
                :api_error_documentation_url,
                :knowledgebase_url,
                :knowledgebase_article_id,
                :code,
                :message

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

  def knowledgebase_article_id
    @knowledgebase_article_id || KnowledgebaseIdDirectory.lookup(self.class.name)
  end

  def developer_documentation_uri
    "#{api_error_documentation_url}/#{code}?version=#{api_version}"
  end

  def customer_support_uri
    "#{knowledgebase_url}/#{knowledgebase_article_id}"
  end

  def to_json(options = {})
    JSON.dump(as_json)
  end

  def wrap(other)
    wrapped_error = new message: "#{other.class.name}: #{other.message}"
    wrapped_error.set_backtrace other.backtrace
    wrapped_error
  end

  def message
    @message || developer_message
  end

  def developer_message
    raise RuntimeError, 'This method must be implemented in a subclass'
  end

  private

  def configuration
    HumanError.configuration
  end
end
end
