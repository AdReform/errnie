require 'spec_helper'
require 'errnie/services/appsignal'

RSpec.describe Errnie::Services::Appsignal do
  describe '#notify' do
    let(:error)    { StandardError.new('testing 123') }
    let(:metadata) { { key: :value } }
    let!(:service) { described_class.new(error, metadata: metadata) }

    subject { service.notify }

    it 'notifies via Appsignal' do
      expect(::Appsignal).to receive(:send_error).with(error, metadata)
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

        it { is_expected.to be_a(RuntimeError) }
      end
    end
  end
end

