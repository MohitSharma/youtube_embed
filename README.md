# YoutubeEmbed

Embed youtube videos in textarea from URL

1. Simple Embed

2. Embed with title, description & thumbnail

## Installation

Add this line to your application's Gemfile:

    gem 'youtube_embed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youtube_embed

## Usage

It can be used in model where we can specify simple iframe embed or embedding with thumbnail & description

Simple:

  youtube_embed :field_name, {:with_description => false, :width => 450, :height => 300}

With Thumbnail & Description:

  youtube_embed :field_name, {:with_description => false, :width => 450, :height => 300}


This will modify the youtube link into html required to embed, If you don't want to modify html or simple change the view you can call method in view like this:

 <?=  YoutubeEmbed::youtube_embed(attr_here) ?>

Working on further improvements

## Contributing

youtube_embed