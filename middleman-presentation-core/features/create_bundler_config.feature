Feature: Create bundler config for testing

  As a developer
  I want to create a special bundler config for testing
  In order to speedup testing

  @wip
  Scenario: Create config
    Given a file named ".bundle/config" does not exist
    And a file named "Gemfile.lock" does not exist
    And a file named "Gemfile" does not exist
    When I successfully run `middleman-presentation create bundler_config`
    And a file named ".bundle/config" should exist
    And a file named "Gemfile" should exist
    And a file named "Gemfile.lock" should exist
