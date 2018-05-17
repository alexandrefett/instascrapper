library instascrapper;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'Endpoint.dart';
export 'src/instascrapper_base.dart';

class Instagram {

  HttpClient client;
  var rhxgis;
  List<Cookie> cookies = new List<Cookie>();

  Instagram(this.client);

  Future<HttpClientResponse> makeRequest(Uri uri, List<Cookie> cookies) async {
    var request = await client.openUrl('GET', uri);
    request.cookies.addAll(cookies);
    request.followRedirects = false;
    return await request.close();
  }

  Future<HttpClientResponse> makeRequestLogin(Map map, Uri uri, List<Cookie> cookies) async {
    var req = await client.postUrl(uri);
      req.cookies.addAll(cookies);
      req.followRedirects = false;
      req.headers.add('Accept-Encoding', 'gzip');
      req.headers.add('Accept', 'application/json');
      req.headers.add(Endpoint.REFERER, Endpoint.BASE_URL);
      req.headers.add("X-CSRFToken",_withCsrfToken(req));
      req.write(map);
      return req.close();
  }

  Future basePage() async {
    var response = await makeRequest(Uri.parse(Endpoint.BASE_URL), [])
        .then((HttpClientResponse res) {
//        print(res.statusCode);
        print(res.headers);
        res.headers.forEach((String s, List<String> list){
          if(s=='set-cookie'){
            print('===$s');
            list.forEach((String ss){
              cookies.add(new Cookie('cookie', ss));
            });
          }
        });
        //res.cookies.forEach((Cookie c){print('c.value=$c.value');});
        //print(res.cookies);
        _readResponse(res).then((String body) => _getRhxGis(body));
    });
  }

  Future login(String username, String password) async {
    Map map = new Map<String, String>();
    map['username'] = username;
    map['password'] = password;

    var response = await makeRequestLogin(map, Uri.parse(Endpoint.LOGIN_URL), [])
      .then((HttpClientResponse res){
      print(res.statusCode);
      print(res.headers);
        _readResponse(res).then((String body){
        print('body:$body');
      });
    });
  }

   String _withCsrfToken(HttpClientRequest request) {
    List<Cookie> cookies = request.cookies;
    print('Cookies: $cookies');
    cookies.removeWhere((cookie) => cookie.value != "csrftoken");
    if (cookies.length > 0) {
      Cookie cookie = cookies[0];
      request.headers.add("X-CSRFToken", cookie.value);
      return cookie.value;
    }
  }

  void _getRhxGis(String body) {
    RegExp exp = new RegExp('\"rhx_gis\":\"([a-f0-9]{32})\"');
    Iterable<Match> matches = exp.allMatches(body);
    print("matches: $matches");
    Match m = matches.elementAt(0);
    if (m != null) {
      rhxgis = m.group(1);
      print('rhxgis: ${this.rhxgis}');
    }
  }

  Future<String> _readResponse(HttpClientResponse response) {
    var completer = new Completer();
    var contents = new StringBuffer();
    response.transform(UTF8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}

