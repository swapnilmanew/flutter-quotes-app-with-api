import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuoteController extends GetxController {
  RxString quote = "Tap on Get Quote to get a fresh new Quote".obs;
  RxString loading = "false".obs;
  getQuote() async {
    loading.value = "true";
    var response = await http.get(Uri.parse("https://api.quotable.io/random"));
    quote.value = jsonDecode(response.body)['content'];
    loading.value = "false";
  }
}
