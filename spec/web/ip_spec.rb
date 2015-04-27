describe Regexy::Web::IPv4 do
  it_should_behave_like 'regexp_with_mode'

  VALID_ADDRESSES = [
    '0.0.0.0',
    '255.255.255.255',
    '127.0.0.1'
  ]

  INVALID_ADDRESSES = [
    '',
    ' ',
    'a.b.c.d',
    '256.0.0.1',
    '127,0.0',
    '127.0.0.',
    '.127.0.0',
    '127.0.0.1.',
    '127.0.0.0.1'
  ]

  INVALID_ADDRESSES_WITH_PORT = [
    '127.0.0.1:',
    '127.0.0.1:65536',
    '127.0.0.1:75535'
  ]

  context 'normal mode' do
    let(:r) { Regexy::Web::IPv4.new(:normal) }

    it 'matches valid addresses' do
      VALID_ADDRESSES.each do |ip_address|
        expect(ip_address =~ r).to be_truthy
      end
    end

    it 'does not matches invalid addresses' do
      INVALID_ADDRESSES.each do |ip_address|
        expect(ip_address =~ r).to be_nil
      end
    end
  end

  context 'with_port mode' do
    let(:r) { Regexy::Web::IPv4.new(:with_port) }

    it 'matches valid addresses with port' do
      VALID_ADDRESSES.each do |ip_address|
        expect(ip_address + ':80' =~ r).to be_truthy
      end
    end

    it 'does not matches invalid addresses with port' do
      INVALID_ADDRESSES_WITH_PORT.each do |ip_address|
        expect(ip_address =~ r).to be_nil
      end
    end
  end
end

describe Regexy::Web::IPv6 do
  it_should_behave_like 'regexp_with_mode'

  VALID_ADDRESSES_6 = [
    '::1',
    '::',
    '0:0:0:0:0:0:0:1',
    'FF01:0:0:0:0:0:0:101',
    '2001:DB8::8:800:200C:417A',
    'FF01::101',
    'fe80::217:f2ff:fe07:ed62',
    '0:0:0:0:0:0:0::',
    '0:a:b:c:d:e:f::',
    '1:2:3:4:5:6:1.2.3.4',
    '::FFFF:129.144.52.38',
    '::ffff:192.0.2.128',
    '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
    '::8888',
    '::0:0:0:0:0',
    '0:0:0:0:0::',
    '0:a:b:c:d:e:f::'
  ]

  INVALID_ADDRESSES_6 = [
    '',
    ' ',
    '1111:2222:3333:4444:5555:6666:7777:8888:9999',
    '1111:2222:3333:4444:5555:6666:7777',
    '1111',
    '11112222:3333:4444:5555:6666:7777:8888',
    '1111:2222:3333:4444:5555:6666:7777:8888:',
    ':',
    '::2222::4444:5555:6666:7777:8888',
    '1111:2222:3333:4444:5555:6666:255255.255.255',
    '1111:::3333:4444:5555:6666:1.2.3.4',
    '::.',
    ':1111:2222:3333:4444:5555:6666:7777::'
  ]

  INVALID_ADDRESSES_WITH_PORT_6 = [
    '::1:80',
    '[::1]:',
    '[::1]:75535'
  ]

  context 'normal mode' do
    let(:r) { Regexy::Web::IPv6.new(:normal) }

    it 'matches valid addresses' do
      VALID_ADDRESSES_6.each do |ip_address|
        expect(ip_address =~ r).to be_truthy
      end
    end

    it 'does not matches invalid addresses' do
      INVALID_ADDRESSES_6.each do |ip_address|
        expect(ip_address =~ r).to be_nil
      end
    end
  end

  context 'with_port mode' do
    let(:r) { Regexy::Web::IPv6.new(:with_port) }

    it 'matches valid addresses with port' do
      VALID_ADDRESSES_6.each do |ip_address|
        expect("[#{ip_address}]:80" =~ r).to be_truthy
      end
    end

    it 'does not matches invalid addresses with port' do
      INVALID_ADDRESSES_WITH_PORT_6.each do |ip_address|
        expect(ip_address =~ r).to be_nil
      end
    end
  end
end
