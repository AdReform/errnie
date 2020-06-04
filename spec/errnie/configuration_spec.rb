require 'spec_helper'

RSpec.describe Errnie::Configuration do
  describe '#default_service' do
    subject { configuration.default_service }

    context 'when not specified' do
      let(:configuration) { described_class.new }

      it { is_expected.to eq 'Bugsnag' }
    end

    context 'when customized' do
      let(:configuration) {
        Errnie.configure { |c| c.default_service = 'Appsignal' }
      }

      it { is_expected.to eq 'Appsignal' }
    end
  end
end

