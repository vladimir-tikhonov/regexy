# encoding: UTF-8

describe Regexy::Web::Email do
  VALID_EMAILS = [
    'a+b@plus-in-local.com',
    'a_b@underscore-in-local.com',
    'user@example.com',
    ' user@example.com ',
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@letters-in-local.org',
    '01234567890@numbers-in-local.net',
    'a@single-character-in-local.org',
    'one-character-third-level@a.example.com',
    'single-character-in-sld@x.org',
    'local@dash-in-sld.com',
    'letters-in-sld@123.com',
    'one-letter-sld@x.org',
    'uncommon-tld@sld.museum',
    'uncommon-tld@sld.travel',
    'uncommon-tld@sld.mobi',
    'country-code-tld@sld.uk',
    'country-code-tld@sld.rw',
    'local@sld.newTLD',
    'local@sub.domains.com',
    'aaa@bbb.co.jp',
    'nigel.worthington@big.co.uk',
    'f@c.com',
    'areallylongnameaasdfasdfasdfasdf@asdfasdfasdfasdfasdf.ab.cd.ef.gh.co.ca',
    'киррилический@емэил.рф'
  ]

  INVALID_EMAILS = [
    'user@@domain.com',
    'user.domain.com',
    'f@s',
    'test@',
    '@bar.com',
    'test@example.com@example.com',
    '@missing-local.org',
    'a b@space-in-local.com',
    "! \#$%\`|@invalid-characters-in-local.org",
    "<>@[]\`|@even-more-invalid-characters-in-local.org",
    "invalid-characters-in-sld@! \"\#$%(),/;<>_[]\`|.org",
    'missing-sld@.com',
    'missing-tld@sld.',
    'missing-dot-before-tld@com',
    "user@example.com\n<script>alert('hello')</script>",
    '',
    ' '
  ]

  INVALID_EMAILS_IN_NORMAL_MODE = [
    'f@s.c',
    'unbracketed-IP@127.0.0.1',
    'invalid-ip@127.0.0.1.26',
    'another-invalid-ip@127.0.0.256',
    'IP-and-port@127.0.0.1:25',
    'the-local-part-is-invalid-if-it-is-longer-than-sixty-four-characters@sld.net'
  ]

  INVALID_EMAILS_IN_STRICT_MODE = [
    'hans,peter@example.com',
    'hans(peter@example.com',
    'hans)peter@example.com',
    "partially.\"quoted\"@sld.com",
    "&'*+-./=?^_{}~@other-valid-characters-in-local.net",
    'mixed-1234-in-{+^}-local@sld.net'
  ]

  it 'fails when wrong mode is provided' do
    expect { Regexy::Web::Email.new(:invalid) }.to raise_error(ArgumentError)
  end

  context 'relaxed mode' do
    let(:r) { Regexy::Web::Email.new(:relaxed) }

    it 'accept valid emails' do
      VALID_EMAILS.each do |email|
        expect(email =~ r).to be_truthy
      end
    end

    it 'should decline invalid emails' do
      INVALID_EMAILS.each do |email|
        expect(email =~ r).to be_nil
      end
    end

    it 'should accept emails that valid in relaxed mode but not in normal' do
      INVALID_EMAILS_IN_NORMAL_MODE.each do |email|
        expect(email =~ r).to be_truthy
      end
    end

    it 'should accept emails that valid in normal mode but not in strict' do
      INVALID_EMAILS_IN_STRICT_MODE.each do |email|
        expect(email =~ r).to be_truthy
      end
    end
  end

  context 'normal mode' do
    let(:r) { Regexy::Web::Email.new(:normal) }

    it 'accept valid emails' do
      VALID_EMAILS.each do |email|
        expect(email =~ r).to be_truthy
      end
    end

    it 'should decline invalid emails' do
      INVALID_EMAILS.each do |email|
        expect(email =~ r).to be_nil
      end
    end

    it 'should decline emails that valid in relaxed mode but not in normal' do
      INVALID_EMAILS_IN_NORMAL_MODE.each do |email|
        expect(email =~ r).to be_nil
      end
    end

    it 'should accept emails that valid in normal mode but not in strict' do
      INVALID_EMAILS_IN_STRICT_MODE.each do |email|
        expect(email =~ r).to be_truthy
      end
    end
  end

  context 'strict mode' do
    let(:r) { Regexy::Web::Email.new(:strict) }

    it 'accept valid emails' do
      VALID_EMAILS.each do |email|
        expect(email =~ r).to be_truthy
      end
    end

    it 'should decline invalid emails' do
      INVALID_EMAILS.each do |email|
        expect(email =~ r).to be_nil
      end
    end

    it 'should decline emails that valid in relaxed mode but not in normal' do
      INVALID_EMAILS_IN_NORMAL_MODE.each do |email|
        expect(email =~ r).to be_nil
      end
    end

    it 'should decline emails that valid in normal mode but not in strict' do
      INVALID_EMAILS_IN_STRICT_MODE.each do |email|
        expect(email =~ r).to be_nil
      end
    end
  end
end