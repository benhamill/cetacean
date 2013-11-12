class Cetacean::EmbeddedResource
  include Cetacean::Resource

  def initialize(document)
    @hal = document
  end

  private

  attr_reader :hal
end
