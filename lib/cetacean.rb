require_relative 'cetacean/version'
require_relative 'cetacean/resource'
require_relative 'cetacean/embedded_resource'
require_relative 'cetacean/embedded_resource_collection'
require_relative 'cetacean/response'

module Cetacean
  def self.new(response)
    Cetacean::Response.new(response)
  end
end
