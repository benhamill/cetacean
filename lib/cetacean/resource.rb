require 'uri_template'
require 'forwardable'
require 'active_support'

module Cetacean::Resource
  extend Forwardable

  def_delegators :hal, :[], :fetch

  def attributes
    hal.except('_links', '_embedded')
  end

  def get_uri(rel)
    return unless links.include?(rel.to_s)

    URITemplate.new(links[rel.to_s]['href'])
  end

  def links
    hal['_links'] || {}
  end
end
