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

  it 'overrides regexp options when pass custom options' do
    r = Regexy::Regexp.new(/\s/x, Regexp::IGNORECASE)
    expect(r).to eq /\s/i
  end

  it 'mimics original regexp behaviour' do
    #Fix for rubinius
    expected_methods = ::Regexp.public_instance_methods(false) - [:initialize, :initialize_copy]
    expect(Regexy::Regexp.public_instance_methods(false)).to include(*expected_methods)
  end
end

describe Regexy::RegexpWithMode do
  class InvalidRegex < ::Regexy::RegexpWithMode
  end

  class ValidRegex < ::Regexy::RegexpWithMode
    protected

    def regexp_for(mode)
      case mode
      when :mode_1 then /mode_1/
      when :mode_2 then /mode_2/
      else nil
      end
    end

    def default_mode
      :mode_1
    end
  end

  it 'fails if regexp_for is not overridden' do
    expect { InvalidRegex.new }.to raise_error NotImplementedError
  end

  it 'respects default mode' do
    expect(ValidRegex.new).to eq /mode_1/
  end

  it 'allows to set custom mode' do
    expect(ValidRegex.new(:mode_2)).to eq /mode_2/
  end

  it 'allows to pass additional config' do
    expect(ValidRegex.new(:mode_2, Regexp::IGNORECASE)).to eq /mode_2/i
  end

  it 'fails when wrong mode is provided' do
    expect { ValidRegex.new(:mode_3) }.to raise_error ArgumentError
  end
end