class URLHelper {
  //deployment
  var deploy = "https://rabbitania-runtimeterrors.herokuapp.com/";
  //development
  var dev = "https://10.0.2.2:5001";
  var devAlt = "http://10.0.2.2:5000";

  getBaseURL() async {
    return dev;
  }

  getAltBaseURL() async {
    return devAlt;
  }
}
