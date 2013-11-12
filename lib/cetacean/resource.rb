require 'uri_template'

module Cetacean::Resource
  def get_uri(rel)
    return unless links.include?(rel.to_s)

    URITemplate.new(links[rel.to_s]['href'])
  end

  private

  def links
    hal['_links'] || {}
  end
end
