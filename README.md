# Hightop

A nice shortcut for group count queries

```ruby
Visit.top(:browser)
# {
#   "Chrome"  => 63,
#   "Safari"  => 50,
#   "Firefox" => 34
# }
```

Works with Active Record, Mongoid, arrays and hashes

[![Build Status](https://github.com/ankane/hightop/workflows/build/badge.svg?branch=master)](https://github.com/ankane/hightop/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'hightop'
```

## Options

Limit the results

```ruby
Visit.top(:referring_domain, 10)
```

Include nil values

```ruby
Visit.top(:search_keyword, nil: true)
```

Works with multiple groups

```ruby
Visit.top([:city, :browser])
```

And expressions

```ruby
Visit.top(Arel.sql("LOWER(referring_domain)"))
```

And distinct

```ruby
Visit.top(:city, distinct: :user_id)
```

And min count

```ruby
Visit.top(:city, min: 10)
```

## Arrays and Hashes

Arrays

```ruby
["up", "up", "down"].top
```

Hashes

```ruby
{a: "up", b: "up", c: "down"}.top { |k, v| v }
```

Limit the results

```ruby
["up", "up", "down"].top(1)
```

Include nil values

```ruby
[nil, nil, "down"].top(nil: true)
```

Min count

```ruby
["up", "up", "down"].top(min: 2)
```

## Upgrading

### 0.3.0

Hightop 0.3.0 protects against unsafe input by default. For non-attribute arguments, use:

```ruby
Visit.top(Arel.sql(known_safe_value))
```

Also, the `uniq` option has been removed. Use `distinct` instead.

## History

View the [changelog](https://github.com/ankane/hightop/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/hightop/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/hightop/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/hightop.git
cd hightop
bundle install
bundle exec rake test
```
