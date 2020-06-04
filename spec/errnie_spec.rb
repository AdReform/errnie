require 'errnie/services/bugsnag'
require 'errnie/services/appsignal'

RSpec.describe Errnie do
  describe '.notify' do
    let(:error) { StandardError.new('testing 123') }

    subject { described_class.notify(error, options) }

    context 'when no service is specified' do
      before { described_class.configure {|c| c.default_service = 'Bugsnag'} }

      let(:options)  { {} }

      it 'uses the default' do
        expect(Errnie::Services::Bugsnag).to receive(:new)
          .with(error, options).and_call_original

        subject
      end
    end

    context 'when service is specified' do
      let(:options)  {
        { service: 'Appsignal' }
      }

      it 'uses the service' do
        expect(Errnie::Services::Appsignal).to receive(:new)
          .with(error, options).and_call_original

        subject
      end
    end
  end

  describe '#notify' do
    let(:error)    { StandardError.new('testing 123') }
    let(:options)  { {} }
    let!(:errnie)  { described_class.new(service) }

    subject { errnie.notify(error, options) }

    [:Appsignal, :Bugsnag].each do |service_name|
      context "using #{service_name}" do
        let(:service) { service_name }
        let(:klass)   { Errnie::Services.const_get(service_name.to_s) }

        it "instantiates the service with the error and options" do
          expect(klass).to receive(:new).with(error, options).and_call_original
          subject
        end

        it "notifies via the service" do
          expect_any_instance_of(klass).to receive(:notify)
          subject
        end
      end
    end
  end
end
