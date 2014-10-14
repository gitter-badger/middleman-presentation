# Middleman::Presentation::Helpers

This gem contains helpers for
[`middleman-presentation`](https://github.com/maxmeyer/middleman-presentation):

* Image gallery
* Images
* Some methods which could be core or helpers

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middleman-presentation-helpers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-presentation-helpers

## Usage

### Image gallery

If you want to create an image gallery in your slides you can use the
`image_gallery`-helper. It just needs an id for the gallery and a list of images.

```eruby
<%= image_gallery ['img/image1.png', 'img/image2.png'], id: 'my-gallery' %>
```

### Images

If you want to create an image in your slides and want it to have a fancy style, you can use the
`image`-helper. Just needs the name of the image.

```eruby
<%= image 'img/image1.png' %>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/middleman-presentation-helpers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
