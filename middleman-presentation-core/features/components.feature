Feature: Support components for middleman-presentation

  As a presentator
  I want to use bower components in all my presentation
  In order to use them in all my presentations

  @wip
  Scenario: Add components
    Given a user config file for middleman-presentation with:
    """
    components:
      - name: :bootstrap
        version: latest
        importable_files: 
          - dist/js/bootstrap.js 
          - !ruby/regexp '/dist\/css\/bootstrap.css$/'
    """
    When I create a new presentation with title "My Presentation"
    Then a directory named "vendor/assets/components/bootstrap" should exist
    Given the Server is running
    When I go to "/javascripts/application.js"
    Then I should see:
    """
    Bootstrap
    """
    When I go to "/stylesheets/application.css"
    Then I should see:
    """
    glyphicon
    """
