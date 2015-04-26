# encoding: UTF-8

describe Regexy::Web::Url do
  VALID_URL = [
    'http://foo.com/blah_blah',
    'http://foo.com/blah_blah/',
    'http://foo.com/blah_blah_(wikipedia)',
    'http://foo.com/blah_blah_(wikipedia)_(again)',
    'http://www.example.com/wpstyle/?p=364',
    'https://www.example.com/foo/?bar=baz&inga=42&quux',
    'http://userid@example.com',
    'http://userid@example.com/',
    'http://userid@example.com:8080',
    'http://userid@example.com:8080/',
    'http://142.42.1.1/',
    'http://foo.com/blah_(wikipedia)#cite-1',
    'http://foo.com/blah_(wikipedia)_blah#cite-1',
    'http://foo.com/(something)?after=parens',
    'http://code.google.com/events/#&product=browser',
    'http://j.mp',
    'ftp://foo.bar/baz',
    'http://foo.bar/?q=Test%20URL-encoded%20stuff',
    'http://مثال.إختبار',
    'http://例子.测试',
    'http://1337.net',
    'http://a.b-c.de',
    'http://223.255.255.254',
    'http://киррилический/адрес.рф',
    'www.foo.bar',
    'foo.bar',
    'foo.bar#anchor'
  ]

  INVALID_URL = [
    'http://',
    'http://?',
    'http://??',
    'http://??/',
    'http://#',
    'http://##',
    'http://##/',
    'http://foo.bar?q=Spaces should be encoded',
    '//',
    '//a',
    '///a',
    '///',
    'http:///a',
    'http:// shouldfail.com',
    ':// should fail',
    'http://foo.bar/foo(bar)baz quux'
  ]

  let(:r) { Regexy::Web::Url.new }

  it 'accepts valid url' do
    VALID_URL.each do |url|
      expect(url =~ r).to be_truthy
    end
  end

  it 'declines invalid url' do
    INVALID_URL.each do |url|
      expect(url =~ r).to be_nil
    end
  end
end