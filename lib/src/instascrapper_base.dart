// TODO: Put public facing types in this file.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:instascrapper/instascrapper.dart';

main(){
  HttpClient client = new HttpClient();

  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36';

  Instagram instagram = new Instagram(client);
  instagram.basePage().then((String r) => instagram.login('hoteiseverest', 'everestrio'));

}

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}
