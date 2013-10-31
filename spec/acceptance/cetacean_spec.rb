require 'spec_helper'

describe "Poking around the root" do
  subject { Cetacean.new('http://example.com/') }

  context "with a good response" do
    context "that is application/hal+json" do
      it "has access to the attributes" do
        expect(subject.attributes).to eq('foo' => 1, 'bar' => true)
      end

      it "knows about link rels" do
        expect(subject.links.rels).to eq(%w(link1 link2))
      end

      it "knows if a rel is in the links section or not" do
        expect(subject.links.include?(:link1)).to be_true
        expect(subject.links.include?(:not_a_link)).to be_false
      end

      it "knows about embedded rels" do
        expect(subject.embedded.rels).to eq(%w(embed1 embed2))
      end

      it "knows if a rel is in the embedded section or not" do
        expect(subject.embedded.include?(:embedded1)).to be_true
        expect(subject.embedded.include?(:not_embedded)).to be_false
      end

      it "knows the response code" do
        expect(subject.status).to eq(200)
      end

      it "knows the response body" do
        expect(subject.body).to eq(raw_json_body)
      end

      it "knows the content type" do
        expect(subject.content_type).to eq('application/hal+json')
      end
    end

    context "that isn't HAL" do
      it "knows the response code" do
        expect(subject.status).to eq(200)
      end

      it "knows the response body" do
        expect(subject.body).to eq('Non-HAL body.')
      end

      it "knows the content type" do
        expect(subject.content_type).to eq('text/plain')
      end
    end
  end

  context "with an error response" do
    context "that is HAL" do
      it "knows the response code" do
        expect(subject.status).to eq(404)
      end

      it "isn't a success" do
        expect(subject).to_not be_success
      end

      it "still parses the HAL" do
        expect(subject.attributes['foo']).to eq(1)
        expect(subject.links.rels).to eq(%w(link1 link2))
      end
    end

    context "that isn't HAL" do
      it "knows the response code" do
        expect(subject.status).to eq(404)
      end

      it "isn't a success" do
        expect(subject).to_not be_success
      end

      it "knows the response body" do
        expect(subject.body).to eq('Non-HAL body.')
      end
    end
  end
end
