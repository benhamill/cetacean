require 'spec_helper'
require 'json'

describe Cetacean do
  before do
    stub_service('http://api.example.com', AwesomeHalStub)
  end

  let(:api) do
    Faraday.new('http://api.example.com') do |f|
      f.headers['Accept'] = 'application/hal+json'
      f.adapter Faraday.default_adapter
    end
  end

  context "when fed a valid HAL response" do
    subject { Cetacean.new(api.get) }

    it "knows it's HAL" do
      expect(subject).to be_hal
    end

    it "can find links by rel" do
      expect(subject.get_uri(:self)).to eq('/')
    end
  end
end
