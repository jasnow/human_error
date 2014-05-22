class   HumanError
class   KnowledgebaseIdDirectory
  def self.lookup(error_class)
    directory[error_class]
  end

  private

  def self.directory
    {
      'HumanError::Errors::InvalidTokenError'              => '1234567890',
      'HumanError::Errors::InvalidUsernameOrPasswordError' => '1234567890',
      'HumanError::Errors::ResourceNotFoundError'          => '1234567890',
      'HumanError::Errors::ResourcePersistenceError'       => '1234567890',
      'Apill::Errors::InvalidApiRequestError'              => '1234567890',
      'HumanError::Errors::DuplicateAuthenticationError'   => '1234567890',
      'HumanError::Errors::AssociationError'               => '1234567890',
    }
  end
end
end
