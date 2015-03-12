# Regexy
[![Gem Version](https://badge.fury.io/rb/regexy.svg)](http://badge.fury.io/rb/regexy)
[![Build Status](https://travis-ci.org/vladimir-tikhonov/regexy.svg?branch=master)](https://travis-ci.org/vladimir-tikhonov/regexy)
[![Dependency Status](https://gemnasium.com/vladimir-tikhonov/regexy.svg)](https://gemnasium.com/vladimir-tikhonov/regexy)
[![Code Climate](https://codeclimate.com/github/vladimir-tikhonov/regexy/badges/gpa.svg)](https://codeclimate.com/github/vladimir-tikhonov/regexy)
[![Coverage Status](https://coveralls.io/repos/vladimir-tikhonov/regexy/badge.svg)](https://coveralls.io/r/vladimir-tikhonov/regexy)

Regexy is the ruby gem that contains a lot of common-use regular expressions and provides a friendly syntax to combine them.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regexy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install regexy

## Usage

### Regexy::Regexp

Wrapper around original [Regexp](http://ruby-doc.org/core-2.2.1/Regexp.html) class. You can safely use it instead of original one.

```ruby
r1 = Regexy::Regexp.new('foo') # could be initialized from string
r2 = Regexy::Regexp.new(/foo/) # from regexp
r3 = Regexy::Regexp.new(r2)    # or even from another Regexy::Regexp
r4 = Regexy::Regexp.new('foo', Regexp::IGNORECASE) # pass additional configuration
'abcfoocde' =~ r1    # => 3
r2.match 'abcfoocde' # => #<MatchData "foo">
```
### Regexy::Web::Email

Generates regular expressions for email addresses validation. Available options: `:relaxed` for general sanity check, `:normal` (which is default) with some additional length and ip addresses validations and `:strict` for the paranoids.

```ruby
r1 = Regexy::Web::Email.new(:relaxed)
r2 = Regexy::Web::Email.new(:normal)  # does not allow 'f@s.c' and 'invalid-ip@127.0.0.1.26'
r2 = Regexy::Web::Email.new(:strict)  # does not allow 'hans,peter@example.com' and "partially.\"quoted\"@sld.com"
```

## Contributing

1. Fork it ( https://github.com/vladimir-tikhonov/regexy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
