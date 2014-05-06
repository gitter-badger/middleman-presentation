# middleman-presentation

This gem provide helpers to use `middleman` together with `reveal.js`

## Installation

Add this line to your middleman application's Gemfile:

    gem 'middleman-presentation'

And then execute:

    $ bundle

## Usage

*Initialize presentation*

This gem provides a helper to start a new presentatio from scratch. The given
options below need to be given on command line.

```bash
middleman presentation --title "my title" --speaker "Me"
```

The presentation helper provides a lot of more options. Use the help command to get an overview.

```bash
middleman help presentation
```

*Add new slide*

To add a new slide you can use the `slide`-helper.

```bash
middleman slide <name>
```

It is recommended to use a number as name greater than `00`, e.g. `01`.

```bash
middleman slide 01
```

If you prefer another template language you can provide that information as
part of the slide name. Today only `embedded ruby` and `markdown` are supported.

```bash
# embedded ruby
middleman slide 01.erb

# markdown
middleman slide 01.md
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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/middleman-presentation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
