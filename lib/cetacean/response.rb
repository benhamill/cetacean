class Cetacean::Response
  include Cetacean::Resource

  def_delegators :response, :status, :success?, :body

  attr_reader :response

  # Feed me Faraday::Response objects or things that quack like them.
  def initialize(response)
    @response = response
  end

  # Tells you whether the response thinks it's a HAL document or not. Does no
  # validation.
  def hal?
    response.headers['content-type'] =~ %r{\Aapplication/hal\+json}
  end

  private

  def hal
    @hal ||= parse_hal
  end

  def parse_hal
    hal? ? JSON.parse(response.body) : {}
  rescue JSON::JSONError, TypeError
    {}
  end
end
