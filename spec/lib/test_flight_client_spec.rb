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

      let(:params) { double('params') }

      it 'posts an API request passing through given parameters' do
        expect(api_request).to receive(:post).with anything, params
        subject.build params
      end
    end
  end
end