class   HumanError
  class Configuration
    attr_accessor :api_version,
                  :api_error_documentation_url,
                  :knowledgebase_url

    def to_h
      {
        knowledgebase_url:            knowledgebase_url,
        api_error_documentation_url:  api_error_documentation_url,
        api_version:                  api_version,
      }
    end
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
