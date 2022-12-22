class WebviewService extends Object {
  static String renderHtml(String html, dynamic data) {
    return html.replaceAll('{{data}}', data.toString());
  }
}
