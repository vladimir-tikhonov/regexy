describe Regexy::Regexp do
  it 'allows to initialize from string' do
    r = Regexy::Regexp.new('\s')
    expect(r).to eq /\s/
  end

  it 'allows to initialize from ruby regexp' do
    r = Regexy::Regexp.new(/\s/)
    expect(r).to eq /\s/
  end

  it 'allows to initialize from another regexy instance' do
    r1 = Regexy::Regexp.new('\s')
    r2 = Regexy::Regexp.new(r1)
    expect(r2).to eq /\s/
  end

  it 'allows to pass regexp options' do
    r = Regexy::Regexp.new('\s', Regexp::IGNORECASE)
    expect(r).to eq /\s/i
  end

  it 'mimics original regexp behaviour' do
    expect(Regexy::Regexp.public_instance_methods(false)).to include(*::Regexp.public_instance_methods(false))
  end
end