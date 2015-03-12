* 0.16.4
  * I: Add middleman-autoprefixer to make it easier to use new css features in
    all browsers by prefixing them automatically
* 0.16.3
  * I: Not that strict with version for bundler
* 0.16.2
  * I: Add version numbers to dependencies
* 0.16
  * F: Introduce plugin-support (technical preview)
  * F: Add helpers to show available "assets", "frontend components", "plugins", ...
  * F: Add helper to create plugins
  * F: Add helper to change slide names
  * F: Support for minifying assets during build
  * F: New wrapper commands added: Build presentation, serve presentation
  * F: Support for nested template engines per slide, e.g. 01.html.md.erb => '1. eRuby, 2. Markdown'
  * F: Activate support for smart quotes in markdown documents
  * I: Moved slide helper to "middleman-presentation"-executable
  * I: Use highlight.js directly. It's more uptodate
  * I: --force-flag for "create presentation"-command
  * I: Add debug-mode via --debug-mode-flag
  * I: Export command now creates a generated presentation as zip file
  * I: Move helpers to helper-gem (based on plugin-support)
  * I: Localize cli
  * I: A lot of code refactoring
  * I: Make it compatible with reveal.js >= 3
* 0.15
  * F: Support for predefined slide templates added
  * F: Show default values of configuration controlled by option in config-command
  * F: Show support information
  * I: Refactored presentation generator 
  * I: Refactored user interface to make creating presentations easier
  * I: Refactored user interface to make creating themes easier (create theme, show available styles)

* 0.14
  * F: Support for version number for presentation added
  * F: Support for custom-slide-template added
  * F: Support for own theme added
  * F: Add footer for presentation which displayed on slides 2+
  * F: Detect user language based on ENV['LANG']-variable
  * F: Show slide path in rendered output to make troubleshooting easier 
  * F: Output warning if invalid ignore file is detected
  * F: Add link for easier access to printable layout for presentation
  * I: Improved documentation a lot
  * F: Checks for run of bower: if bower is installed + if run was successful
  * I: Improved possibilities to style slides by using more css
  * I: Improved style of code by integrating rubocop in development workflow
  * I: Refactored themes, default theme should now work again (was broken during refactoring)
  * I: Refactored code of slides: Now classes for new and existing slides instead of one slide-class
  * B: Make reveal.js' presenter view accessible

* 0.12
  * Show slide number

*  0.11
  * Ignore slides in output
  * Seperates style/assets from slide content by using bower
  * Has a slide creator (Markdown, Erb, Liquid)
  * Helps you to initialize new presentations
  * You can have your own templates for (new) slides
  * Allows to group slides
  * Integrates with your preferred editor
