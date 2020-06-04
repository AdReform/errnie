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

You can also pass `metadata`, `service_options`, and a block:

```ruby
# Passing metadata (used for contextual info about the error)
#
# for Bugsnag, this will be added as a new tab called `metadata`, unless
# you pass your own block, in which case `metadata` will be ignored
#
# for Appsignal, this will get passed in as tags
Errnie.notify(e, metadata: { user_id: 1 })

# Passing service_options
# which get passed to the underlying adapter
#
# In this example, this is a Bugsnag client option
Errnie.notify(e, service_options: { auto_notify: true })

# Passing a block
Errnie.notify(e, metadata: { user_id: '123' }) do |notification|
  # Bugsnag-specific syntax
  #
  # notification.add_tab(:some_tab, { with: :data })

  # Appsignal-specific syntax
  #
  # notification.set_action("my_action")
  # notification.set_namespace("my_namespace")
  # notification.params = { :time => Time.now.utc }
end
```

Blocks get passed along to the underlying service's gem. Refer to the service gem's documentation for more on what's available to you.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AdReform/errnie. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
