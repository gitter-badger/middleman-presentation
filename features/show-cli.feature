Feature: Show information

  As a user
  I want to get information about the system
  In order to provide them for support

  @wip
  Scenario: Show support information
    When I successfully run `middleman-presentation show support_information`
    Then the output should contain:
    """
    kernelversion
    """
