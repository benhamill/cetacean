class Cetacean::EmbeddedResourceCollection
  include Enumerable

  def initialize(document_array)
    @document_array = document_array
  end

  def each
    document_array.each do |document|
      yield Cetacean::EmbeddedResource.new(document)
    end
  end

  private

  attr_reader :document_array
end
