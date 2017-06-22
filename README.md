# PrismicRails
[![Gem Version](https://badge.fury.io/rb/prismic_rails.svg)](https://badge.fury.io/rb/prismic_rails)
[![Build Status](https://travis-ci.org/fadendaten/prismic_rails.svg?branch=master)](https://travis-ci.org/fadendaten/prismic_rails)
[![Code Climate](https://codeclimate.com/github/fadendaten/prismic_rails.png)](https://codeclimate.com/github/fadendaten/prismic_rails)

Library to consume API-based CMS prismic.io and to display fetched content into your Rails app.

This gem uses [prismicio/ruby-kit](https://github.com/prismicio/ruby-kit) gem to consuem Prismic API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prismic-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prismic-rails

## Configuration

Copy the initializer file by running

    $ rails g prismic_rails:install

And then set the ENV variables you got from prismic.io.

#### I18n Support

prismic.io supports finer graded set of locals. To work with that we need to map
Rails locale to the locale prismic.io recognise.
Define the language hash as following:

```ruby
config.languages = {
  'en' => 'en-gb',
  'de' => 'de-ch',
  'fr' => 'fr-ch',
  'it' => 'it-ch',
  }
```
No need to configure language hash if you don't want I18n support. English will be used by default.


#### Caching

PrismicRails uses Rails caching to fasten the query process. You can choose to usse it or not to use it.

    $ config.caching = true

## Usage

From any view of your application we can do the following


  
#### Query the prismic type 'blog-post' and render each document as html

```ruby
<%= prismic_type 'blog-post' do |result| %>
  <%- result.documents.each do |document| %>
    <%= document.to_html %>
  <% end %>
<% end %>
```

#### Query the prismic type 'blog-post' in english

```ruby
<%= prismic_type 'blog-post', lang: 'en' do |result| %>
  <%- result.documents.each do |document| %>
    <%= document.to_html %>
  <% end %>
<% end %>
```

#### Query only the title of the type 'blog-post

```ruby
<%= prismic_type 'tea' do |result| %>
  <%= result.find_fragment('title').to_html %>
<% end %>
```

You can use `to_text` is case you want only the text. 

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

