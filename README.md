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
    * [General usage](#regexyregexp)
    * [Getting the original regexp](#getting-the-original-regexp)
    * [Combining expressions](#combining-regular-expressions)
    * [Bound and unbound regex](#bound-and-unbound-regular-expressions)
    * [Email addresses](#regexywebemail)
    * [Hashtag](#regexywebhashtag)
    * [IP addresses](#regexywebipv4)
    * [Url](#regexyweburl)
    * [Hostname](#regexywebhostname)
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
### Getting the original regexp
For methods, that checks if it's arguments `is_a` Regexp instances (for example `String#scan`) you can use `internal_regexp` method.
```ruby
str = 'Email me at first@mail.com or second@mail.com'
str.scan(Regexy::Web::Email.new.unbound.internal_regexp).map(&:first) # => ["first@mail.com", "second@mail.com"]
```

### Combining regular expressions

You can combine your regular expressions with `|` operator using `|` method (or `or`, which is alias for it). Note, that regexp options will be combined too.
```ruby
Regexy::Regexp.new('foo') | Regexy::Regexp.new(/bar/) # => /foo|bar/
Regexy::Regexp.new(/foo/i) | /bar/x # => /foo|bar/ix
Regexy::Regexp.new(/foo/i).or 'bar' # => /foo|bar/i
any_ipv4 = Regexy::Web::IPv4.new(:normal) | Regexy::Web::IPv4.new(:with_port) # matches ip w\ and w\o port
```
Also you could simply join two expressions using `+` method, or it's alias `and_then`. Note, that it will __remove__ trailing `\z` from first regex and leading `\A` from second regex.
```ruby
Regexy::Regexp.new('foo') + Regexy::Regexp.new(/bar/) # => /foobar/
Regexy::Regexp.new(/foo\z/i) + /bar/ # => /foobar/i
Regexy::Regexp.new(/foo/).and_then '\Abar' # => /foobar/
Regexy::Regexp.new(/\Afoo\z/).and_then '\Abar\z' # => /\Afoobar\z/
```
### Bound and unbound regular expressions
All build-in regular expressions provided in a form of `\A...\z`, which means that they match entire string only. You can remove or add string boundaries using `bound` and `unbound` methods.
Optional argument `method` available (`:both` by default) - `:left` for manipulating only leading `\A` and `:right` for trailing `\z`.
```ruby
Regexy::Regexp.new('/Afoo/z').unbound(:left) # => /foo\z/
Regexy::Regexp.new(/foo/i).bound # => /\Afoo\z/i

# Example - find all ip addresses in the string
str = '0.0.0.0 and 255.255.255.255 are both valid ip addresses'
str.scan(Regexy::Web::IPv4.new.unbound.internal_regexp).flatten # => ["0.0.0.0", "255.255.255.255"]
```
### Regexy::Web::Email

Generates regular expressions for email addresses validation (with unicode support). Available options: `:relaxed` for general sanity check, `:normal` (which is default) with some additional length and ip addresses validations and `:strict` for the paranoids.

```ruby
r1 = Regexy::Web::Email.new(:relaxed)
r2 = Regexy::Web::Email.new(:normal)  # does not match 'f@s.c' and 'invalid-ip@127.0.0.1.26'
r2 = Regexy::Web::Email.new(:strict)  # does not match 'hans,peter@example.com' and "partially.\"quoted\"@sld.com"
```
### Regexy::Web::Hashtag

Generates regular expressions for matching Hashtags.
A hashtag can contain any UTF-8 alphanumeric character, plus the underscore symbol.
A hashtag can't be only numeric, it must have at least one alpahanumeric character or the underscore symbol.

```ruby
r1 = Regexy::Web::Hashtag.new # matches '#hash_tags'
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
### Regexy::Web::Url

Generates regular expressions for matching Url addresses (with unicode support).

```ruby
r1 = Regexy::Web::Url.new # matches 'http://foo.com', 'www.foo.com' and 'foo.com'
```

### Regexy::Web::HostName

Generates regular expressions for matching hostname (with unicode support).

```ruby
r1 = Regexy::Web::HostName.new # matches 'foo.com', 'www.foo.com' and 'киррилический.домен.рф'
```

## Contributing
Have an idea of new regular expression? Create an [issue](https://github.com/vladimir-tikhonov/regexy/issues) (some test cases will be much appreciated) or open a [pull request](https://github.com/vladimir-tikhonov/regexy/pulls).
