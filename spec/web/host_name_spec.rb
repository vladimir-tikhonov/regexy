describe Regexy::Web::HostName do
  VALID_HOSTNAMES = [
    'foo.bar',
    'www.foo.bar',
    'кирриллический.домен.рф',
    'valid-with-hyphens.com',
    'valid-----hyphens.com',
    '_underscore_in_sub.example.com',
    'sub.foo.bar.com'
  ]

  INVALID_HOSTNAMES = [
    'foo',
    'foo.',
    '.foo',
    'invalid-.com',
    '-invalid.com',
    'inv-.alid-.com',
    'foo. bar',
    'foo.longstring'
  ]

  let(:r) { Regexy::Web::HostName.new }

  it 'allows valid hostnames' do
    VALID_HOSTNAMES.each do |hostname|
      expect(hostname =~ r).to be_truthy
    end
  end

  it 'does not allow valid hostnames' do
    INVALID_HOSTNAMES.each do |hostname|
      expect(hostname =~ r).to be_nil
    end
  end
end