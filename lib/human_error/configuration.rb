require 'singleton'

class   HumanError
  class Configuration
    include Singleton

    attr_accessor :url_mappings

    def external_documentation_urls
      @external_documentation_urls ||= url_mappings['external_documentation_urls']
    end

    def developer_documentation_urls
      @developer_documentation_urls ||= url_mappings['developer_documentation_urls']
    end

    def to_h
      {
        external_documentation_urls:  external_documentation_urls,
        developer_documentation_urls: developer_documentation_urls,
      }
    end

    def url_mappings
      @url_mappings ||= {
        'external_documentation_urls'  => {},
        'developer_documentation_urls' => {},
      }
    end
  end

  def configuration
    Configuration.instance
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    Configuration.instance
  end
end
