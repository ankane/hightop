# Hightop

A nice shortcut for group count queries

[![Build Status](https://travis-ci.org/ankane/hightop.svg)](https://travis-ci.org/ankane/hightop)

```ruby
Visit.top(:browser)
```

instead of

```ruby
Visit.group(:browser).where("browser IS NOT NULL").order("count_all DESC, browser").count
```

Be sure to [sanitize user input](http://rails-sqli.org/) like you must with `group`.

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
Visit.top("LOWER(referring_domain)")
```

And distinct

```ruby
Visit.top(:city, uniq: :user_id)
```

And min count

```ruby
Visit.top(:city, min: 10)
```

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'hightop'
```

And then execute:

```sh
bundle
```

## History

View the [changelog](https://github.com/ankane/hightop/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/hightop/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/hightop/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
