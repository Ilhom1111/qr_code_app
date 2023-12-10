import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultQrCodePage extends StatefulWidget {
  final String result;
  const ResultQrCodePage({super.key, required this.result});

  @override
  State<ResultQrCodePage> createState() => _ResultQrCodePageState();
}

class _ResultQrCodePageState extends State<ResultQrCodePage> {
  void tekshirishFunksiyasi(String str) async {
    String url = str;
    Uri? uri;
    try {
      if (url.startsWith("https://") || url.startsWith("http://")) {
        uri = Uri.parse(url);
      } else {
        uri = Uri.parse("https://www.google.com/search?q=$url");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This is not a url!"),
        ),
      );
      return;
    }

    if (uri.scheme.isEmpty || uri.host.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This is not a url!"),
        ),
      );
      return;
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.color,
        elevation: .0,
        title: const Text('Scan'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: CustomColors.color,
                ),
              ),
              width: MediaQuery.sizeOf(context).width,
              child: SingleChildScrollView(
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.result,
                        style: TextStyle(
                          color: CustomColors.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(widget.result).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Text copied."),
                      ),
                    );
                  });
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 3,
                  height: 54,
                  decoration: BoxDecoration(
                    color: CustomColors.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.copy_all,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  tekshirishFunksiyasi(widget.result);
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 3,
                  height: 54,
                  decoration: BoxDecoration(
                    color: CustomColors.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.open_in_browser,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
