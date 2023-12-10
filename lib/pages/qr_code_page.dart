import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../views/loading.dart';

class QRCodePage extends StatefulWidget {
  final String qrCode;
  final String format;
  const QRCodePage({super.key, required this.qrCode, required this.format});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  double? _progress;
  _share() async {
    final uri = Uri.parse(widget.qrCode);
    final response = await http.get(uri);
    final imageBytes = response.bodyBytes;
    final t = await getTemporaryDirectory();
    final path = "${t.path}/qr_code.${widget.format}";
    File(path).writeAsBytesSync(imageBytes);
    Share.shareXFiles([XFile(path)],
        text: "QR Code Generator https://t.me/yusupov_ilhom_flutter_dev");
  }

  _save() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      FileDownloader.downloadFile(
          url: widget.qrCode,
          name: "qr_code_${DateTime.now()}.${widget.format}",
          onProgress: (fileName, progress) {
            setState(() {
              _progress = progress;
            });
            log('FILE fileName HAS PROGRESS $progress');
          },
          onDownloadCompleted: (path) {
            log('FILE DOWNLOADED TO PATH: $path');
            setState(() {
              _progress = null;
            });
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("QR code downloaded!."),
                ),
              );
            }
          },
          onDownloadError: (error) {
            log('DOWNLOAD ERROR: $error');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Something is wrong, check the internet!."),
                ),
              );
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: .0,
        backgroundColor: CustomColors.color,
        title: const Text('QR Code Generator'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.color, width: 2),
                  ),
                  child: widget.format == 'svg'
                      ? SvgPicture.network(
                          widget.qrCode,
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).width - 35,
                          fit: BoxFit.fill,
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const CircularProgressIndicator
                                      .adaptive()),
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.qrCode,
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).width - 35,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                ),
              ),
              const Spacer(flex: 2),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _share,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width / 3,
                        height: 54,
                        decoration: BoxDecoration(
                          color: CustomColors.color,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: _save,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width / 3,
                        height: 54,
                        decoration: BoxDecoration(
                          color: CustomColors.color,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.save_alt,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
          if (_progress != null) const Loading()
        ],
      ),
    );
  }
}
