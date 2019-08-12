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

Also works with arrays and hashes

```ruby
["up", "up", "down"].top(1)
```

[![Build Status](https://travis-ci.org/ankane/hightop.svg)](https://travis-ci.org/ankane/hightop)

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

## User Input

If passing user input as the column, be sure to sanitize it first [like you must](https://rails-sqli.org/) with `group`.

```ruby
column = params[:column]

# check against permitted columns
raise "Unpermitted column" unless ["column_a", "column_b"].include?(column)

User.top(column)
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

## History

View the [changelog](https://github.com/ankane/hightop/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/hightop/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/hightop/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
