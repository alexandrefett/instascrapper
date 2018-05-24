library instascrapper;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'Endpoint.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/src/FormData.dart';

export 'src/instascrapper_base.dart';

class Instagram {

  HttpClient client;
  var rhxgis;
  List<Cookie> cookies = new List<Cookie>();

  Instagram(this.client);

  Future<HttpClientResponse> makeRequest(Uri uri, List<Cookie> cookies) async {
    var request = await client.openUrl('GET', uri);
    //request.headers.contentType = new ContentType("application", "json", charset: "utf-8");

    print('RESPONSE');
    //request.cookies.addAll(cookies);
    request.followRedirects = false;

    return await request.close();
  }

  Future<HttpClientResponse> makeRequestLogin(Map map, Uri uri, List<Cookie> cookies) async {
    FormData form = new FormData();
    form.add('username', 'hoteiseverest');
    form.add('password', 'everest1357.');
    var req = await client.postUrl(uri)
    ..headers.contentType = ContentType.parse('application/x-www-form-urlencoded')
   // ..headers.add('Accept', 'application/json')
    ..headers.add(Endpoint.REFERER, Endpoint.BASE_URL)
    ..headers.add("X-CSRFToken",_withCsrfToken())
    ..cookies.addAll(cookies)
    ..followRedirects = false
    ..persistentConnection = true
      ..add(form.bytes());
    print('REQUEST');
    print(req.headers);
      return req.close();
  }

  Future basePage() async {
    HttpClientResponse response = await makeRequest(Uri.parse('https://www.instagram.com'), [])
        .then((HttpClientResponse res) {
//        print(res.statusCode);
      print('RESPONSE BASE');
      print(res.headers.forEach((String f, List<String> l) {
        if(f=='set-cookie'){
          l.forEach((String g){
            if(g.contains('csrftoken') || g.contains('rur') || g.contains('mid'))
              cookies.add(new Cookie.fromSetCookieValue(g.replaceAll('"', "'")));
          });
        }
      }));
      print(res.statusCode);
      print(res.headers);
      //cookies = res.cookies;
        //res.cookies.forEach((Cookie c){print('c.value=$c.value');});
        //print(res.cookies);
        //_readResponse(res).then((String body) => _getRhxGis(body));
    });
  }

  Future login(String username, String password) async {
    Map map ={"username":"hoteiseverest","password":"everest1357."};
    //new Map<String, String>();
    //map['username'] = username;
    //map['password'] = password;
    print (map);
    var response = await makeRequestLogin(map, Uri.parse(Endpoint.LOGIN_URL), cookies)
      .then((HttpClientResponse res){
      print('RESPONSE LOGIN');
      print(res.statusCode);
      print(res.headers);
        _readResponse(res).then((String body){
        print('body:$body');
      });
    });
  }

   String _withCsrfToken() {
    List<Cookie> cookies = this.cookies;
    print('Cookies: $cookies');
    return this.cookies.firstWhere((Cookie c) => c.name=='csrftoken').value;//.cookies.removeWhere((cookie) => cookie.name != "csrftoken");
    //if (cookies.length > 0) {
     // Cookie cookie = cookies[0];
      //request.headers.add("X-CSRFToken", cookie.value);
     // return cookie.value;
   // }
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

