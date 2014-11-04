Feature: Default slides

  As a presentator
  I want to use default slides
  In order to reuse them

  Scenario: Contact information
    Given a user config file for middleman-presentation with:
    """
    github_url: http://example.com
    email_address: mail@example.com
    phone_number: 1111
    """
    And I create a new presentation with title "My Presentation"
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
    Given I create a new presentation with title "My Presentation"
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    Agenda
    """

  Scenario: Questions
    Given I create a new presentation with title "My Presentation"
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    Questions
    """

  Scenario: The end
    Given I create a new presentation with title "My Presentation"
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    The End
    """
