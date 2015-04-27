describe Regexy::Text::Smile do
  VALID_SMILES = [
    ':)', ':=)', ':-)', ':(',
    ':=(', ':-(', ':D', ':=D',
    ':-D', ':d', ':=d', ':-d',
    '8=)', '8-)', 'B=)', 'B-)',
    ';)', ';-)', ';=)', ':o',
    ':=o', ':-o', ':O', ':=O',
    ':-O', ';(', ';-(', ';=(',
    ':*', ':=*', ':-*', ':P',
    ':=P', ':-P', ':p', ':=p',
    ':-p', ':S', ':-S', ':=S',
    ':s', ':-s', ':=s', ':x',
    ':-X', ':#', ':-#', ':=x',
    ':=X', ':=#', 'xd', ':\\', ':D', ':/'
  ]

  INVALID_SMILES = [
    '://', '::)'
  ]

  let(:r) { Regexy::Text::Smile.new }

  it 'accept valid smiles' do
    VALID_SMILES.each do |smile|
      expect(smile =~ r).to be_truthy
    end
  end

  it 'does not accept invalid smiles' do
    INVALID_SMILES.each do |smile|
      expect(smile =~ r).to be_nil
    end
  end
end
