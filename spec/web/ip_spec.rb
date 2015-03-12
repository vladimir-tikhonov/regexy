describe Regexy::Web::IPv4 do
  VALID_ADDRESSES = [
    '0.0.0.0',
    '255.255.255.255',
    '127.0.0.1'
  ]

  INVALID_ADDRESSES = [
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

  VALID_ADDRESSES_WITH_PORT = [
    '127.0.0.1:80',
    '127.0.0.1:65535',
    '127.0.0.1:0'
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
      VALID_ADDRESSES_WITH_PORT.each do |ip_address|
        expect(ip_address =~ r).to be_truthy
      end
    end

    it 'does not matches invalid addresses with port' do
      INVALID_ADDRESSES_WITH_PORT.each do |ip_address|
        expect(ip_address =~ r).to be_nil
      end
    end
  end
end