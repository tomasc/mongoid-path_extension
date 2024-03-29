# Mongoid PathExtension

[![Build Status](https://travis-ci.org/tomasc/mongoid-path_extension.svg)](https://travis-ci.org/tomasc/mongoid-path_extension) [![Gem Version](https://badge.fury.io/rb/mongoid-path_extension.svg)](http://badge.fury.io/rb/mongoid-path_extension) [![Coverage Status](https://img.shields.io/coveralls/tomasc/mongoid-path_extension.svg)](https://coveralls.io/r/tomasc/mongoid-path_extension)

Mongoid field extension simplifying path parsing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid-path_extension'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-path_extension

## Usage

```ruby
class MyDoc
  include Mongoid::Document
  field :path, type: Mongoid::PathExtension
end

my_doc = MyDoc.new(path: 'LevelOne/LevelTwo/LevelThree')

my_doc.path # => 'LevelOne/LevelTwo/LevelThree'
my_doc.path.components # => %w(LevelOne LevelTwo LevelThree)
my_doc.path.absolute # => '/LevelOne/LevelTwo/LevelThree'
my_doc.path.root # => 'LevelOne'
my_doc.path.permalink # => 'LevelThree'
my_doc.path.parent_path # => 'LevelOne/LevelTwo'
my_doc.path.parent_permalink # => 'LevelTwo'
my_doc.path.has_parent? # => true

my_doc.path.permalink = 'NewPermalink'
puts my_doc.path.permalink # => 'NewPermalink'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomasc/mongoid-path_extension.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
