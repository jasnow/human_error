class   HumanError
class   ErrorCodeDirectory
  def self.lookup(error_class)
    directory[error_class]
  end

  private

  def self.directory
    {
      'HumanError::Errors::InvalidTokenError'              => 1003,
      'HumanError::Errors::InvalidUsernameOrPasswordError' => 1004,
      'HumanError::Errors::ResourceNotFoundError'          => 1005,
      'HumanError::Errors::ResourcePersistenceError'       => 1006,
      'Apill::Errors::InvalidApiRequestError'              => 1007,
      'HumanError::Errors::DuplicateAuthenticationError'   => 1008,
      'HumanError::Errors::AssociationError'               => 1009,
      'Apill::Errors::InvalidSubdomainError'               => 1010,
    }
  end
end
end
