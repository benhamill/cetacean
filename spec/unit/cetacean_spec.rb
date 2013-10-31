require 'spec_helper'

describe Cetacean do
  describe ".version" do
    it "is available as a constant" do
      expect(Cetacean::VERSION).to_not be_nil
    end

    it "is available as a method" do
      expect(Cetacean.version).to_not be_nil
    end
  end
end
