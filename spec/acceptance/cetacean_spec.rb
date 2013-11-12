require 'spec_helper'
require 'json'

describe Cetacean do
  before do
    stub_service('http://api.example.com', AwesomeHalStub)
  end

  let(:api) do
    Faraday.new('http://api.example.com') do |f|
      f.headers['Accept'] = 'application/hal+json'
    end
  end

  context "when fed a valid HAL response" do
    subject { Cetacean.new(api.get) }

    it "can find links by rel" do
      expect(subject.get_uri(:self)).to eq('/')
    end
  end
end
