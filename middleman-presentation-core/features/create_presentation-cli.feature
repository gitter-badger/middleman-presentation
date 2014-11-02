Feature: Initialize presentation

  As a presentator
  I want to create a new presentation
  In order to use it

  Scenario: Initialize with long command
    Given I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
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
    And the file ".middleman-presentation.yaml" should contain:
    """
    project_id:
    """
    Then a directory named "vendor/assets/components/middleman-presentation-theme-default" should exist
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'normalize.css/normalize';
    @import 'reveal.js/css/reveal.min';
    @import 'reveal.js/css/theme/template/mixins';
    @import 'reveal.js/css/theme/template/settings';
    @import 'reveal.js/lib/css/zenburn';
    @import 'middleman-presentation-helpers/footer/footer';
    @import 'middleman-presentation-helpers/image_gallery/image_gallery';
    @import 'middleman-presentation-helpers/images/images';
    @import 'middleman-presentation-theme-default/stylesheets/middleman-presentation-theme-default';
    """
    And the file "source/javascripts/application.js" should contain:
    """
    //= require jquery/dist/jquery
    //= require reveal.js/js/reveal.min
    //= require reveal.js/lib/js/head.min
    //= require middleman-presentation-helpers/footer/footer
    //= require lightbox2/js/lightbox
    """

  Scenario: Initialize in test directory
    Given I successfully run `middleman-presentation create presentation test/presentation1 --title "My Presentation"`
    When I cd to "test/presentation1"
    Then the file "source/stylesheets/application.scss" should contain:
    """
    @import 'normalize.css/normalize';
    @import 'reveal.js/css/reveal.min';
    @import 'reveal.js/css/theme/template/mixins';
    @import 'reveal.js/css/theme/template/settings';
    @import 'reveal.js/lib/css/zenburn';
    @import 'middleman-presentation-helpers/footer/footer';
    @import 'middleman-presentation-helpers/image_gallery/image_gallery';
    @import 'middleman-presentation-helpers/images/images';
    @import 'middleman-presentation-theme-default/stylesheets/middleman-presentation-theme-default';
    """
    And the file "source/javascripts/application.js" should contain:
    """
    //= require jquery/dist/jquery
    //= require reveal.js/js/reveal.min
    //= require reveal.js/lib/js/head.min
    //= require middleman-presentation-helpers/footer/footer
    //= require lightbox2/js/lightbox
    """

  Scenario: Existing configuration file
    Given a user config file for middleman-presentation with:
    """
    author: TestUser
    company: MyCompany
    email_address: test_user@example.com
    homepage: http://example.com
    presentation_language: en
    speaker: TestUser
    """
    When I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    Then the file ".middleman-presentation.yaml" should contain:
    """
    author: TestUser
    """
    Then the file ".middleman-presentation.yaml" should contain:
    """
    company: MyCompany
    """
    Then the file ".middleman-presentation.yaml" should contain:
    """
    email_address: test_user@example.com
    """
    Then the file ".middleman-presentation.yaml" should contain:
    """
    homepage: http://example.com
    """
    Then the file ".middleman-presentation.yaml" should contain:
    """
    speaker: TestUser
    """

  Scenario: German umlauts, French accents and special chars are not a problem for project id
    When I successfully run `middleman-presentation create presentation presentation1 --title "üöà~?§$%&/()=#!"`
    And I cd to "presentation1"
    And the file ".middleman-presentation.yaml" should contain:
    """
    project_id: uoa
    """

  Scenario: Use language from configuration file
    Given a user config file for middleman-presentation with:
    """
    presentation_language: 'de'
    """
    When I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    And I cd to "presentation1"
    Then the file "source/slides/999980.html.erb" should contain:
    """
    Fragen
    """

  Scenario: Use default language if language in configuration file is an empty string
    Given a user config file for middleman-presentation with:
    """
    presentation_language: ''
    """
    When I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    And I cd to "presentation1"
    Then the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Use lang from environment as language in slides
    Given I set the environment variables to:
      | variable | value      |
      | LANG     | de_DE.UTF-8|
    When I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    And I cd to "presentation1"
    Then the file "source/slides/999980.html.erb" should contain:
    """
    Fragen
    """

  Scenario: Use lang from command line as language in slides
    Given I set the environment variables to:
      | variable | value      |
      | LANG     | de_DE.UTF-8|
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation" --language en`
    When I cd to "presentation1"
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Ignore case of lang value
    Given I set the environment variables to:
      | variable | value      |
      | LANG     | de_de.utf-8|
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    When I successfully run `env`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Fragen
    """

  Scenario: Use englisch language in slides based if garbabe in environment variable
    Given I set the environment variables to:
      | variable | value |
      | LANG     | asdf  |
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Use englisch language in slides if given garbabe on command line
    Given I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"  --language adsfasdfn`
    When I cd to "presentation1"
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Use different theme
    Given a user config file for middleman-presentation with:
    """
    theme:
      name: middleman-presentation-theme-fedux_org
      github: maxmeyer/middleman-presentation-theme-fedux_org
      importable_files:
        - stylesheets/middleman-presentation-theme-fedux_org
        """
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    Then a directory named "vendor/assets/components/middleman-presentation-theme-fedux_org" should exist
    And the file "source/stylesheets/application.scss" should contain:
    """
    @import 'middleman-presentation-theme-fedux_org/stylesheets/middleman-presentation-theme-fedux_org';
    """

  Scenario: Fails if bower is not installed
    Given only the executables of gems "middleman-core, middleman-presentation" can be found in PATH
    When I run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    Then the output should contain:
    """
    cannot be found in PATH
    """

  Scenario: Fails if bower update fails
    Given a file named "~/bin/bower" with mode "0755" and with:
    """
    #!/bin/bash
    echo "Failed" >&2
    exit 1
    """
    And only the executables of gems "middleman-core, middleman-presentation" can be found in PATH
    And I prepend "~/bin:" to environment variable "PATH"
    And I run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    Then the output should contain:
    """
    Failed
    """

  Scenario: No predefined slides
    When I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"  --no-create-predefined-slides`
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
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    Then a slide named "00.html.erb" should exist with:
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
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    Then a slide named "999980.html.erb" should exist with:
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
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    Then a slide named "999981.html.erb" should exist with:
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
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    When I cd to "presentation1"
    Then a slide named "999982.html.erb" should exist with:
    """
    <section>
    <h1>See you!</h1>
    </section>
    """

  Scenario: Install external asset
    Given a user config file for middleman-presentation with:
    """
    plugins:
      - middleman-presentation-simple_plugin
    """
    When I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    And I cd to "presentation1"
    Then a directory named "vendor/assets/components/angular" should exist
    And a directory named "vendor/assets/components/impress.js" should exist

  Scenario: Change presentation size
    Given I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation" --view-port 1024 768`
    When I cd to "presentation1"
    Then the file ".middleman-presentation.yaml" should contain:
    """
    view_port: 
    - '1024'
    - '768'
    """
