# Hightop

Super convenient group count

```ruby
User.top(:gender)
```

instead of

```ruby
User.group(:gender).where("gender IS NOT NULL").order("count_all DESC, gender").count
```

Limit the results

```ruby
Visit.limit(10).top(:referring_domain)
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

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/hightop/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/hightop/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
