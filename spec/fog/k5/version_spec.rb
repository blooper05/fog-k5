RSpec.describe Fog::K5 do
  describe 'VERSION' do
    subject { described_class::VERSION }
    it { is_expected.not_to be_nil }
  end
end