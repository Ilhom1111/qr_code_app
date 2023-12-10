import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_app/pages/creat_qr.dart';
import 'package:qr_code_app/pages/result_qr_code_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../constants/colors.dart';

class QRScainPage extends StatefulWidget {
  const QRScainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScainPageState();
}

class _QRScainPageState extends State<QRScainPage> {
  Barcode? result;
  QRViewController? controller;
  bool paus = false;
  bool camera = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _pause() async {
    if (paus == false) {
      await controller?.pauseCamera();
      paus = !paus;
      setState(() {});
    } else {
      await controller?.resumeCamera();
      paus = !paus;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: SafeArea(
          child: Stack(
            children: [
              _buildQrView(context),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.black.withOpacity(.4),
                      child: Row(
                        children: [
                          const Spacer(flex: 15),
                          IconButton(
                            onPressed: () {
                              paus = false;
                              _pause();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CreatQrCodePage(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 8),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.black.withOpacity(.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (camera == false) {
                                await controller?.flipCamera();
                                camera = !camera;
                                setState(() {});
                              } else {
                                await controller?.flipCamera();
                                camera = !camera;
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.cameraswitch_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: _pause,
                            icon: paus == false
                                ? const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                          ),
                          camera == true
                              ? const SizedBox(width: 40, height: 40)
                              : IconButton(
                                  onPressed: () async {
                                    await controller?.toggleFlash();

                                    setState(() {});
                                  },
                                  icon: FutureBuilder(
                                    future: controller?.getFlashStatus(),
                                    builder: (context, snapshot) {
                                      return snapshot.data == true
                                          ? const Icon(
                                              Icons.flash_on,
                                              color: Colors.white,
                                              size: 30,
                                            )
                                          : const Icon(
                                              Icons.flash_off,
                                              color: Colors.white,
                                              size: 30,
                                            );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    double scanArea = MediaQuery.sizeOf(context).width / 1.8;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: CustomColors.color,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultQrCodePage(result: result!.code.toString()),
          ),
        );
        paus = false;
        _pause();
      }
      result = scanData;
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
