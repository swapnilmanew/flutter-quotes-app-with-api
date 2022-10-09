import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/controllers/quote_controller.dart';

class SingleQuote extends StatefulWidget {
  const SingleQuote({Key? key}) : super(key: key);

  @override
  State<SingleQuote> createState() => _SingleQuoteState();
}

class _SingleQuoteState extends State<SingleQuote> {
  final QuoteController quoteController = Get.put(QuoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                'Thank you so much for using the App. This app has been designed and Developed by Swapnil Mane.',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.lato().fontFamily),
                              ),
                              OutlinedButton(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily:
                                          GoogleFonts.lato().fontFamily),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.info))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          await Clipboard.setData(
              ClipboardData(text: quoteController.quote.toString()));
          final snackBar = SnackBar(
            content: Text(
              'Quote is copied to clipboard !',
              style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Icon(
          Icons.copy,
          color: Colors.black,
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => quoteController.loading == "true"
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "\"${quoteController.quote.toString()}\"",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 45),
                        ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    quoteController.getQuote();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      "Get Quote",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
