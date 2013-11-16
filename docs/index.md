ControlsInsight API v1.0 (beta)
---

## Overview
Rapid7's **controlsinsight**, hereafter **controls**insight or simply **controls**,

The **controls**insight API v1.0 allow developers to utilize information about security controls, configurations, threats, and more from **controls**. 

This documentation includes custom Curl examples and Ruby examples using the Ruby API client (ipwnstuff/controls.rb).

Apiary.io also adds example requests in other languages, though they aren't supported tested them.

To see advanced usage in Ruby read the [Ruby client documentation here](http://www.rubydoc.info/github/ipwnstuff/controls.rb).

## Authentication
You must authenticate using HTTP Basic Auth when making any of the API requests.

## Curl
See the cURL man pages on how to authenticate.

```bash
# Use -k to allow a self-signed certificate
curl --user admin:password https://nexpose.local:3780/insight/controls/api/1.0
```

## Ruby
```ruby
# Allow connections to Nexpose's self-signed cert
Controls.middleware.ssl[:verify] = false

Controls.login 'admin', 'password'

# Return the API reference for the current API version
Controls.get '/'
```

## Authentication via a `.netrc` file
### Curl
```bash
# Use -k to allow a self-signed certificate
curl -H 'Accept: application/json' --netrc-file ~/.rapid7_netrc  -ik https://nexpose.local:3780/insight/controls/api/1.0
```

### Ruby
**NOTE**: The **controls** Ruby client doesn't enable or install netrc support by default. Install/enable netrc support as follows:

```bash
gem install netrc
irb -r controls
```

```ruby
# Allow connections to Nexpose's self-signed cert
Controls.middleware.ssl[:verify] = false

client = Controls::Client.new({
    :api_endpoint => 'https://nexpose.local:3780/insight/controls/api/1.0',
    :web_endpoint => 'https://nexpose.local:3780/insight/controls',
    :netrc => true,
    :netrc_file => '~/.rapid7_netrc'
})
```

# Status & Error Codes
## Success
<table>
<tr><th>Status Code</th><th>Status</th><th>Description</th></tr>
<tr><td>200</td><td>OK</td><td>The request was successful (includes a hash/array for the requested resource)</td></tr>
</table>

## Failure
<table>
<tr><th>Status Code</th><th>Status</th><th>Description</th></tr>
<tr><td>401</td><td>Unauthorized</td><td>The request didn't contain any information for authentication</td></tr>
<tr><td>403</td><td>Bad Request</td><td>The query parameters you supplied were invalid</td></tr>
<tr><td>404</td><td>Not Found</td><td>The resource(s) you requested couldn't be found (returns an error message)</td></tr>
</table>

## Example Error JSON
```json
{
    "status": 404,
    "messsage": "The resource x could not be found."
}
```
