# encoding: UTF-8

describe Regexy::Text::Emoji do
  let(:r) { Regexy::Text::Emoji.new }

  it 'accepts valid emoji characters' do
    ("\u{1F600}".."\u{1F6FF}").each do |ch|
      expect(ch =~ r).to be_truthy
    end
  end
end