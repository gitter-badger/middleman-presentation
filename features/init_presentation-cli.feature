Feature: Initialize presentation

  As a presentator
  I want to create a new presentation
  In order to use it

  Background:
    Given a mocked home directory
    And git is configured with username "User" and email-address "email@example.com"

  Scenario: Initialize with short command
    When I successfully run `middleman-presentation init --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    Then the file "config.rb" should contain:
    """
    activate :presentation
    """
    And the file "Gemfile" should contain:
    """
    middleman-presentation
    """
    And a file named "bower.json" should exist
    And a file named ".bowerrc" should exist
    And a file named ".gitignore" should exist
    And a file named "source/layout.erb" should exist
    And a file named "source/slides/00.html.erb" should exist
    And a file named "source/slides/999980.html.erb" should exist
    And a file named "source/slides/999981.html.erb" should exist
    And a file named "source/slides/999982.html.erb" should exist
    And a file named "source/index.html.erb" should exist
    And a file named "source/stylesheets/application.scss" should exist
    And a file named "source/javascripts/application.js" should exist
    And a file named "script/start" should exist
    And a file named "Rakefile" should exist
    And a directory named "source/images" should exist
    And a directory named "vendor/assets/components" should exist
    And the file "data/metadata.yml" should contain:
    """
    project_id:
    """
    Then a directory named "vendor/assets/components/middleman-presentation-theme-default" should exist
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'middleman-presentation-theme-common/stylesheets/middleman-presentation-theme-common';
    """
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'middleman-presentation-theme-default/stylesheets/middleman-presentation-theme-default';
    """

  Scenario: Initialize with long command
    When I successfully run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    Then the file "config.rb" should contain:
    """
    activate :presentation
    """
    And the file "Gemfile" should contain:
    """
    middleman-presentation
    """
    And a file named "bower.json" should exist
    And a file named ".bowerrc" should exist
    And a file named ".gitignore" should exist
    And a file named "source/layout.erb" should exist
    And a file named "source/slides/00.html.erb" should exist
    And a file named "source/index.html.erb" should exist
    And a file named "source/stylesheets/application.scss" should exist
    And a file named "source/javascripts/application.js" should exist
    And a file named "script/start" should exist
    And a file named "Rakefile" should exist
    And a directory named "source/images" should exist
    And a directory named "vendor/assets/components" should exist
    And the file "data/metadata.yml" should contain:
    """
    project_id:
    """
    Then a directory named "vendor/assets/components/middleman-presentation-theme-default" should exist
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'middleman-presentation-theme-common/stylesheets/middleman-presentation-theme-common';
    """
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'middleman-presentation-theme-default/stylesheets/middleman-presentation-theme-default';
    """

  Scenario: Existing configuration file
    Given  a file named "~/.config/middleman/presentation/presentations.yaml" with:
    """
    author: TestUser
    company: MyCompany
    email_address: test_user@example.com
    homepage: http://example.com
    language: en
    speaker: TestUser
    """
    When I successfully run `middleman-presentation init presentation --title "My Presentation"`
    Then the file "data/metadata.yml" should contain:
    """
    author: TestUser
    """
    Then the file "data/metadata.yml" should contain:
    """
    company: MyCompany
    """
    Then the file "data/metadata.yml" should contain:
    """
    email_address: test_user@example.com
    """
    Then the file "data/metadata.yml" should contain:
    """
    homepage: http://example.com
    """
    Then the file "data/metadata.yml" should contain:
    """
    speaker: TestUser
    """

  Scenario: German umlauts, French accents and special chars are not a problem for project id
    When I successfully run `middleman-presentation init presentation --title "üöà~?§$%&/()=#!"`
    And the file "data/metadata.yml" should contain:
    """
    project_id: uoa
    """

  Scenario: Use lang from environment as language in slides
    Given I set the environment variables to:
      | variable | value      |
      | LANG     | de_DE.UTF-8|
    When I successfully run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    When I successfully run `env`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Fragen
    """

  Scenario: Use lang from command line as language in slides
    Given I set the environment variables to:
      | variable | value      |
      | LANG     | de_DE.UTF-8|
    When I successfully run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344 --language en`
    When I successfully run `env`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Ignore case of lang value
    Given I set the environment variables to:
      | variable | value      |
      | LANG     | de_de.utf-8|
    When I successfully run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    When I successfully run `env`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Fragen
    """

  Scenario: Use englisch language in slides based if garbabe in environment variable
    Given I set the environment variables to:
      | variable | value |
      | LANG     | asdf  |
    When I successfully run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Use englisch language in slides if given garbabe on command line
    When I successfully run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344 --language adsfasdfn`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Use different theme
    Given a file named "~/.config/middleman/presentation/presentations.yaml" with:
    """
    theme:
      name: middleman-presentation-theme-fedux_org
      github: maxmeyer/middleman-presentation-theme-fedux_org
      stylesheets:
        - stylesheets/middleman-presentation-theme-fedux_org
        """
    And git is configured with username "User" and email-address "email@example.com"
    When I successfully run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344 --language adsfasdfn`
    Then a directory named "vendor/assets/components/middleman-presentation-theme-fedux_org" should exist
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'middleman-presentation-theme-common/stylesheets/middleman-presentation-theme-common';
    """
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'middleman-presentation-theme-fedux_org/stylesheets/middleman-presentation-theme-fedux_org';
    """

  Scenario: Fails if bower is not installed
    And only the executables of gems "middleman-core, middleman-presentation" can be found in PATH
    When I run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    Then the output should contain:
    """
    cannot be found in PATH
    """

  Scenario: Fails if bower update fails
    And a file named "~/bin/bower" with mode "0755" and with:
    """
    #!/bin/bash
    echo "Failed" >&2
    exit 1
    """
    And only the executables of gems "middleman-core, middleman-presentation" can be found in PATH
    And I set the environment variables to:
      | variable | value  | action |
      | PATH     | ~/bin: | .      |
    When I run `middleman-presentation init presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    Then the output should contain:
    """
    Failed
    """

  Scenario: No predefined slides
    When I successfully run `middleman-presentation init --title "My Presentation" --no-create-predefined-slides`
    Then a file named "source/slides/00.html.erb" should not exist
    And a file named "source/slides/999980.html.erb" should not exist
    And a file named "source/slides/999981.html.erb" should not exist
    And a file named "source/slides/999982.html.erb" should not exist

  Scenario: Custom start slide template
    Given a user template named "predefined_slides.d/00.html.erb.tt" with:
    """
    <section>
    <h1>Start</h1>
    </section>
    """
    When I successfully run `middleman-presentation init presentation --title "My Presentation"`
    Then a slide named "00.html.erb" exist with:
    """
    <section>
    <h1>Start</h1>
    </section>
    """

  Scenario: Custom questions template
    Given a user template named "predefined_slides.d/999980.html.erb.tt" with:
    """
    <section>
    <h1>Questions? Really</h1>
    </section>
    """
    When I successfully run `middleman-presentation init presentation --title "My Presentation"`
    Then a slide named "999980.html.erb" exist with:
    """
    <section>
    <h1>Questions? Really</h1>
    </section>
    """

  Scenario: Custom contact template
    Given a user template named "predefined_slides.d/999981.html.erb.tt" with:
    """
    <section>
    <h1>Contact</h1>
    Me and You
    </section>
    """
    When I successfully run `middleman-presentation init presentation --title "My Presentation"`
    Then a slide named "999981.html.erb" exist with:
    """
    <section>
    <h1>Contact</h1>
    Me and You
    </section>
    """

  Scenario: Custom end slide template
    Given a user template named "predefined_slides.d/999982.html.erb.tt" with:
    """
    <section>
    <h1>See you!</h1>
    </section>
    """
    When I successfully run `middleman-presentation init presentation --title "My Presentation"`
    Then a slide named "999982.html.erb" exist with:
    """
    <section>
    <h1>See you!</h1>
    </section>
    """
