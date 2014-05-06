require 'human_error/version'
require 'human_error/error'
require 'human_error/errors'

class   HumanError
  attr_accessor :configuration

  def initialize
    self.configuration = Configuration.new

    yield configuration if block_given?
  end
end
