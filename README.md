# middleman-presentation

This gem provide helpers to use `middleman` together with `reveal.js`

## Installation

Add this line to your middleman application's Gemfile:

    gem 'middleman-presentation'

And then execute:

    $ bundle

And add the `activate`-statement to the `config.rb` of middleman:

```ruby
activate :presentation
```

## Usage

*Initialize middleman*

```bash
middleman init my_presentation
cd my_presentation
```

*Add dependency to Gemfile and activate plugin*

```bash
echo -e "\ngem 'middleman-presentation'" >> Gemfile
echo -e "\nactivate :presentation"       >> config.rb

bundle install
```

*Initialize presentation*

This gem provides a helper to start a new presentatio from scratch. The given
options below need to be given on command line.

```bash
bundle exec middleman presentation --title "my title" --speaker "Me"

bundle install
```

The presentation helper provides a lot of more options. Use the help command to
get an overview. If you want to switch the language for generated slides use
the `--language`-switch.

```bash
middleman help presentation
```

*Add new slide*


**MAKE SURE YOU NEVER EVER GIVE TWO SLIDES THE SAME BASENAME**, eg. 01.html.erb
and 01.html.md. This will not work with `middleman`.

To add a new slide you can use the `slide`-helper.

```bash
middleman slide <name>
```

It is recommended to use a number as name greater than `00`, e.g. `01`.

```bash
middleman slide 01
```

If you prefer another template language you can provide that information as
part of the slide name. Today only `embedded ruby`, `markdown` and `liquid`-templates are supported.

```bash
# embedded ruby
middleman slide 01.erb

# markdown
middleman slide 01.md
middleman slide 01.markdown

# liquid
middleman slide 01.l
middleman slide 01.liquid
```

To set a title for the slide use the `--title`-switch.

```bash
middleman slide 01 --title 'my Title'
```

To edit the slide after creating it use the `--edit`-switch. It uses the
`$EDITOR`-environment variable and falls back to `vim`.

```bash
middleman slide 01 --edit
```

There are some more options available. Please use the `help`-command to get an
overview.

```bash
middleman help slide
```

*Start presentation*

To start your presentation use the `start`-script. It opens the presentation in
your browser and starts `middleman`. After `middleman` has started you just
need to reload the presentation in the browser.

```bash
script/start
```

*Export presentation*

If you need to export the presentation, you can use the `export`-script. It
creates tar-file in `<root>/pkg/<presentation_directory_name>.tar.gz`.

```bash
script/export
# => Creates tar-file in <root>/pkg/<presentation_directory_name>.tar.gz
```

## Reuse existing presentation

*Bootstrap*

Bootstrap the presentation environment.

```bash
script/bootstrap
# => Installs all needed software components
```

*Start presentation*

To start your presentation use the `start`-script.

```bash
script/start
```


## Usage of external resources

*Use Bower*

You can use `bower` to make external resources within your presentation
available. This works fine together with the asset pipeline `middleman` uses:
[sprockets](https://github.com/sstephenson/sprockets). Just add resources to
your (existing) `bower.json` and make yourself comfortable with bower:
http://bower.io/.

*Advantages for the use of bower*

By using `bower` for external resources you can better separate the slide
content from your styles.

*Themes*

An example for `bower`-enabled theme can be found at
https://github.com/maxmeyer/reveal.js-template-fedux_org.

*jquery etc.*

Add those libraries to your `bower.json` and reference them from within your
`javascripts/application.js` and/or `stylesheets/application.scss`

## Contributing

1. Fork it ( https://github.com/[my-github-username]/middleman-presentation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
