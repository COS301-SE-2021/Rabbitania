class URLHelper {
  //deployment url
  var deploy = "https://rabbitania-runtimeterrors.herokuapp.com/";
  //mobile development url
  var dev = "https://10.0.2.2:5001";
  var devAlt = "http://10.0.2.2:5000";

  //function to return base development url
  getBaseURL() async {
    return dev;
  }

  //function ot return alternative development url
  getAltBaseURL() async {
    return devAlt;
  }
}
