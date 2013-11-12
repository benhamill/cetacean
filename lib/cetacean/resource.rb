require 'uri_template'

module Cetacean::Resource
  def get_uri(rel)
    URITemplate.new(links[rel.to_s]['href'])
  end

  private

  def links
    hal['_links']
  end
end
