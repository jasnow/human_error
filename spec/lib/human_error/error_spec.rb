require 'rspectacular'
require 'human_error/error'

class CustomError < RuntimeError
  include HumanError::Error
end

class     HumanError
describe  Error do
  it 'can wrap an error with another error' do
    original_error = RuntimeError.new('My Runtime Error Message')
    wrapped_error  = CustomError.wrap(original_error)

    expect(wrapped_error.class.name).to eql 'CustomError'
  end

  it 'can wrap the message of an error by identifying the original error type' do
    original_error = RuntimeError.new('My Runtime Error Message')
    wrapped_error  = CustomError.wrap(original_error)

    expect(wrapped_error.message).to eql 'RuntimeError: My Runtime Error Message'
  end

  it 'can transfer the backtrace of the original error to the wrapped error' do
    original_error = RuntimeError.new('My Runtime Error Message')
    original_error.set_backtrace %w{foo bar baz}
    wrapped_error = CustomError.wrap(original_error)

    expect(wrapped_error.backtrace).to eql %w{foo bar baz}
  end

  it 'can have its message explicitly set when it is generated' do
    error = CustomError.new(message: 'My Message')

    expect(error.message).to eql 'My Message'
  end

  it 'can have its message explicitly set when it is generated' do
    error = CustomError.new
    allow(error).to receive(:developer_message).
                    and_return('My Developer Message')

    expect(error.message).to eql 'My Developer Message'
  end
end
end
