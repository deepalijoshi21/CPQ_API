public class JWTBearerFlow {

  public static AccessTokenInfo getAccessToken(String tokenEndpoint, JWT jwt) {

    String body = 'grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=' + jwt.issue();
    HttpRequest req = new HttpRequest();
    req.setMethod('POST');
    req.setEndpoint(tokenEndpoint);
    req.setHeader('Content-type', 'application/x-www-form-urlencoded');
    req.setBody(body);
    Http http = new Http();
    HTTPResponse res = http.send(req);

    String access_token = null;
    Integer expires_in = null;
    if ( res.getStatusCode() == 200 ) {
      System.debug('Auth response: ' + res.getBody());
      System.JSONParser parser = System.JSON.createParser(res.getBody());
      while (parser.nextToken() != null) {
        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {
          parser.nextToken();
          access_token = parser.getText();
        }

        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'expires_in')) {
          parser.nextToken();
          expires_in = Integer.valueOf(parser.getText());
        }
      }
    }
    return access_token == null ? null : new AccessTokenInfo(access_token, expires_in);
  }

  public class AccessTokenInfo {
    public String token { get; private set; }
    public Integer expiresIn { get; private set; }

    public AccessTokenInfo(String token, Integer expiresIn) {
      this.token = token;
      this.expiresIn = expiresIn;
    }
  }
}