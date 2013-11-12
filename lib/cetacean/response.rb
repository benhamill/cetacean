class Cetacean::Response
  include Cetacean::Resource

  attr_reader :response

  def initialize(response)
    @response = response
  end

  def hal?
    response.headers['content-type'] =~ %r{\Aapplication/hal\+json}
  end

  private

  def hal
    @hal ||= parse_hal
  end

  def parse_hal
    JSON.parse(response.body)
  end
end
