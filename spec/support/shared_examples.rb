RSpec.shared_examples 'class_that_check_mode' do
  it 'fails when wrong mode is provided' do
    expect { described_class.new(:invalid) }.to raise_error(ArgumentError)
  end
end
