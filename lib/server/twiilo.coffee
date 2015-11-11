WebApp.connectHandlers.use "/twilio", (req, res, next) ->
  response = """
    <?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <Response><Message>Hello, Mobile Monkey</Message></Response>
  """

  res.writeHead 200,
    'Content-Type': 'text/xml'

  res.end(response)