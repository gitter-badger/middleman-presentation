Feature: Show available default css classes

  As a presentator
  I want to get a list of css classess which are used in default templates
  In order to know what needs to be defined

  Scenario: Available css classes
    Given I successfully run `middleman-presentation list style`
    Then the output should contain:
    """
    Available css classes in templates used by middleman-presentation:
    """
    And the output should contain:
    """
    mp-external-url: "999981.html.erb.tt"
    """

