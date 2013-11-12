class AwesomeHalStub < HalServiceStub
  get '/' do
    {
      _links: {
        self: { href: '/' },
      },
    }
  end
end
