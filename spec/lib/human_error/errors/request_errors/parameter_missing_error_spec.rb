require 'rspectacular'
require 'human_error'
require 'action_controller'

class     HumanError
module    Errors
describe  ParameterMissingError do
  it 'has a status' do
    error = ParameterMissingError.new

    expect(error.http_status).to eql 400
  end

  it 'has a code' do
    error = ParameterMissingError.new

    expect(error.code).to eql 'errors.parameter_missing_error'
  end

  it 'has a title' do
    error = ParameterMissingError.new

    expect(error.title).to eql 'Missing Parameter'
  end

  it 'includes the resource name and action in the detail' do
    error = ParameterMissingError.new resource_name: 'trenchcoat',
                                      action:        'create',
                                      parameter:     'color'

    expect(error.detail).to eql "When attempting to create a trenchcoat, 'color' is " \
                                'a required parameter.'
  end

  it 'includes the resource name and action in the source' do
    error = ParameterMissingError.new parameter: 'trenchcoat'

    expect(error.source).to eql('required_parameter' => 'trenchcoat')
  end

  it 'can convert an "ActionController::ParameterMissing"' do
    parameter_missing_error = ActionController::ParameterMissing.new('trenchcoat')
    error                   = ParameterMissingError.convert(parameter_missing_error)

    expect(error.parameter).to eql 'trenchcoat'
  end

  it 'can convert an "ActionController::ParameterMissing" while overriding attributes' do
    parameter_missing_error = ActionController::ParameterMissing.new('trenchcoat')
    error                   = ParameterMissingError.convert(parameter_missing_error,
                                                            parameter: 'matrix')

    expect(error.parameter).to eql 'matrix'
  end
end
end
end
