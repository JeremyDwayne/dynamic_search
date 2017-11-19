# DynamicSearch
DynamicSearch provides support for multi term searches to your rails models.

## Usage
This gem is still in development, and is not ready to be used yet. (11/19/2017)

1. Include the search module to any model you want DynamicSearch functionality
```ruby
include Search
```

2. Add and customize the search method to your models to specify how your search should work.
```ruby
def search(options)
  super(search, ["first_name", "last_name", "username", "email"])
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'dynamic_search'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install dynamic_search
```

## Contributing
If you find a bug, submit an issue or pull request if you've fixed it. Feel free to reach
out on twitter: [@jeremydwayne](https://www.twitter.com/jeremydwayne)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
