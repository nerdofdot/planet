import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';


class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {


  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late QRViewController controller;

  bool isQRInvalid = false;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.green,
                        overlayColor: Colors.black54,
                        borderWidth: 10,
                        borderLength: 30,
                        borderRadius: 20,
                        cutOutSize: 250,
                      ),
                    ),
                    Opacity(child: Icon(Icons.eco,size: 50,color: Colors.green,),opacity: 0.70,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2,bottom: 30),
                      child: Text("Place the QR code in center\nQR Scanner by  © PLANET",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                    ),

                    isQRInvalid?Text("Invalid QR Code scanned",style: TextStyle(color: Colors.red,fontFamily: "Lato",fontWeight: FontWeight.w700),):Container(),
                  ],
                )
              ],
            )
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      late Map qrResult;
      result = scanData;
      String abc = result!.code.toString();
      print(abc);

      try
      {
        qrResult = json.decode(abc);
      }
      catch(er)
      {
        print("1111122223333#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%%#%#%#%#%#%#%#%#%#%#%#");
        setState(() {
          isQRInvalid = true;
        });
      }



      if(qrResult.containsKey("isW")&& qrResult.containsKey("cr"))
        {
          print("#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%%#%#%#%#%#%#%#%#%#%#%#");
          setDataOfQR(qrResult);
          Navigator.pushReplacementNamed(context, "/plantInfo");
        }
      else
        {
          setState(() {
            isQRInvalid = true;
          });
      }

      isQRInvalid?print("hi"):controller.dispose();


    });
  }

  setDataOfQR(Map qrResult)
  {
    completeInfo['nameOfPlant'] = qrResult['np'];
    completeInfo['nameOfNursery'] = qrResult['nn'];
    completeInfo['typeOfPlant'] = qrResult['tp'];
    completeInfo['price'] = qrResult['p'];
    completeInfo["minTemp"] = qrResult["mi"];
    completeInfo["maxTemp"] = qrResult["ma"];
    completeInfo["isWaterNeeded"] = qrResult['isW'];
    completeInfo['isSunNeeded'] = qrResult['isS'];
    completeInfo['isChemicalNeeded'] = qrResult['isC'];
    completeInfo['care'] = qrResult['cr'];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
