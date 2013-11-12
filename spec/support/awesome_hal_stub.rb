class AwesomeHalStub < HalServiceStub
  get '/' do
    {
      _links: { href: '/' },
    }
  end
end
