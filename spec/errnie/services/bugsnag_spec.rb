require 'spec_helper'
require 'errnie/services/bugsnag'

RSpec.describe Errnie::Services::Bugsnag do
  describe '#notify' do
    let(:error)    { StandardError.new('testing 123') }
    let(:options)  { {} }
    let!(:service) { described_class.new(error, options) }

    subject { service.notify }

    it 'notifies via Bugsnag' do
      expect(::Bugsnag).to receive(:notify).with(error, nil)
      subject
    end
  end

  describe '#error' do
    let!(:service) { described_class.new(error) }

    subject { service.error }

    [Exception, StandardError, NameError].each do |error_klass|
      context 'when argument is an exception' do
        let(:error) { error_klass.new('hi') }

        it { is_expected.to eq error }
      end
    end

    [123, nil, 'hi'].each do |non_error|
      context 'when argument is not an exception' do
        let(:error) { non_error }

        # the Bugsnag gem converts to RuntimeError internally
        # so our adapter can just return the argument as-is
        it { is_expected.to eq error }
      end
    end
  end
end

