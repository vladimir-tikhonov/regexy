# encoding: UTF-8

# https://gist.github.com/janogarcia/3946583
# A hashtag can contain any UTF-8 alphanumeric character, plus the underscore symbol. That's expressed with the character class [0-9_\p{L}]*, based on http://stackoverflow.com/a/5767106/1441613
# A hashtag can't be only numeric, it must have at least one alpahanumeric character or the underscore symbol. That condition is checked by ([0-9_\p{L}]*[_\p{L}][0-9_\p{L}]*), similar to http://stackoverflow.com/a/1051998/1441613
# Finally, the modifier 'u' is added to ensure that the strings are treated as UTF-8.

describe Regexy::Web::Hashtag do
  NUMBERS       = [*(0..9), *('0'..'9')]
  VALID_CHARS   = [*('A'..'Z'), *('À'..'Ÿ'), *('a'..'z'), *('à'..'ÿ'), '_'] + NUMBERS
  INVALID_CHARS = [*('!'..'~')] - VALID_CHARS

  let(:r) { Regexy::Web::Hashtag.new }

  context 'matches hashtags' do
    it 'with only valid characters' do
      hashtag = VALID_CHARS.sample(8).shuffle.join
      expect("##{hashtag}" =~ r).to be_truthy
    end
  end

  context 'does not matches hashtags' do
    it 'with only numbers' do
      hashtag = NUMBERS.sample(8).shuffle.join
      expect("##{hashtag}" =~ r).to be_nil
    end

    it 'with special characters' do
      hashtag = (VALID_CHARS.sample(8) + INVALID_CHARS.sample(1)).shuffle.join
      expect("##{hashtag}" =~ r).to be_nil
    end

    it 'with spaces' do
      hashtag = (VALID_CHARS.sample(8) + [' ']).shuffle.join
      expect("##{hashtag}" =~ r).to be_nil
    end
  end
end