# ![controls insight](https://raw.github.com/ipwnstuff/controls.rb/master/docs/images/controlsinsight.png "controlsinsight") client gem
The **controls**insight (controls) gem interfaces with [Rapid7's **controls**insight API](http://docs.controlsinsight.apiary.io).

## Installation
Add this line to your application's Gemfile:

    gem 'controls'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install controls

## Documentation
* [Apiary API documentation](http://docs.controlsinsight.apiary.io)
* [YARD documentation for the Ruby client](http://www.rubydoc.info/github/ipwnstuff/controls.rb)

## Basic Resources
### Authentication
```ruby
Controls.web_endpoint = 'https://nexpose.local:3780/insight/controls'
Controls.api_endpoint = "#{Controls.web_endpoint}/api/1.0"

# If your endpoint uses a self-signed cert. turn off SSL cert. verification
Controls.verify_ssl = false

Controls.login :user => 'admin', :password => 'password'

Controls.client.methods
```

### Assessments
```ruby
# Retrieve all the assessments that have been ran
Controls.assessments
# => TODO: Add example output

# Only retrieve a single assessment
Controls.assessments(1)
# => TODO: Add example output
```


### Assets
```ruby
# Retrieve a list of all the assets that Controls has access to
Controls.assets
# => TODO: Add example output

# Only retrieve a single assessment
Controls.assets('your-asset-uuid-here')
# => TODO: Add example output
```

### Guidance
```ruby
# Only retrieve a single guidance by name
Controls.guidance('your-guidance-name-here')
# => TODO: Add example output
```

### Threats
```ruby
# Retrieve a list of all the threats
Controls.threats
# => TODO: Add example output

# Only retrieve a single threat
Controls.threats('threat-name-here')
# => TODO: Add example output
```

# Trends
```ruby
# Retrieve a set of statistics over time
Controls.threat_trends('threat-name-here')
# => TODO: Add example output

Controls.threat_vector_trends('vector-name-here')
# => TODO: Add example output

Controls.configuration_trends('configuration-name-here')
# => TODO: Add example output
```

## License
This project was created by [Erran Carey (@ipwnstuff)](http://ipwnstuff.github.io) and licensed under [the MIT License](LICENSE.md).
