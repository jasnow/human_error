require 'rspectacular'
require 'human_error'
require 'action_controller'

class     HumanError
module    Errors
describe  UnpermittedParametersError do
  it 'has a status' do
    error = UnpermittedParametersError.new

    expect(error.http_status).to eql 400
  end

  it 'has a code' do
    error = UnpermittedParametersError.new

    expect(error.code).to eql 'errors.unpermitted_parameters_error'
  end

  it 'has a title' do
    error = UnpermittedParametersError.new

    expect(error.title).to eql 'Unpermitted Parameters'
  end

  it 'includes the resource name and action in the detail' do
    error = UnpermittedParametersError.new parameters: 'trenchcoat'

    expect(error.detail).to eql 'The following parameters passed are not allowed: ' \
                                'trenchcoat'
  end

  it 'includes the resource name and action in the detail' do
    error = UnpermittedParametersError.new parameters: %w{trenchcoat matrix}

    expect(error.detail).to eql 'The following parameters passed are not allowed: ' \
                                'trenchcoat, matrix'
  end

  it 'includes the resource name and action in the source' do
    error = UnpermittedParametersError.new parameters: 'trenchcoat'

    expect(error.source).to eql('unpermitted_parameters' => ['trenchcoat'])
  end

  it 'can convert an "ActionController::UnpermittedParameters"' do
    parameters_error = ActionController::UnpermittedParameters.new(%w{trenchcoat})
    error            = UnpermittedParametersError.convert(parameters_error)

    expect(error.parameters).to eql %w{trenchcoat}
  end

  it 'can convert an "ActionController::ParameterMissing" while overriding attributes' do
    parameters_error = ActionController::UnpermittedParameters.new(%w{trenchcoat})
    error            = UnpermittedParametersError.convert(parameters_error,
                                                          parameters: 'matrix')

    expect(error.parameters).to eql %w{matrix}
  end
end
end
end
