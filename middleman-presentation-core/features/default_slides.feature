Feature: Default slides

  As a presentator
  I want to use default slides
  In order to reuse them

  Background:
    Given a user config file for middleman-presentation with:
    """
    github_url: http://example.com
    email_address: mail@example.com
    phone_number: 1111
    """
    And I use presentation fixture "default_slides1" with title "My Presentation"

  Scenario: Contact information
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    Contact
    """
    And I should see:
    """
    http://example.com
    """
    And I should see:
    """
    mail@example.com
    """
    And I should see:
    """
    1111
    """

  Scenario: Agenda
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    Agenda
    """

  Scenario: Questions
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    Questions
    """

  Scenario: The end
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    The End
    """
