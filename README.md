# middleman-presentation

[![Build Status](https://travis-ci.org/maxmeyer/middleman-presentation.png?branch=master)](https://travis-ci.org/maxmeyer/middleman-presentation)
[![Coverage Status](https://coveralls.io/repos/maxmeyer/middleman-presentation/badge.png?branch=master)](https://coveralls.io/r/maxmeyer/middleman-presentation?branch=master)
[![Gem Version](https://badge.fury.io/rb/middleman-presentation.svg)](http://badge.fury.io/rb/middleman-presentation)

This project helps you to build wonderful presentations based on
[HTML](http://www.w3.org/html/) and JavaScript. The JavaScript-part is powered
by [`reveal.js`](https://github.com/hakimel/reveal.js), a great framework to
build HTML-/JavaScript-presentations. The infrastructure behind
`middleman-presentation` is powered by `middleman`, a flexible static site
generator which also offers a live preview of your presentation.

To get started with `middleman-presentation` you should know a little bit about
HTML, JavaScript, reveal.js and [Ruby](https://www.ruby-lang.org/en).
`middleman-presentation` will then help you wherever it can to make your life
easy with presentations.

## Installation

Add this line to your middleman application's Gemfile:

    gem 'middleman-presentation'

And then execute:

    $ bundle

And add the `activate`-statement to the `config.rb` of middleman:

```ruby
activate :presentation
```

## Release Notes

You find the release notes [here](RELEASE_NOTES.md) or on
[github](https://github.com/maxmeyer/middleman-presentation/blob/master/RELEASE_NOTES.md]).

## Supported rubies

* MRI 2.1.x

## Getting Started

### Initialize middleman presentation globally

To create a global configuration file for `middleman-presentation` you need to
run the following command:

```bash
middleman_presentation_init
```

This will create a configuration file at
`$HOME/.config/middleman/presentation/presentations.yaml`. The configuration options
given there will be used for all presentations created with
`middleman-presentation`. After running the command on a pristine system it
will contain the defaults.

Please run `cat $HOME/.config/middleman/presentation/presentations.yaml` to view them.

### Initialize middleman

```bash
middleman init my_presentation
cd my_presentation
```

### Add dependency to Gemfile and activate plugin

```bash
echo -e "\ngem 'middleman-presentation'" >> Gemfile
echo -e "\nactivate :presentation"       >> config.rb

bundle install
```

### Initialize presentation

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

### Add new slide

**MAKE SURE YOU NEVER EVER GIVE TWO SLIDES THE SAME BASENAME**, eg. 01.html.erb
and 01.html.md. This will not work with `middleman`.

To add a new slide you can use the `slide`-helper.

```bash
middleman slide <name>
```

It is recommended to use a number as name greater than `00`, e.g. `01`. If you
leave out the file extension the `slide`-helper will create a Markdown-slide by
default. If you want to overwrite this, please create a custom-slide-template -
see [Custom Templates](#custom_templates) for more information.

```bash
middleman slide 01
```

If you enter duplicate slide names, e.g. "02.md" and "02.erb", the
`slide`-command will fail. It is not possible to serve files with the same base
name - e.g. "02" - via `middleman`.

```bash
middleman slide 02.md 02.erb
# => will fail
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

If you want to create multiple slides at once, this is possible to. Just ask
`middleman-presentation` to do this.

```bash
middleman slide 01 02 03
```

There are some more options available. Please use the `help`-command to get an
overview.

```bash
middleman help slide
```

### Edit slide

To edit the slide after creating it use the `--edit`-switch. It uses the
`$EDITOR`-environment variable and falls back to `vim`.

```bash
middleman slide 01 --edit
```

If you want to edit an alread created slide, you can use the
`slide`-command as well. It creates slides if they do not exist and opens them
in your favorit editor (ENV['EDITOR']) if they already exist.

In some cases you might want to use a different editor-command. To change the
editor used or the arguments used, you can run `middleman-presentation` with
the `--editor-command`-switch.

```bash
middleman slide --edit --editor-command "nano" 01 02 03
```

The `editor-command`-string is also parsed by Erubis which makes the data
available in `metadata.yml` accessible to you. You can use this to start a vim server
with the presentation's project id as server name. This can be handy if you work more
or less simultaneously on diffent presentations. To make the use of the project
id as server name more stable you should use [`Shellwords.shellescape`](http://www.ruby-doc.org/stdlib-2.1.2/libdoc/shellwords/rdoc/Shellwords.html#method-c-shellescape).

```bash
middleman slide --edit --editor-command "vim --servername <%= Shellwords.shellescape(project_id) %> --remote-tab 2>/dev/null" 01 02 03
```

### Start presentation

To start your presentation use the `start`-script. It opens the presentation in
your browser and starts `middleman`. After `middleman` has started you just
need to reload the presentation in the browser.

```bash
script/start
```

### Export presentation

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

### Ignore slides

*Introduction*

Sometimes you may want to slides to be available in the filesystem, but not
part of your presentation. To make this possible you can use the
`.slidesignore`-file. If you prefer a different name, change the
configuration-option `:slides_ignore_file`.

*Patterns*

Every line is a regular expression checked against the file names of existing
slides. To "unignore" particular slides, you can prefix your pattern with "!".

```config
# ignore all slides ending with *.md
.*\.md
# unignore 01.html.md
!01.html.md
```

## Usage of external resources

I encourage you to use `bower` to make external resources within your presentation
available. This works fine together with the asset pipeline `middleman` uses:
[sprockets](https://github.com/sstephenson/sprockets). Just add resources to
your (existing) `bower.json` and make yourself comfortable with bower:
http://bower.io/. Reference the resources from within your
`javascripts/application.js` and/or
`stylesheets/application.scss`

By using `bower` for external resources you can better separate the slide
content from your styles.

If you created your presentation using the `middleman presentation`-command,
files named "bower.json" and ".bowerrc" should exist. Within "bower.json" you
define the dependencies of your presentation. The last one can be used to tell
bower where to store the downloaded components.

To reference your assets you should use helpers. There are helpers avaiable for
Ruby-code and for Sass-code.

* `asset_path(type, name)`, `asset_url(type, name)`:

To reference an arbitrary type you can use the both *ruby* helpers mentioned above. To
reference a JavaScript-file use `asset_path(:js,
'<component>/<path>/<file>.js')`.

* `font-path(name)`, `font-url(name)`, `image-path(name)`, `image-url(name)`:

The helpers above can be used to reference assets in Sass-files. You need to
provide name to reference the asset, e.g.
`font-path('<component>/<path>/<file>.ttf')`.

To import Css- and Sass-files you should use the `@import`-command. To import
JavaScript-files from JavaScript-files you should use the `//=
require`-command.

Please see [sass](http://sass-lang.com/documentation/file.SASS_REFERENCE.html)
and [sprockets](https://github.com/sstephenson/sprockets) for more information
about that topic.

*Themes*

An example for a `bower`-enabled theme can be found at
https://github.com/maxmeyer/reveal.js-template-fedux_org.

## Creating slides

### Introduction

You need to decide if you want to create slides in pure HTML or if you want to
use [`Markdown`](http://daringfireball.net/projects/markdown/syntax). It's up
to you to make your choice. In most cases you should get along with `Markdown`
&#9786;. From version `0.6.0` onwards
[`kramdown`](http://kramdown.gettalong.org/syntax.html) is used to parsed
Markdown. because it supports "Attribute List Definitions" which can be used,
to provide HTML-attributes to Markdown-elements. Something similar to what
[reveal.js](https://github.com/hakimel/reveal.js/#element-attributes) does.

### Grouping Slides
<a name="grouping_slides"></a>

`reveal.js` has a feature called "vertical slides". You can use this to add
"additional" slides to your presentation to add some auxiliary information.
To use this feature you need to place slides grouped together in a directory.

```
# Single slide without namespace
01.html.erb

# Group "02_hello" of three slides namespace by 02_hello
02_hello/01.html.erb
02_hello/02.html.erb
02_hello/03.html.erb

# Group "03_world" of two slides namespace by 03_world
03_world/01.html.erb
03_world/02.html.erb
```

If you prefer to use the `slide`-command to create your slides, you can create a
namespaced slide by using the following synatx:

```
middleman slide 02_hello:01
```

Those commands will create a directory named `02_hello` and a file named `01.html.erb`.

## Creating templates

### Normal templates

To create slides using the `slide`-command templates are used. They are written in
Eruby (erb). For a good documentation about Eruby see the [Erubis User
Guide](http://www.kuwata-lab.com/erubis/users-guide.html). Since `0.11.4`. you
can have your own templates which overwrite the default templates.

You can store those templates in different directories. They are read in the
given order.

1. presentation local (`<presentation root>/templates/<template>`)
2. user local (`~/.config/middleman/presentation/templates/<template>`, `~/.middleman/presentation/templates/<template>`)
3. system local templates (`/etc/middleman/presentation/templates/<template>`)


There are four different templates available:

* Erb (`erb.tt`): Templates for generating `Erb`-slides
* Markdown (`markdown.tt`): Templates for generating `markdown`-slides
* Liquid (`liquid.tt`): Templates for generating `liquid`-slides
* Group (`group.tt`): Templates for groups of slides - see [Grouping Slides](#grouping_slides).

### Custom templates

<a name="custom_templates"></a>

Addiontionlly users can define one `custom`-slide-template. It's file extension
is used for the resulting slide. Given a template `custom.erb.tt` it becomes
`01.html.erb` when running `middleman slide 01`.

## Configuration

`middleman-presentation` will try its configuration file at different places:

1. User local: `~/.config/middleman/presentation/presentations.yaml`, `~/.middleman/presentation/presentations.yaml`
2. System local: `/etc/middleman/presentation/presentations`

To get a full list of available configuration options, run the following command

```
middleman config
```

## Development

Make sure you've got a working internet connection before running the tests. To
keep the source code repository lean there tests that download assets via bower.

If you care about licensing, please have a look at [LICENSE.txt](LICENSE.txt).
As this software would not be possible without the wonderful gems out there,
there's also an overview about all the licenses used by the required gems at
[doc/licenses/dependencies.html](doc/licenses/dependencies.html). 

## Contributing

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file.

