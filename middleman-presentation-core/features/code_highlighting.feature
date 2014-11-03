Feature: Code highlighting in Markdown slides

  As a presentator
  I want to highlight code easily
  In order to make it more understandable for the audience

  Background:
    Given I create a new presentation with title "My Presentation"

  @wip
  Scenario: Code block
    Given a slide named "01.html.md" with:
    """
    <section>
    # Hello World

    ~~~ ruby
    puts 42
    ~~~
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <div class="highlighter-middleman_presentation"><pre class="mp-code-block"><code class="ruby">puts 42
  </code></pre>  </div>
    """

    @wip
  Scenario: Inline code
    Given a slide named "01.html.md" with:
    """
    <section>
    # Hello World

    This is `code`
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <p>This is <code class="highlighter-middleman_presentation"><code class="mp-code-inline">code</code></code></p>
    """
