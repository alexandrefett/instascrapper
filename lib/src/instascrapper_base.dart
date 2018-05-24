// TODO: Put public facing types in this file.
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../Endpoint.dart';
import 'package:instascrapper/instascrapper.dart';

main(){
/*
  Dio dio = new Dio();
  dio.options = new Options(
      baseUrl: Endpoint.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 10000,
      headers: {
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36"
      },
      contentType: ContentType.JSON,
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.PLAIN
  );
  Future basePage() async {
      Response response = await dio.get("https://www.instagram.com");
      print(response.data);
  }

  basePage();
*/

  Cookie cookie = new Cookie.fromSetCookieValue('csrftoken=3TFkOK8JtVfpZiY3ZWksL5m0YQVoXRhU; expires=Thu, 23-May-2019 18:39:23 GMT; Max-Age=31449600; Path=/; Secure');
  print(cookie);
  HttpClient client = new HttpClient();

  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36';

  Instagram instagram = new Instagram(client);
  instagram.basePage().then((String r) => instagram.login('hoteiseverest', 'everest1357.'));
}

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}
