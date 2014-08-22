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

  def [](index)
    Cetacean::EmbeddedResource.new(document_array[index])
  end

  private

  attr_reader :document_array
end
