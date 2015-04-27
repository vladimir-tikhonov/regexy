# encoding: UTF-8

describe Regexy::Text::Emoji do
  let(:r) { Regexy::Text::Emoji.new }

  it 'accepts valid emoji characters' do
    128512.upto(128767).each do |p| # rubynius doesn't want to iterate through unicode chars
      expect([p].pack('U*') =~ r).to be_truthy
    end
  end
end
