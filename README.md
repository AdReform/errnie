# Errnie

> Manually report errors to external error reporting services


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'errnie'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install errnie

## Usage

Errnie supports two backends: Bugsnag and Appsignal. To configure the backend globally:

```ruby
Errnie.configure do |config|
  config.default_service = 'Bugsnag'
end
```

To notify the backend of an error:

```ruby
begin
  code_that_raises_an_error
rescue => e
  Errnie.notify(e)
end
```

You can also pass options and a block, which will get passed to the underlying service adapter:

```ruby
# Adding Bugsnag metadata with a block
Errnie.notify(e) do |notification|
  notification.add_tab(:user, user.to_h)
end

# Adding Appsignal tags + block settings
Errnie.notify(e, user_id: '123') do |notification|
  notification.set_action("my_action")
  notification.set_namespace("my_namespace")
  notification.params = { :time => Time.now.utc }
end
```

Methods available on the block argument are specific to the underlying service's gem. Refer to the service gem's documentation for more on what's available in the block

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AdReform/errnie. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
