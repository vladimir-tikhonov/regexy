# Regexy
[![Gem Version](https://badge.fury.io/rb/regexy.svg)](http://badge.fury.io/rb/regexy)
[![Build Status](https://travis-ci.org/vladimir-tikhonov/regexy.svg?branch=master)](https://travis-ci.org/vladimir-tikhonov/regexy)
[![Dependency Status](https://gemnasium.com/vladimir-tikhonov/regexy.svg)](https://gemnasium.com/vladimir-tikhonov/regexy)
[![Code Climate](https://codeclimate.com/github/vladimir-tikhonov/regexy/badges/gpa.svg)](https://codeclimate.com/github/vladimir-tikhonov/regexy)
[![Coverage Status](https://coveralls.io/repos/vladimir-tikhonov/regexy/badge.svg)](https://coveralls.io/r/vladimir-tikhonov/regexy)

Regexy is the ruby gem that contains a lot of common-use regular expressions (such as email or ip addresses validations) and provides a friendly syntax to combine them.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

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
### Combining regular expressions

You can combine your regular expressions with `|` operator using `|` method (or `or`, which is alias for it). Note, that regexp options will be combined too.
```ruby
Regexy::Regexp.new('foo') | Regexy::Regexp.new(/bar/) # => /foo|bar/
Regexy::Regexp.new(/foo/i) | /bar/x # => /foo|bar/ix
Regexy::Regexp.new(/foo/i).or 'bar' # => /foo|bar/i
any_ipv4 = Regexy::Web::IPv4.new(:normal) | Regexy::Web::IPv4.new(:with_port) # matches ip w\ and w\o port
```

### Regexy::Web::Email

Generates regular expressions for email addresses validation (with unicode support). Available options: `:relaxed` for general sanity check, `:normal` (which is default) with some additional length and ip addresses validations and `:strict` for the paranoids.

```ruby
r1 = Regexy::Web::Email.new(:relaxed)
r2 = Regexy::Web::Email.new(:normal)  # does not match 'f@s.c' and 'invalid-ip@127.0.0.1.26'
r2 = Regexy::Web::Email.new(:strict)  # does not match 'hans,peter@example.com' and "partially.\"quoted\"@sld.com"
```
### Regexy::Web::IPv4

Generates regular expressions for matching IPv4 addresses. Available options: `:normal` (by default) for matching ip without port and `:with_port` for guess what.

```ruby
r1 = Regexy::Web::IPv4.new             # matches '127.0.0.1' but not '127.0.0.1:80'
r1 = Regexy::Web::IPv4.new(:with_port) # matches '127.0.0.1:80' but not '127.0.0.1'
any_ipv4 = Regexy::Web::IPv4.new(:normal) | Regexy::Web::IPv4.new(:with_port) # matches ip w\ and w\o port
```
### Regexy::Web::IPv6

Generates regular expressions for matching IPv6 addresses (standard, mixed, and compressed notation are supported). Works in `:normal` (by default) and `:with_port` modes.

```ruby
r1 = Regexy::Web::IPv6.new             # matches '::1', '2001:DB8::8:800:200C:417A' and '::FFFF:129.144.52.38'
r1 = Regexy::Web::IPv6.new(:with_port) # matches '[::1]:80' and so on
any_ipv6 = Regexy::Web::IPv6.new(:normal) | Regexy::Web::IPv6.new(:with_port) # matches ip w\ and w\o port
```

## Contributing
Have an idea of new regular expression? Create an [issue](https://github.com/vladimir-tikhonov/regexy/issues) (some test cases will be much appreciated) or open a [pull request](https://github.com/vladimir-tikhonov/regexy/pulls).
