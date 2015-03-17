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

  it 'saves original options unless custom options provided' do
    r = Regexy::Regexp.new(/\s/i)
    expect(r).to eq /\s/i
  end

  it 'mimics original regexp behaviour' do
    #Fix for rubinius
    expected_methods = ::Regexp.public_instance_methods(false) - [:initialize, :initialize_copy]
    expect(Regexy::Regexp.public_instance_methods(false)).to include(*expected_methods)
  end

  context '| method' do
    it 'allows to combine regexes' do
      r1 = Regexy::Regexp.new(/foo/)
      r2 = Regexy::Regexp.new(/bar/)
      expect(r1 | r2).to eq /foo|bar/
    end

    it 'saves options if presented' do
      r1 = Regexy::Regexp.new(/foo/i)
      r2 = Regexy::Regexp.new(/bar/)
      expect(r1 | r2).to eq /foo|bar/i
      expect(r2 | r1).to eq /bar|foo/i
    end

    it 'merges option of two regexes' do
      r1 = Regexy::Regexp.new(/foo/i)
      r2 = Regexy::Regexp.new(/bar/x)
      expect(r1 | r2).to eq /foo|bar/ix
    end
  end

  context '+ method' do
    it 'allows to combine regexes' do
      r1 = Regexy::Regexp.new(/foo/)
      r2 = Regexy::Regexp.new(/bar/)
      expect(r1 + r2).to eq /foobar/
    end

    it 'saves options if presented' do
      r1 = Regexy::Regexp.new(/foo/i)
      r2 = Regexy::Regexp.new(/bar/)
      expect(r1 + r2).to eq /foobar/i
      expect(r2 + r1).to eq /barfoo/i
    end

    it 'merges option of two regexes' do
      r1 = Regexy::Regexp.new(/foo/i)
      r2 = Regexy::Regexp.new(/bar/x)
      expect(r1 + r2).to eq /foobar/ix
    end

    it 'removes leading \A from second regex' do
      r1 = Regexy::Regexp.new(/foo/)
      r2 = Regexy::Regexp.new(/\Abar/)
      expect(r1 + r2).to eq /foobar/
    end

    it 'removes trailing /z from first regex' do
      r1 = Regexy::Regexp.new(/foo\z/)
      r2 = Regexy::Regexp.new(/bar/)
      expect(r1 + r2).to eq /foobar/
    end

    it 'normalize both expressions' do
      r1 = Regexy::Regexp.new(/\Afoo\z/)
      r2 = Regexy::Regexp.new(/\Abar\z/)
      expect(r1 + r2).to eq /\Afoobar\z/
    end

    it 'leaves \A and \z if no other characters presented' do
      r1 = Regexy::Regexp.new(/\A/)
      r2 = Regexy::Regexp.new(/\z/)
      expect(r1 + r2).to eq /\A\z/
    end
  end

  context '#bound' do
    class BoundCallbackCheck < Regexy::Regexp
      protected

      def additional_bound(method, regex)
        "#{method.to_s}&#{regex}"
      end
    end

    it 'prepends \A to regexp when method is :left' do
      expect(Regexy::Regexp.new(/foo/).bound(:left)).to eq /\Afoo/
    end

    it 'appends \z when method is :right' do
      expect(Regexy::Regexp.new(/foo/).bound(:right)).to eq /foo\z/
    end

    it 'prepends \A and appends \z when method is :both' do
      expect(Regexy::Regexp.new(/foo/).bound(:both)).to eq /\Afoo\z/
    end

    it 'preserves regexp options' do
      expect(Regexy::Regexp.new(/foo/i).bound).to eq /\Afoo\z/i
    end

    it 'calls #additional_bound callback' do
      expect(BoundCallbackCheck.new(/foo/).bound).to eq /both&\Afoo\z/
    end
  end

  context '#unbound' do
    class UnboundCallbackCheck < Regexy::Regexp
      protected

      def additional_unbound(method, regex)
        "#{method.to_s}&#{regex}"
      end
    end

    it 'removes leading \A when method is :left' do
      expect(Regexy::Regexp.new(/\Afoo/).unbound(:left)).to eq /foo/
    end

    it 'removes trailing \z when method is :right' do
      expect(Regexy::Regexp.new(/foo\z/).unbound(:right)).to eq /foo/
    end

    it 'removes \A and \z when method is :both' do
      expect(Regexy::Regexp.new(/\Afoo\z/).unbound(:both)).to eq /foo/
    end

    it 'preserves regexp options' do
      expect(Regexy::Regexp.new(/\Afoo\z/i).unbound).to eq /foo/i
    end

    it 'calls #additional_unbound callback' do
      expect(UnboundCallbackCheck.new(/\Afoo\z/).unbound).to eq /both&foo/
    end
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