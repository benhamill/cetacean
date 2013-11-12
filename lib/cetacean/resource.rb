require 'uri_template'
require 'forwardable'
require 'active_support'

module Cetacean::Resource
  extend Forwardable

  def_delegators :hal, :[], :fetch

  def attributes
    hal.except('_links', '_embedded')
  end

  def embedded(rel=nil)
    return hal['_embedded'] if rel.nil?

    rel = rel.to_s

    if (document = embedded[rel])
      case document
      when Array
        Cetacean::EmbeddedResourceCollection.new(document)
      else
        Cetacean::EmbeddedResource.new(document)
      end
    end
  end

  def get_uri(rel)
    return unless links.include?(rel.to_s)

    URITemplate.new(links[rel.to_s]['href'])
  end

  def links
    hal['_links'] || {}
  end
end
