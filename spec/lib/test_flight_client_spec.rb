require 'spec_helper'

describe TestFlightClient do

  describe '#build' do

    let(:api_request) { double('api request') }

    before do
      TestFlightClient::ApiRequest.stub(:new).and_return api_request
    end

    it 'posts an API request to the "builds" path' do
      expect(api_request).to receive(:post).with '/builds', anything
      subject.build
    end

    context 'when given parameters' do

      let(:params) { {one: 'ONE', two: 'TWO'} }

      it 'posts an API request passing through given parameters' do
        expect(api_request).to receive(:post).with anything, params
        subject.build params
      end

      context 'when a config file is available' do

        let(:config_file) { double('config file') }
        let(:gemfile_path) { 'path/to/Gemfile' }
        let(:config_double) { double('config') }
        let(:erb_double) { double('erb', :result => config_file) }
        let(:config_file_params) { {one: '1', two: '2', three: '3'} }

        before do
          ENV.stub(:[]).with('BUNDLE_GEMFILE').and_return gemfile_path
          File.stub(:exists?).and_return true
          File.stub(:read).and_return config_double
          ERB.stub(:new).with(config_double).and_return erb_double
          YAML.stub(:load).with(config_file).and_return config_file_params
        end

        it 'merges in any parameters found in the config file that dont already exist' do
          expect(api_request).to receive(:post).with(anything, {one: 'ONE', two: 'TWO', three: '3'})
          subject.build params
        end
      end
    end
  end
end