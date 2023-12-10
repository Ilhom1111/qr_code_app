import 'package:flutter/material.dart';
import 'package:qr_code_app/pages/qr_code_page.dart';
import 'package:qr_code_app/views/home_page/size.dart';

import '../constants/colors.dart';
import '../url/url.dart';
import '../views/home_page/dropdown.dart';
import '../views/home_page/format.dart';
import '../views/home_page/text_text_field.dart';

class CreatQrCodePage extends StatefulWidget {
  const CreatQrCodePage({super.key});

  @override
  State<CreatQrCodePage> createState() => _CreatQrCodePageState();
}

class _CreatQrCodePageState extends State<CreatQrCodePage> {
  final TextEditingController _textController = TextEditingController();
  late TextEditingController _colorController;
  late TextEditingController _bgcolorController;

  String size = "200x200";
  String format = "png";

  @override
  void initState() {
    _colorController = TextEditingController(text: "000000");
    _bgcolorController = TextEditingController(text: "ffffff");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        backgroundColor: Colors.transparent,
        title: Text(
          'QR code generator',
          style: TextStyle(
              color: CustomColors.color,
              fontSize: 22,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: null,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height - 100,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                TextTextField(
                  controller: _textController,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Color:',
                        style: TextStyle(
                          color: CustomColors.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: TextField(
                          controller: _colorController,
                          maxLength: 6,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counter: const SizedBox(),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            fillColor: Colors.amber.shade100,
                            hintText: "color",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: CustomColors.color),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropDn(
                    text: 'Sized:',
                    value: size,
                    items: Sized.items,
                    onChanged: (value) {
                      size = value!;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 10),
                //*-----------------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Bgcolor:',
                        style: TextStyle(
                          color: CustomColors.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: TextField(
                          controller: _bgcolorController,
                          maxLength: 6,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counter: const SizedBox(),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            fillColor: Colors.amber.shade100,
                            hintText: "color",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: CustomColors.color),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropDn(
                    text: 'Format:',
                    value: format,
                    items: Format.items,
                    onChanged: (value) {
                      format = value!;
                      setState(() {});
                    },
                  ),
                ),
                const Spacer(flex: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 54),
                          backgroundColor: CustomColors.color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      onPressed: () {
                        String text = _textController.text.trim();
                        String color = _colorController.text.trim();
                        String bgcolor = _bgcolorController.text.trim();
                        if (text.isEmpty || color.isEmpty || bgcolor.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Not all rows are filled!!!"),
                            ),
                          );
                          return;
                        } else {
                          if (color.length == 6 && bgcolor.length == 6) {
                            String _qr =
                                "${Link.link}?data=$text&size=$size&color=$color&bgcolor=$bgcolor&format=$format";
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRCodePage(
                                  qrCode: _qr,
                                  format: format,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Colors entered incorrectly!!!"),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Create a QR code",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
