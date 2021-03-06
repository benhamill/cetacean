require 'spec_helper'
require 'json'

describe Cetacean do
  let(:api) do
    Faraday.new('http://api.example.com') do |f|
      f.headers['Accept'] = 'application/hal+json'
      f.adapter Faraday.default_adapter
    end
  end

  context "when fed a valid HAL response" do
    before do
      stub_service 'http://api.example.com', Sinatra.new do
        get '/' do
          content_type 'application/hal+json'
          JSON.dump(
            {
              _links: {
                self: { href: '/' },
              },
              api_ranking: 'the best',
              _embedded: {
                singular: {
                  _links: { self: { href: '/singular' } }
                },
                plural: [
                  { _links: { self: { href: '/plural/1' } } },
                  { _links: { self: { href: '/plural/2' } } },
                ]
              }
            }
          )
        end
      end
    end

    subject { Cetacean.new(api.get) }

    it "knows it's HAL" do
      expect(subject).to be_hal
    end

    it "can find links by rel" do
      expect(subject.get_uri(:self)).to eq('/')
    end

    it "hands out the links hash" do
      expect(subject.links).to eq('self' => { 'href' => '/' })
    end

    it "returns URITemplates when asked for a uri" do
      expect(subject.get_uri(:self)).to be_a(URITemplate)
    end

    it "allows access to attributes with []" do
      expect(subject['api_ranking']).to eq('the best')
    end

    it "allows access to attributes with fetch" do
      expect(subject.fetch('api_ranking')).to eq('the best')
    end

    it "does defaulting on attribute fetches" do
      expect(subject.fetch('not an attribute', 'default')).to eq('default')
    end

    it "hands out a hash of attributes" do
      expect(subject.attributes).to eq('api_ranking' => 'the best')
    end

    it "lists embeds" do
      expect(subject.embedded).to include('singular')
      expect(subject.embedded).to include('plural')
    end

    it "handles singular embeds" do
      expect(subject.embedded(:singular).get_uri(:self)).to eq('/singular')
    end

    it "handles plural embeds" do
      subject.embedded(:plural).each_with_index do |plur, index|
        expect(plur.get_uri(:self)).to eq("/plural/#{index + 1}")
      end
    end

    it "allows index access on plural embeds" do
      expect(subject.embedded(:plural)[0].get_uri(:self).to_s).to eq("/plural/1")
    end
  end

  context "when fed invalid HAL" do
    before do
      stub_service 'http://api.example.com', Sinatra.new do
        get '/' do
          content_type 'application/hal+json'
          "<html></html>"
        end
      end
    end

    subject { Cetacean.new(api.get) }

    it "thinks it's HAL" do
      expect(subject).to be_hal
    end

    it "can't find links by rel" do
      expect(subject.get_uri(:self)).to be_nil
    end
  end

  context "when fed non-HAL" do
    before do
      stub_service 'http://api.example.com', Sinatra.new do
        get '/' do
          "<html></html>"
        end
      end
    end

    subject { Cetacean.new(api.get) }

    it "knows it isn't HAL" do
      expect(subject).to_not be_hal
    end

    it "can't find links by rel" do
      expect(subject.get_uri(:self)).to be_nil
    end
  end
end
