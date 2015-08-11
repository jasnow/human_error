require 'json'
require 'human_error/configuration'
require 'human_error/knowledgebase_id_directory'
require 'human_error/utilities/string'

class   HumanError
module  Error
  module ClassMethods
    def wrap(other)
      wrapped_error = new message: "#{other.class.name}: #{other.message}"
      wrapped_error.set_backtrace other.backtrace
      wrapped_error
    end
  end

  attr_accessor :id,
                :api_version,
                :api_error_documentation_url,
                :knowledgebase_url,
                :knowledgebase_article_id,
                :http_status,
                :code,
                :title,
                :detail,
                :source,
                :message

  def initialize(**args)
    self.api_version                 = configuration.api_version
    self.api_error_documentation_url = configuration.api_error_documentation_url
    self.knowledgebase_url           = configuration.knowledgebase_url

    args.each do |variable, value|
      public_send("#{variable}=", value)
    end
  end

  def as_json(_options = {})
    {
      errors: [
        {
          id:     id,
          links:  {
            about:         external_documentation_url,
            documentation: developer_documentation_url,
          },
          status: http_status,
          code:   code,
          title:  title,
          detail: detail,
          source: source,
        },
      ],
    }
  end

  def to_json(_options = {})
    JSON.dump(as_json)
  end

  def id
    @id ||= SecureRandom.uuid
  end

  def external_documentation_url
    "#{knowledgebase_url}/#{knowledgebase_article_id}"
  end

  def developer_documentation_url
    "#{api_error_documentation_url}/#{code}?version=#{api_version}"
  end

  def knowledgebase_article_id
    @knowledgebase_article_id || KnowledgebaseIdDirectory.lookup(self.class.name)
  end

  def http_status
    @http_status ||= 500
  end

  alias_method :status, :http_status

  def code
    @code ||= HumanError::Utilities::String.
                underscore(self.class.name).
                gsub(%r{\A[^/]+/}, '').
                gsub(%r{/}, '.')
  end

  def title
    @title ||= self.class.name
  end

  def detail
    @detail ||= 'The server encountered an error.'
  end

  def source
    @source ||= {}
  end

  def message
    to_s
  end

  def to_s
    @message || detail
  end

  def self.included(base)
    base.extend ClassMethods
  end

  private

  def configuration
    HumanError.configuration
  end
end
end
