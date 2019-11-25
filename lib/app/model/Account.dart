class Account {
  String secret;
  String issuer;

  Account(this.secret, this.issuer);

  Account.withUri(String uri) {
    this.readUri(uri);
  }

  void readUri(String uri) {
    RegExp exp = new RegExp(r"secret(.*?)(?=%|&)");
    String secretMatch = exp.stringMatch(uri);

    if (secretMatch != null) {
      this.secret = secretMatch.split("=")[1];
    }

    exp = new RegExp(r"issuer(.*?)(?=%|&)");
    String issuerMatch = exp.stringMatch(uri);

    if (issuerMatch != null) {
      this.issuer = issuerMatch.split("=")[1];
    }
  }
}
