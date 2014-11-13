Feature: Use predefined slides when creating a new presentation

  As a presentator
  I want to create a new presentation using predefined slides
  In order to use it

  Scenario: No predefined slides
    When I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"  --no-create-predefined-slides`
    Then a file named "source/slides/00.html.erb" should not exist
    And a file named "source/slides/999980.html.erb" should not exist
    And a file named "source/slides/999981.html.erb" should not exist
    And a file named "source/slides/999982.html.erb" should not exist

  Scenario: Custom start slide template
    Given a user defined predefined slide named "00.html.erb.tt" with:
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
    Given a user defined predefined slide named "999980.html.erb.tt" with:
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
    Given a user defined predefined slide named "999981.html.erb.tt" with:
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
    Given a user defined predefined slide named "999982.html.erb.tt" with:
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

