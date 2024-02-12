import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/services/noification_service.dart';

class DownloadDialogScreen extends StatefulWidget {
  String original;
  DownloadDialogScreen({required this.original,super.key});

  @override
  State<DownloadDialogScreen> createState() => _DialogState();
}

class _DialogState extends State<DownloadDialogScreen> {
  var downloadPercent = "0";
  double percent = 0;

  void download(String original) async {
    var time = DateTime.now().microsecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$time.jpg";
    Dio().download(original, path,onReceiveProgress: (actualBytes,totalBytes){
      setState(() {
        var percentage = actualBytes/totalBytes *100;
        percent = percentage/100;
        downloadPercent = percentage.floor().toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    download(widget.original);
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Download"),
      content: Container(
        height: 100,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            downloadPercent=="100" ? Text("Downloaded Completed") :Text("Downloading ..."),
            SizedBox(height: 20,),
            LinearProgressIndicator(value: percent,color: Colors.orange,),
            SizedBox(height: 10,),
            Text("${downloadPercent} %",style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "Image downloaded successfully")));
          NotificationService().showNotification(title: widget.original.substring(8,25),body: "Image Downloaded successfully");
        }, child: downloadPercent=="100" ? Text("Done",style: TextStyle(color: Colors.green),) : Text("Done",style: TextStyle(color: Colors.red),))
      ],
    );
  }
}

