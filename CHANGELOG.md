Version v1.13.1 - February 17, 2015
================================================================================

Fixed
--------------------------------------------------------------------------------
  * resource name in developer details needs to be underscored

Version v1.13.0 - November 5, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Allow ResourceNotFoundError to have a default action
  * Add Apill::Errors::InvalidSubdomainError
  * Switch to CircleCI

Bugfix
--------------------------------------------------------------------------------
  * Override the CircleCI test command

Version v1.12.0 - June 30, 2014
================================================================================

Bugfix
--------------------------------------------------------------------------------
  * RescuableResource was moved without Drew's changes

Version v1.11.0 - June 28, 2014
================================================================================

Version v1.10.0 - June 25, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Allow UUIDs and GUIDs for id column values

Version v1.9.0 - June 10, 2014
================================================================================

Bugfix
--------------------------------------------------------------------------------
  * Remove end-of-string anchors from error message regexes

Feature
--------------------------------------------------------------------------------
  * Default CRUD error action to 'persist'

Version v1.8.2 - June 6, 2014
================================================================================

Version v1.8.1 - June 5, 2014
================================================================================

Bugfix
--------------------------------------------------------------------------------
  * Make find a class method instead of an instance method

Version v1.8.0 - June 5, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Add HumanError::Persistable

Version v1.7.1 - May 28, 2014
================================================================================

Bugfix
--------------------------------------------------------------------------------
  * Rework the 'message' and 'to_s' methods on Error

Version v1.7.0 - May 22, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Add to_s to base Error module

Version v1.6.1 - May 22, 2014
================================================================================

Bugfix
--------------------------------------------------------------------------------
  * Require the association_error file

Version v1.6.0 - May 22, 2014
================================================================================

Bugfix
--------------------------------------------------------------------------------
  * Remove a manual reference to `knowledgebase_article_id`

Feature
--------------------------------------------------------------------------------
  * Add AssociationError

Version v1.5.0 - May 20, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Allow HumanError::Errors to have messages explicitly set

Uncategorized
--------------------------------------------------------------------------------
  * Upgrade rspectacular

Version v1.4.0 - May 6, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Allow HumanError instances to both lookup and raise errors
  * Values passed in when looking up errors override local config
  * Allow local configuration to be passed to looked up errors
  * Allow a HumanError instance to 'look up' an error by name
  * Add Configuration#to_h
  * Allow HumanError to be instantiated with a configuration

Version v1.3.0 - May 6, 2014
================================================================================

Feature
--------------------------------------------------------------------------------
  * Add a DuplicateAuthenticationError

Version v1.2.0 - April 15, 2014
================================================================================

  * Add options as an argument to to_json since that's the standard
    implementation
  * Move developer_documentation_uri into HumanError::Error since all its
    dependencies are in that file

Version v1.1.0 - April 15, 2014
================================================================================

  * Add errors.rb to load all the errors files
  * Add Apill::Errors::InvalidApiRequestError to the ErrorCodeDirectory
  * Since the customer support URI now depends exclusively on items in
    HumanError::Error, we can move it up
  * Extract Knowledgebase ID into KnowledgebaseIdDirectory similarly to how we
    did the ErrorCodeDirectory
  * Errors should be able to convert themselves to JSON
  * Human Error only runs on Ruby 2.x

Version v1.0.0 - April 15, 2014
================================================================================

  * Remove Gemfile.lock from git ignored files
  * Massive refactoring with extra Matrix awesomesauce
  * Add badges
  * Add Travis Integration
  * Add CodeClimate test reporter

Version v0.0.1 - March 24, 2014
================================================================================

  * Initial commit
