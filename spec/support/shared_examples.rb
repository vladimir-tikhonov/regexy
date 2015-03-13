RSpec.shared_examples 'regexp_with_mode' do
  it 'fails when wrong mode is provided' do
    expect { described_class.new(:invalid) }.to raise_error(ArgumentError)
  end
end
