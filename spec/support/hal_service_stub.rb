require 'sinatra/base'

class HalServiceStub < Sinatra::Base
  configure do
    mime_type :hal, 'application/hal+json'
    mime_type :message, 'message/rfc822'
  end

  before do
    content_type :hal
  end

  after do
    if body == []
      body ''
    elsif content_type == 'application/hal+json'
      body JSON.dump(body)
    end
  end
end
