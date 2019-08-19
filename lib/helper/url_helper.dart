final domain = '192.168.1.100';
final String rest = 'http://' + domain + '/ta_mudharabah/api/';
final String urlWeb = 'http://' + domain + '/ta_mudharabah/';

String baseUrl(String url) {
  return rest + url;
}

String assetUrl(String url) {
  return urlWeb + url;
}
