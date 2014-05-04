# controlsinsight client gem
[![Build Status](https://travis-ci.org/erran/controls.rb.png?branch=master)](https://travis-ci.org/erran/controls.rb)

The controlsinsight (controls) gem interfaces with [Rapid7's controlsinsight API](http://rapid7.github.io/controlsinsight.rb).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'controls'
```

And then execute:
```bash
bundle
```

Or install it yourself as:
```bash
gem install controls
```

## Documentation
* [API documentation](http://rapid7.github.io/controlsinsight.rb)
* [YARD documentation for the Ruby client](http://www.rubydoc.info/github/rapid7/controlsinsight.rb)

## Basic Resources
### Authentication
```ruby
Controls.web_endpoint = 'https://nexpose.local:3780/insight/controls'
Controls.api_endpoint = "#{Controls.web_endpoint}/api/1.0"

# If your endpoint uses a self-signed cert. turn off SSL cert. verification
Controls.verify_ssl = false

Controls.login(username: 'admin', password: 'password')

Controls.client.api_methods
# => [:applicable_assets, :assessments, :asset_search, :assets, :assets_by_configuration, :assets_by_guidance, ..., :uncovered_assets, :undefended_assets, :update_security_controls]
```

### Assessments
```ruby
# Retrieve all the assessments that have been ran
Controls.assessments
# => [#<Controls::Assessment: id: 1, timestamp: 2013-12-15 10:07:39 -0600, assessing: false, high_risk_asset_count: 18,
#     medium_risk_asset_count: 0, low_risk_asset_count: 0, total_asset_count: 18, overall_risk_score: 1.1723226070935302>]

# Only retrieve a single assessment
Controls.assessments(2)
# => #<Controls::Assessment: id: 2, timestamp: 2014-02-06 17:35:02 -0600, assessing: false, high_risk_asset_count: 0,
#    medium_risk_asset_count: 42, low_risk_asset_count: 0, total_asset_count: 42, overall_risk_score: 3.687419753008327>
```


### Assets
```ruby
# Retrieve a list of all the assets that Controls has access to
Controls.assets
# => [
#      #<Controls::Asset: discovered_at: 2013-12-15 09:55:47 -0600, operating_system: Windows 7 Professional Edition,
#      operating_system_certainty: 1.0, security_control_findings: [...], risk_level: MEDIUM, risk_score:
#      5.554266115196547, owner: Administrator, name: 10.4.19.25, host_name: CMMNCTR2K7R2-U, ipaddress: 10.4.19.25,
#      uuid: db899a57-347c-4df9-9ce2-6932dc4adf38>,
#      ...
#    ]

# Only retrieve a single assessment
Controls.assets('335fb288-da73-4d3c-afe9-b6a1506bf907')
# => #<Controls::Asset: discovered_at: 2013-12-15 09:55:48 -0600, operating_system: Windows 7 Enterprise Edition, 
#    operating_system_certainty: 1.0, security_control_findings: [...], risk_level: MEDIUM, risk_score: 
#    4.724118340950002, owner: Administrator, name: 10.4.19.24, host_name: V-OFC-COMPAT-P, ipaddress: 10.4.19.24,
#    uuid: 335fb288-da73-4d3c-afe9-b6a1506bf907>
```

### Configuration
```ruby
Controls.configurations
# => [
#      #<Controls::Configuration: coverage: #<Controls::CoverageItem: total: 42, covered: 1, uncovered: 41, percent_covered: 2.380952380952381>, assessment_timestamp: 2014-02-06 17:58:06 -0600,
#      name: unique-password, title: unique password>
#      ...,
#      #<Controls::Configuration: coverage: #<Controls::CoverageItem: total: 3, covered: 3, uncovered: 0, percent_covered: 100.0>, assessment_timestamp: 2014-02-06 17:58:06 -0600,
#      name: email-attachment-filtering-enabled, title: E-mail client attachment filtering enabled>
#    ]

Controls.configurations('antivirus-installed')
# => #<Controls::Configuration: coverage: #<Dish::Plate:0x007fb052ce9e10>, assessment_timestamp: 2014-02-06 17:58:06 -0600,
#    name: antivirus-installed, title: antivirus installed>
```

### Guidance
```ruby
# Retreive a list of guidance applicable to a specific threat
Controls.guidance_by_threat('overall-malware')
# => [...]

# Only retrieve a single guidance by name
Controls.guidance('your-guidance-name-here')
# => #<Dish::Plate: assessment_timestamp: 1391731086251, sans_reference: , dsd_reference: , nist_reference: , 
#    sections: [...], domain: Desktop, references: [...], target_grade: 3.2759693577089286, improvement_delta: 
#    0.007545795822296775, improvement_grade: 3.2759693577089286, name: enable-uac, title: Enable User Account Control (UAC)>

Controls.prioritized_guidance_by_security_control('desktops-with-antivirus-deployed').count
# => 3
```

### Security Controls
```ruby
Controls.security_controls
# => [
#      #<Controls::SecurityControl: enabled: true, name: desktops-with-up-to-date-high-risk-applications>,
#      ...,
#      #<Controls::SecurityControl: enabled: true, name: desktops-with-email-attachment-filtering-enabled>
#    ]

Controls.security_controls('code-execution-prevention')
# => #<Controls::SecurityControl: enabled: true, name: code-execution-prevention>
```

### Security Control Coverage
```ruby
Controls.security_control_coverage
# => [
#      #<Controls::SecurityControlCoverage: enabled: true, coverage: #<Controls::CoverageItem: total: 20, covered: 6,
#      uncovered: 14, percent_covered: 30.0>,
#      assessment_timestamp: 2014-02-06 17:58:06 -0600, name: desktops-with-up-to-date-high-risk-applications,
#      title: high-risk applications up to date>,
#      ...,
#      #<Controls::SecurityControlCoverage: enabled: true, coverage: #<Controls::CoverageItem: total: 3, covered: 3,
#      uncovered: 0, percent_covered: 100.0>,
#      assessment_timestamp: 2014-02-06 17:58:06 -0600, name: desktops-with-email-attachment-filtering-enabled,
#      title: e-mail client attachment filtering enabled>
#    ]

Controls.security_controls('code-execution-prevention')
# => #<Controls::SecurityControlCoverage: enabled: true, coverage: #<Controls::CoverageItem: total: 42, covered: 0, uncovered: 42, percent_covered: 0.0>,
#    assessment_timestamp: 2014-02-06 17:58:06 -0600, name: code-execution-prevention, title: code execution prevention deployed>
```

### Threats
```ruby
# Retrieve a list of all the threats
Controls.threats
# => [#<Controls::Threat: grade: 3, assessment_timestamp: 2014-02-06 17:58:06 -0600, grade_level: POOR, name: overall-malware, title: Overall>]

# Only retrieve a single threat
Controls.threats('overall-malware')
# => #<Controls::Threat: grade: 3, assessment_timestamp: 2014-02-06 17:58:06 -0600, grade_level: POOR, name: overall-malware, title: Overall>
```

### Threat Vectors
```ruby
# Retrieve a list of all the threat vectors
Controls.threat_vectors
# => [#<Controls::ThreatVector: grade: 3, assessment_timestamp: 2014-02-06 17:58:06 -0600, grade_level: POOR, name:
network-borne, title: Network>, ..., #<Controls::ThreatVector: grade: 3, assessment_timestamp: 2014-02-06 17:58:06 -0600, grade_level: POOR, name: email-borne, title: E-mail>]

# Only retrieve a single threat vector
Controls.threat_vectors('network-borne')
# => #<Controls::ThreatVector: grade: 3, assessment_timestamp: 2014-02-06 17:58:06 -0600, grade_level: POOR, name: network-borne, title: Network>
```

### Trends
```ruby
# Retrieve a list of trend points over time
Controls.threat_trends('overall-malware')
# => [#<Controls::Trend: grade: 1.1723226070935302, assessment_timestamp: 2013-12-15 10:07:39 -0600, total_assets: 18>,
#     #<Controls::Trend: grade: 3.2684235618866317, assessment_timestamp: 2014-02-06 17:58:06 -0600, total_assets: 42>]

Controls.threat_vector_trends('network-borne')
# => [#<Controls::Trend: grade: 1.0187000110028335, assessment_timestamp: 2013-12-15 10:07:39 -0600, total_assets: 18>,
#     #<Controls::Trend: grade: 3.497538201261831, assessment_timestamp: 2014-02-06 17:58:06 -0600, total_assets: 42>]

Controls.configuration_trends('antivirus-installed')
# => [#<Controls::Trend: assessment_timestamp: 2013-12-15 10:07:39 -0600, total_assets: 18, covered_assets: 0,
#     covered_percentage: 0.0>, #<Controls::Trend: assessment_timestamp: 2014-02-06 17:58:06 -0600, total_assets: 42,
#     covered_assets: 9, covered_percentage: 21.428571428571427>]
```

## License
This project was created by [Erran Carey (@erran)](http://erran.github.io) and licensed under [the MIT License](LICENSE.md).
