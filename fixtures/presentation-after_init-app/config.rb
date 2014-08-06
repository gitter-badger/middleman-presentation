###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :presentation

set :markdown_engine, :kramdown
set :markdown, parse_block_html: true

bower_directory = 'vendor/assets/components'

if respond_to? :sprockets and sprockets.respond_to? :import_asset
  sprockets.append_path File.join(root, bower_directory )

  patterns = [
    '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
    '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
    '.js',                                    # Javascript
    #'.html',                                  # HTML
  ].map { |e| File.join(bower_directory, "**", "*\#{e}" ) }

  require 'rake/file_list'

  list = Rake::FileList.new(*patterns) do |l|
    l.exclude(/src/)
    l.exclude(/test/)
    l.exclude(/demo/)
    l.exclude { |f| !File.file? f }
  end

  list.each do |f|
    sprockets.import_asset Pathname.new(f).relative_path_from(Pathname.new(bower_directory))
  end

  Rake::FileList.new(File.join('vendor/assets/components', "**", 'notes.html' )).each do |f|
    sprockets.import_asset(Pathname.new(f).relative_path_from(Pathname.new(bower_directory))) { |local_path| Pathname.new('javascripts') + local_path }
  end

  Rake::FileList.new(File.join('vendor/assets/components', "**", 'pdf.css' )).each do |f|
    sprockets.import_asset(Pathname.new(f).relative_path_from(Pathname.new(bower_directory))) { |local_path| Pathname.new('stylesheets') + local_path }
  end
end
