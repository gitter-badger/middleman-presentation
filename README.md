# middleman-presentation

[![Build Status](https://travis-ci.org/fedux-org/middleman-presentation.png?branch=master)](https://travis-ci.org/fedux-org/middleman-presentation)
[![Coverage Status](https://coveralls.io/repos/maxmeyer/middleman-presentation/badge.png?branch=master)](https://coveralls.io/r/maxmeyer/middleman-presentation?branch=master)
[![Gem Version](https://badge.fury.io/rb/middleman-presentation.svg)](http://badge.fury.io/rb/middleman-presentation)
[![Inline docs](http://inch-ci.org/github/maxmeyer/middleman-presentation.svg?branch=master)](http://inch-ci.org/github/maxmeyer/middleman-presentation) 

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

Why you would like to use `middleman-presentation` instead of pure `reveal.js`?

* It provides helper-commands for recurring tasks, e.g. create new
  presentations, create new slides, editing slides or renaming existing slides
* It separates data (slides) from style (theme) by using bower + sprockets
* It supports a lot of template languages, e.g. Markdown, Erb, Liquid
* It provides templates, but give you the freedom to define your own ones
* It can be extended by using ruby

## Installation

### Gem

Install via rubygems

    gem install middleman-presentation

Or add this line to your middleman application's Gemfile:

    gem 'middleman-presentation'

And then execute:

    $ bundle

### External Dependencies
<a name="external_dependencies"></a>

**Nodejs**

Please install [`nodejs`](https://github.com/joyent/node). It is required by
`bower` - see [bower](#bower_install)-section below. It is recommended to
install it via [package
manager](https://github.com/joyent/node/wiki/installing-node.js-via-package-manager).

It is recommended to configure the path where global packages are installed.
That ensures that you do not need to install global packages as `root`.

1. Create `.npmrc`

  ```bash
  # Change <user> to your user
  prefix = /home/<user>/.local/share/npm
  
  # If you need to use a coporate proxy, add those lines as well.
  # Be careful `https-proxy` needs use a `http`-url, not a `https`-one
  # proxy = http://localhost:3128
  # https-proxy = http://localhost:3128
  ```

2. Make executables of nodejs-packages available via PATH

   Add `npm`-bin dir to your PATH-variable via `.bashrc`, `.zshrc` or whatever
   initialization-script your shell uses.

    ```bash
    export PATH=~/.local/share/npm/bin:$PATH
    ```

**Bower**
<a name="bower_install"></a>

You also need to install [`bower`](http://www.bower.io). It is used to install
the assets (CSS-, JavaScript-files etc.).

```bash
npm install -g bower
```

**JavaScript Engine**

Make sure you've got a javascript engine installed. Please follow the
instructions found [here](https://github.com/sstephenson/execjs). I do not add
this as a runtime-dependency to this gem. So it is your choice what engine you want to
use.

## Supported rubies

* MRI >= 2.1.x

## Release Notes

You find the release notes [here](RELEASE_NOTES.md) or on
[github](https://github.com/maxmeyer/middleman-presentation/blob/master/RELEASE_NOTES.md).

## Find help

* This [README.md](README.m)
* A good [tutorial](http://htmlcheats.com/reveal-js/reveal-js-tutorial-reveal-js-for-beginners/) tutorial about `reveal.js`
* The [documentation](https://github.com/hakimel/reveal.js/) of `reveal.js`
* The [documentation](http://middlemanapp.com/) of `middleman`
* The [documentation](middleman-presentation-helpers/README.md) about `middleman-presentation-helpers`
* Run help command of `middleman-presentation`

  ```bash
  bundle exec middleman-presentation help
  ```

## Getting Started

### Running `middleman-presentation`

There are two relevant commands. You can use which you prefer. `mp` is just a
link to `middleman-presentation`.

* Long: `middleman-presentation`
* Short: `mp`

For commandline parsing `middleman-presentation` uses
[`thor`](https://github.com/erikhuda/thor). `thor` supports shortcuts for
subcommands. You only need to type that much characters so that `thor` can
figure out itself, what subcommand you mean.

Long one:

```
middleman-presentation change slide 01
```

Short one:

```
middleman-presentation ch s 01
```

Just typing `c` would not be enough and will result in an error message,
because there's also a `create`-subcommand and `c` would match bot the
`create`- and the `change`-subcommand.

### Initialize `middleman-presentation` globally

To create a global configuration file for `middleman-presentation` you need to
run the following command:

```bash
middleman-presentation init application
```

This will create a configuration file at
`$HOME/.config/middleman-presentation/application.yaml`. The configuration options
given there will be used for all presentations created with
`middleman-presentation`. After running the command on a pristine system it
will contain the defaults. Please run `cat
$HOME/.config/middleman-presentation/application.yaml` to view them. 

Please see [Configuration](#configuration) for more information about
how to configure `middleman-presentation` (correctly).

### Initialize presentation

This gem provides a helper to start a new presentatio from scratch. The given
options below need to be given on command line.

```bash
# long
middleman-presentation create presentation --title "my title" --speaker "Me"
```

### Start your presentation

To start your presentation use the `start`-script. It opens the presentation in
your browser and starts `middleman`. After `middleman` has started you just
need to reload the presentation in the browser.

```bash
# Short
script/start

# Long
bundle exec middleman-presentation serve presentation
```

### Add new slide

**MAKE SURE YOU NEVER EVER GIVE TWO SLIDES THE SAME BASENAME**, eg. 01.html.erb
and 01.html.md. This will not work with `middleman`.

To add a new slide you can use the `slide`-helper.

```bash
bundle exec middleman-presentation create slide <name>
```

It is recommended to use a number as name greater than `00`, e.g. `01`. If you
leave out the file extension the `slide`-helper will create a Markdown-slide by
default. If you want to overwrite this, please create a custom-slide-template -
see [Custom Templates](#custom_templates) for more information.

```bash
bundle exec middleman-presentation create slide 01
```

If you enter duplicate slide names, e.g. "02.md" and "02.erb", the
`slide`-command will fail. It is not possible to serve files with the same base
name - e.g. "02" - via `middleman`.

```bash
bundle exec middleman-presentation create slide 02.md 02.erb
# => will fail
```

If you prefer another template language you can provide that information as
part of the slide name. Today only `embedded ruby`, `markdown` and `liquid`-templates are supported.

```bash
# embedded ruby
bundle exec middleman-presentation create slide 01.erb

# markdown
bundle exec middleman-presentation create slide 01.md
bundle exec middleman-presentation create slide 01.markdown

# liquid
bundle exec middleman-presentation create slide 01.l
bundle exec middleman-presentation create slide 01.liquid

# nested template engines
# first run eruby and then the markdown parser
bundle exec middleman-presentation create slide 01.md.erb
```

To set a title for the slide use the `--title`-switch.

```bash
bundle exec middleman-presentation create slide 01 --title 'my Title'
```

If you want to create multiple slides at once, this is possible to. Just ask
`middleman-presentation` to do this.

```bash
bundle exec middleman-presentation create slide 01 02 03
```

There are some more options available. Please use the `help`-command to get an
overview.

```bash
bundle exec middleman help slide
```

Both provide the possibility to change the port where middleman should listen
on. Use `-h` check on available options.

### Edit slide

There are two ways to edit a slide:

1. Edit existing slides
2. Edit non-existing slides

The first way is the more obvious one. Run `middleman-presentation` and tell it
to open a slide. If the requested slide does not exist, it will output an error
message.

```bash
bundle exec middleman-presentation edit slide 01
```

If you want to open all existing slides you just need to leave out the
`names`-argument.

```bash
bundle exec middleman-presentation edit slide
```

By default the `edit`-command compares the input agains the base name of a
slide (file name: "01.html.erb", base name: "01"). You want to match against
the full file name you can use the `--regex`-option which also switches from
string to regex matching.

If you want to create non-existing slides along editing existing ones, you need
to run the `create slide`-command with the `--edit`-option.
`middleman-presentation` uses the `$EDITOR`-environment variable and falls back
to `vim`.

```bash
bundle exec middleman-presentation create slide 01 --edit
```

In some cases you might want to use a different editor-command. To change the
editor used or the arguments used, you can run `middleman-presentation` with
the `--editor-command`-switch.

```bash
bundle exec middleman-presentation create slide --edit --editor-command "nano" 01 02 03
```

The `editor-command`-string is also parsed by Erubis which makes the data
available in `metadata.yml` accessible to you. You can use this to start a vim server
with the presentation's project id as server name. This can be handy if you work more
or less simultaneously on diffent presentations. To make the use of the project
id as server name more stable you should use [`Shellwords.shellescape`](http://www.ruby-doc.org/stdlib-2.1.2/libdoc/shellwords/rdoc/Shellwords.html#method-c-shellescape).

```bash
bundle exec middleman-presentation create slide --edit --editor-command "vim --servername <%= Shellwords.shellescape(project_id) %> --remote-tab 2>/dev/null" 01 02 03
```

### Rename a slide

If you need to rename a slide, you can do it on your own or let
`middleman-presentation` does it for you.

*Rename base name*

This works for singles slides only.

```bash
# Rename slide 02.html.erb to 01.html.erb
touch source/slides/02.html.erb
bundle exec middleman-presentation change slide 02 --name 01 
```

*Change type of slide*

```bash
# Rename slide 02.html.erb, 03.html.erb to <name>.html.md
touch source/slides/02.html.erb
touch source/slides/03.html.erb
bundle exec middleman-presentation change slide 02 03 --type md 
```

*Edit slide after renaming it*

```bash
# Rename slide 02.html.erb, 03.html.erb to <name>.html.md
touch source/slides/02.html.erb
touch source/slides/03.html.erb
bundle exec middleman-presentation change slide 02 03 --type md --edit
```

*Automatically switch template type*

Eruby-Templates will be renamed automatically to Markdown-Templates and vice
versa, if you leave out the `--type` and `--base-name`-option.

```bash

# Rename slide 01.html.erb to 01.html.md
touch source/slides/01.html.erb
bundle exec middleman-presentation change slide 01

# Rename slide 01.html.md to 01.html.erb
touch source/slides/01.html.md
bundle exec middleman-presentation change slide 01
```

All other types, will be renamed automatically to Markdown-Templates.

```bash
# Rename slide 01.html.liquid to 01.html.md
touch source/slides/01.html.liquid
bundle exec middleman-presentation change slide 01
```

### Remove a slide

If you remove a slide while `middleman` is showing the presentation, you might
experience some weird errors. Please restart `middleman` after you removed a
slide and everything will be fine again.

### Export presentation

If you need to export the presentation, you can use the `export`-script. It
creates zip-file in the current directory `<date of presentation>-<title of presentation>.zip`.

```bash
script/export
# => Creates zip-file in <root>
```

If you need to modify the export, you can use `middleman-presentation export`.
It is the same command which is used by `script/export` behind the scenes.

*Use defaults*

```bash
middleman-presentation export presentation
```

*Different output file*

```bash
middleman-presentation export presentation --output-file archive.zip
```

*Different prefix for files in zip-file*

Please mind the "/" at the end if you want the files to be prefixed by a
directory.

```bash
middleman-presentation export presentation --prefix 'my_presentation/'
```

The export command also places a `config.ru` within the zip-file. So if you
want to reuse that exported presentation, unzip the file, install `rack`, 
run `rackup` within the created directory and open a browser pointing to the
url which was printed on stdout.

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
bundle exec middleman-presentation create slide 02_hello:01
```

Those commands will create a directory named `02_hello` and a file named `01.html.erb`.

## Use external resources

I encourage you to use `bower` to make external resources within your presentation
available. This works fine together with the asset pipeline `middleman` uses:
[sprockets](https://github.com/sstephenson/sprockets). Just add resources to
your (existing) `bower.json` and make yourself comfortable with bower:
http://bower.io/. Reference the resources from within your
`javascripts/application.js` and/or
`stylesheets/application.scss`

By using `bower` for external resources you can better separate the slide
content from your styles.

If you created your presentation using the `middleman-presentation`-command,
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

## Creating themes

To create your own theme for `middleman-presentation`, you should use the
`theme`-command. It will create a new directory in the current directory
(`$PWD`) based on the name for the template, e.g. `new_theme`.

```
cd my_presentation
middleman-presentation create theme new_theme
```

Or if you want to get a more or less empty stylesheet, run it with
`--clean-css`.

```
cd my_presentation
middleman-presentation create theme new_theme --clean-css
```

After that a directory `new_theme` exists with some sub-directories:

* `javascripts`: Javascript-file go here
* `stylesheets`: Stylesheets (CSS, SCSS, ..) go here
* `images`: Image go here

To use your newly created files you need to modify the
`middleman-presentation`-configuration file and add the following yaml-snippet
to the file - see [Configuration](#configuration) for more about the
`middleman-presentation`-configuration file.

```yaml
theme:
  name: new_theme
  github: <github_account>/<repository>
  javascripts:
    - javascripts/<name>
  stylesheets:
    - stylesheets/<name>
```

If you prefer to learn by example, look at the default-theme at
[github](https://github.com/maxmeyer/middleman-presentation-theme-default).

To give you an overview about all css-classes used within templates, issue the
`style`-command. This will print every available css-class to style existing
templates. Each of those classes is prefixed with `mp-`.

```bash
middleman-presentation show style
# => mp-speaker
# => [...]
```

## Creating slide templates

### Normal slide templates

<a name="normal_slide_templates"></a>

To create slides using the `slide`-command templates are used. They are written in
Eruby (erb). For a good documentation about Eruby see the [Erubis User
Guide](http://www.kuwata-lab.com/erubis/users-guide.html). Since `0.11.4`. you
can have your own templates which overwrite the default templates.

You can store those templates in different directories. They are read in the
given order.

1. presentation local templates (`<presentation root>/templates/<template>`)
2. user local templates (`~/.config/middleman-presentation/templates/<template>`, `~/.middleman-presentation/templates/<template>`)
3. system local templates (`/etc/middleman-presentation/templates/<template>`)


There are four different templates available:

* Erb (`erb.tt`): Templates for generating `Erb`-slides
* Markdown (`markdown.tt`): Templates for generating `markdown`-slides
* Liquid (`liquid.tt`): Templates for generating `liquid`-slides
* Group (`group.tt`): Templates for groups of slides - see [Grouping Slides](#grouping_slides).

### Custom slide templates

<a name="custom_templates"></a>

Addiontionlly users can define one `custom`-slide-template. It's file extension
is used for the resulting slide. Given a template `custom.erb.tt` it becomes
`01.html.erb` when running `middleman-presentation create slide 01`. 

You may need to add the
template parser-gem to your `Gemfile` and require it in your `config.rb`.

**Example**

Given you want to create a presentation local custom slide template with haml
as template language. The created slides should automatically get `.haml` as
file extension. First you need to create the template directory.

```bash
# Switch to the directory containing your presentation
cd my_presentation

# Create template directory
mkdir -p templates
```

Next you need to create the template itself using your favourite template
language. If you want to use information like the presentation title, don't forget the
template itself is parsed by `Erubis` before it is stored as slide in the file
system.

*templates/custom.haml.tt*:

```
%section
  %h1 Site Title
  %h2 <%%= title %>
```

After writing the file to the filesystem you can use it with the
`slide`-command to create slide by running the following code.

```bash
# => creates source/slides/01.html.haml
bundle exec middleman-presentation create slide 01
```

If you have more than one "custom"-template the first is one used. The order is
based on file name.

### Predefined slide templates

There are four predefined slide templates available:

* Start slide
  * Slide name: `00.html.erb.tt`
* Questions slide
  * Slide name: `999980.html.erb.tt`
* Contact slide
  * Slide name: `999981.html.erb.tt`
* End slide
  * Slide name: `999982.html.erb.tt`

If you place templates in one of the template directories - see [Normal Slide
Templates](#normal_slide_templates) for the concrete paths -
`middleman-presentation` will use your templates instead of the ones comming
with the gem.

If you want to modify the existing predefined slides, run the following command first,
it will copy the files to
`~/.config/middleman-presentation/templates/predefined_slides.d`.

```
middleman-presentation init predefined_slides
```

Make sure that your templates end with with `.tt`. Otherwise they will not be
used. Also make sure, that you use the correct `erb`-Markup. If code should be
evaluated when creating a new presentation use `<% %>`, `<%= %>` etc. If you
have code which should be evaluated on presentation runtime, please use `<%%
%>`, `<%%= %>` - see doubled "%".

## Configuration

<a name="configuration"></a>

`middleman-presentation` will try to find its configuration file at different places:

1. User local: `~/.config/middleman-presentation/application.yaml`, `~/.middleman-presentation/application.yaml`
2. System local: `/etc/middleman-presentation/application.yaml`

To get a full list of available configuration options and their values, run the following command

```
middleman-presentation show config
```

To get a full list of available configuration options and their default values, run the following command

```
middleman-presentation show config --defaults
```

## Plugins

`middleman-presentation` supports plugins. They should be named
`middleman-presentation-<plugin_name>`. If you want them to be automatically
loaded, place an empty file named `middleman-presentation-plugin.rb` under
`lib/` and add an entry in your config-file under `plugins:`. Your plugin is
then loaded via `require 'middleman-presentation-<plugin_name>'`. So please
make sure, that your "main"-library-file is named
`middleman-presentation-<plugin_name>.rb` and is within `$LOAD_PATH`.

*Example for configuration*

```ruby
plugins:
  - middleman-presentation-<plugin_name>
```

You need to extend your module with `PluginApi` to get the api-methods. To
add a frontend component use `add_component`, to add assets use `add_assets`
and so on. See the following code block as an example.

```ruby
# encoding: utf-8
module Middleman
  module Presentation
    # Test plugin
    module Test
      # Simple
      module Simple
        extend PluginApi

        # Load other plugins
        require_plugin 'plugin1'
        require_plugin ['plugin1']
        require_plugin 'plugin1', 'plugin2'

        add_assets(
          File.expand_path('../../../../../../vendor/assets', __FILE__)
        )

        add_component(
          name: 'impress.js',
          version: 'latest',
          # Make files available in `js/application.js` and `css/application.scss`
          importable_files: [
          /pattern1/
          ],
          # Make files available in build directory
          loadable_files: [
          /pattern2/
          ],
          # Ignore files
          ignorable_files: [
          /.*\.tmp/
          ]
        )

        add_helpers do
          def test_simple_helper1
            'test_simple_helper1'
          end
        end

        add_helpers Middleman::Presentation::Test::Simple::Helpers
      end
    end
  end
end
```

If your application needs some other plugins loaded first, use the
`require_plugin'-method. For more detailed examples, please see the example
above. 

## Order of assets in `application.scss` and `application.js`

The order of assets which are generated from frontend or asset components
depends on load order. There is NO complicated algorithm building up dependency
tree.

If you need to take care about the order of your assets,
e.g. Stylesheets/JavaScript-files, make sure the files in your plugins are
loaded (via ruby-`require`) in the correct order. Additionally the order of the plugin-api-methods
`#add_component`, `#require_plugin` and `#add_assets` are important as well.

There's a configuration option named `components`. The order of that array is
the order of that assets in your `application.scss` and `application.js`. The
assets given here are loaded AFTER assets of any plugin you activated.

Look [here](https://github.com/maxmeyer/middleman-presentation/blob/middleman-presentation-core/lib/middleman-presentation-core/assets_loader.rb)
if you're interested in which order assets are imported.


## Embedded Code in Slides (Syntax Highlighting)

`middleman-presentation` supports syntax highlighting in `<code>`-blocks. It
does not matter if you've got a Markdown- or whatevery-template-format. It uses
[`highlight.js`](https://github.com/isagalaev/highlight.js) behind the scenes.
Please be aware I decided to use the `latest` version downloaded via `bower`. I
do not use the version which comes with `reveal.js`.

### Highlighting

*Markdown*

```markdown
~~~ ruby
puts 42
~~~
```

*HTML*

```html
<pre><code class="ruby">puts 42</code></pre>
```

### Disable highlight

*Markdown*

```markdown
~~~ nohighlight
puts 42
~~~
```

*HTML*

```html
<pre><code class="nohighlight">puts 42</code></pre>
```

## Development

### Introduction

Make sure you've got a working internet connection before running the tests. To
keep the source code repository lean there tests that download assets via
`bower` and install gems via `bundler`.

If you care about licensing, please have a look at [LICENSE.txt](LICENSE.txt).
As this software would not be possible without the wonderful gems out there,
there's also an overview about all the licenses used by the required gems at
[doc/licenses/dependencies.html](doc/licenses/dependencies.html). 

### External Dependencies

The dependencies listed here are additional to the ones listed
[here](#external_dependencies).

**Go Language**

To make it easier for users to serve a pre-built presentation
`middleman-presentation` uses a [static
webserver](https://github.com/dg-ratiodata/local_webserver) build with
[Go](https://www.golang.org). This webserver is pre-compiled if you are using
the `rubygem`. You need to install `Go` and build it yourself when cloning this
repository. 

See [this page](http://docs.drone.io/golang.html) for a good introduction for a
`Go`-installation which can compile `Go`-binaries for multiple operating
systems - tested on Archlinux (64bit) only.

*Clone repository*

```bash
hg clone -u release https://code.google.com/p/go <golang_path>
hg update default
```

*Build go*

```bash
cd <golang_path>
GOOS=windows GOARCH=amd64 ./make.bash --no-clean 2> /dev/null 1> /dev/null
GOOS=darwin  GOARCH=amd64 ./make.bash --no-clean 2> /dev/null 1> /dev/null
GOOS=linux  GOARCH=amd64 ./make.bash --no-clean 2> /dev/null 1> /dev/null
```

*Add to PATH*

```bash
export PATH=<golang_path>/bin:$PATH
```

### Getting started

1. Install ruby
2. Run bootstrapping-script

   It's quite **important** that you run this script. This script will install
   `rake` and call `rake`-tasks to prepare your environment.

   * Install `bower`
   * Install `gems`
   * Download and compile static webserver

   ```bash
   scripts/bootstrap
   ```

3. Run testing-script

   Just to make sure, that everything is fine and nothing is broken, please run
   the testing-scrip before start to develop new code or fix bugs.

   ```bash
   scripts/test
   ```

### Task Automation

I chose to use `rake` to automate a lot of tasks.  There's a `Rakefile` for each
sub-project and one main `Rakefile`. Please run the following command to get an
overview about all commands.

```bash
rake -T
```

## Tips

### Weird Errors

If you get some weird errors during testing, make sure have got enough space at
`/tmp`. This directory is used by `bower` to temporary store downloaded assets.

To check which file consumes the whole space at `/tmp` you can use the following command:

```bash
# output sizes in mebibytes and sort numerically
du -ms /tmp/* | sort -n
```

To find the process which uses this file, run this command:

```bash
lsof <file>
```

### Use default license template for all your presentations

If you place a license template at
`.config/middleman-presentation/templates/presentation_license.md.tt`, this
template will be used every time you create a new presentation to create the
included license file.

If you prefer to use a different file extension rename just change the file extension of your template:

* `presentation_license.md.tt` will become `LICENSE.md`
* `presentation_license.erb.tt` will become `LICENSE.erb`
* &hellip;

### Use default readme template for all your built presentations

If you place a readme template at
`.config/middleman-presentation/templates/build_readme.md.tt`, this
template will be used every time you build a new presentation to create the
included readme file.

If you prefer to use a different file extension rename just change the file extension of your template:

* `build_readme.md.tt` will become `README.md`
* `build_readme.erb.tt` will become `README.erb`
* &hellip;

### Modifying footer metadata fields

There's a configuration option which needs to be modified to change the fields,
which are displayed in the footer. Every field is surrounded with `<span
class="mp-meta-field_name">field_value</span>`. You can use every field from
your `middleman-presentation`-config - [Configuration](#configuration).

```yaml
# Default
metadata_footer:
  - :date
  - :author
  - :license
```

To style your footer, you can use the following snipped:

```sass
footer.mp-presentation-footer {
  .mp-meta-field_name {
    // your style
  }
}
```

### Modifying headline metadata fields

There's a configuration option which needs to be modified to change the fields,
which are displayed in the footer. Every field is surrounded with `<span
class="mp-meta-field_name">field_value</span>`. You can use every field from
your `middleman-presentation`-config - [Configuration](#configuration).

```yaml
# Default
metadata_headline:
  - :date
  - :speaker
  - :company
  - :version
  - :license
```

To style your footer, you can use the following snipped:

```sass
span.mp-meta {
  .mp-meta-field_name {
    // your style
  }
}
```

### Quoting in Markdown Documents

If you're German or French you might want to change the default quotes which
are used by `kramdown` to transform `'` and `"`. There's a configuration option
for this.

*Kramdown Default*

This is the default kramdown uses:

```yaml
smart_quotes:
  - lsquo # opening '
  - rsquo # closing '
  - ldquo # opening "
  - rdquo # opening "
```

*German*

If you're German use this setting:

```yaml
smart_quotes:
  - lsquo # opening '
  - rsquo # closing '
  - bdquo # opening "
  - rdquo # opening "
```

*Disable smart quotes*

If you want to "disable" smart quotes, just use this setting:

```yaml
smart_quotes:
  - apos  # opening '
  - apos  # closing '
  - quote # opening "
  - quote # opening "
```

## Contributing

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file.

