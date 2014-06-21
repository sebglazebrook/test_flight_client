require 'spec_helper'

describe TestFlightClient::ApiRequest do

  describe '#post' do

    %w(api_token team_token notes
    distribution_lists notify replace).each do |api_param|

      context "when given a '#{api_param}' parameter" do

        let(:params) do
          {api_param => 'some param value' }
        end

        it 'gets posted with the request' do
          expect(subject.class).to receive(:post).with(anything, query: params)
          subject.post('some path',params)
        end
      end
    end

    context 'when given file based parameters' do


      let(:file) { double('file') }
      let(:dsym) { double('dsym') }
      let(:params) do
        { file: file, dsym: dsym }
      end

      context 'that\'s values are not files' do

        before do
          file.stub(:class).and_return String
          dsym.stub(:class).and_return String
          subject.class.stub(:post)
        end

        it 'attempts to resolve and read a file' do
          expect(File).to receive(:new).with(file, 'r')
          expect(File).to receive(:new).with(dsym, 'r')
          subject.post('path', params)
        end

        context 'when a file can be resolved' do

          let(:file_double) { double('file double') }
          let(:dsym_double) { double('dsym double') }

          before do
            File.stub(:new).with(file, 'r').and_return file_double
            File.stub(:new).with(dsym, 'r').and_return dsym_double
          end

          it 'passes through the file to the request' do
            expect(subject.class).to receive(:post).with(anything, {query: {file: file_double, dsym: dsym_double}})
            subject.post('path', params)
          end
        end

        context 'when a file can not be resolved' do

          before do
            File.stub(:new).with(file, 'r').and_raise Exception
            File.stub(:new).with(dsym, 'r').and_raise Exception
          end

          it 'returns an error' do
            expect{subject.post('path', params)}.to raise_error TestFlightClient::ApiRequest::IrresolvableFileParameter
          end
        end
      end

      context 'that\'s values are files' do

        before do
          file.stub(:class).and_return File
          dsym.stub(:class).and_return File
        end

        it 'passes through the parameters untouched' do
          expect(subject.class).to receive(:post).with(anything, query: params)
          subject.post('path', params)
        end
      end
    end
  end
end