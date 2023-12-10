import 'package:flutter/material.dart';

import 'pages/qr_scain_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QR Scan",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: false,
      ),
      home: const QRScainPage(),
    );
  }
}
