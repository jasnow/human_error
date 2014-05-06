class   HumanError
  class Configuration
    attr_accessor :api_version,
                  :api_error_documentation_url,
                  :knowledgebase_url
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
