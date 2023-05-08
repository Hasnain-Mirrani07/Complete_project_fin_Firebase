import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_app/utils/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageUploadingApi extends StatefulWidget {
  const ImageUploadingApi({super.key});

  @override
  State<ImageUploadingApi> createState() => _ImageUploadingApiState();
}

class _ImageUploadingApiState extends State<ImageUploadingApi> {
  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  var imagepath;
  final _picker = ImagePicker();
  bool spinner = false;
  String? base64val;
  Future getImage() async {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      // Uint8List imagebyte = await pickedFile.readAsBytes();
      // base64val = base64.encode(imagebyte);

      imagepath = File(pickedFile.path);
      // print(base64val);
      // print(imagepath);
      setState(() {});
    } else {
      const Text("no immage selected");
    }
  }

  File? _vedio;

  final picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;

  _pickVideo() async {
    final video = await picker.getVideo(source: ImageSource.gallery);
    _vedio = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_vedio!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  // Future<void> upload(var base64image, var vedio) async {
  //   String base64Video;
  //   Uint8List videobyte = await vedio!.readAsBytes();
  //   base64Video = base64.encode(videobyte);
  //   print(">>image>>>$base64image");
  //   print(">>video>>>$base64Video");
  //   var headers = {
  //     'Authorization':
  //         'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcxNzk4ODgxLCJpYXQiOjE2NjkyMDY4ODEsImp0aSI6ImUzMzBjNmQ0YmM3MzQwODZhYmFiYWRkYmJhNDAyNmJlIiwidXNlcl9pZCI6MX0.tAybVMizu3_pJEhKQ4aQzM6CQiLUB0iaN7szePRNOog',
  //     'Content-Type': 'application/json'
  //   };

  //   var request = http.Request(
  //       'POST', Uri.parse('https://gymat.ascit.sa/api/trainer/docs/create'));
  //   request.body = json.encode({
  //     "TrainerId": 2,
  //     "Pictures": [
  //       {
  //         "WorkoutName": "ABC",
  //         "LevelName": "Abc",
  //         "IsPaid": true,
  //         "IsVideo": true,
  //         "Thumbnail": {
  //           "fileName": "thumbnail.png",
  //           "filePath": " data:image/png;base64,$base64image"
  //         },
  //         "Amount": 123,
  //         "fileName": "abc.mp4",
  //         "filePath": "data:video/mp4;base64,$base64Video"
  //         //  data:video/mp4;base64,"
  //       }
  //     ]
  //   });
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();
  //   var data = await response.stream.bytesToString();
  //   debugPrint(">>reponse>>>$data");
  //   if (response.statusCode <= 201) {
  //     print("sccessfully upload");
  //   } else {
  //     print("Sorry ");
  //     print(response.reasonPhrase);
  //   }
  // }

  // Future<void> uploadImage() async {
  //   final stream = new http.ByteStream(image!.openRead());
  //   stream.cast();
  //   var length = await image!.length();
  //   var uri = Uri.parse("https://fakestoreapi.com/products");
  //   var request = new http.MultipartRequest("POST", uri);
  //   request.fields['title'] = "Static Title";
  //   var multipart = new http.MultipartFile('image', stream, length);
  //   request.files.add(multipart);

  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(request.toString());
  //     print('Image uploaded successfully');
  //     // print("response is ${data["id"]}");
  //     // print(response);
  //     setState(() {
  //       spinner = false;
  //     });
  //     print("image sucessfully uploaded on Server");
  //   }
  //   print("Faild to upload");
  // }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: spinner,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Image Uploading Api"),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => getImage(),
                  child: Container(
                    child: imagepath == null
                        ? const SizedBox(
                            height: 20,
                            child: Center(
                              child: Text("Pick Image image"),
                            ),
                          )
                        : Container(
                            child: Center(
                                child: Image.file(
                            File(imagepath!.path).absolute,
                            height: 100,
                            width: 150,
                          ))),
                  ),
                ),
                Column(
                  children: [
                    if (_vedio != null)
                      SizedBox(
                          height: 300,
                          width: 400,
                          child: _videoPlayerController!.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController!.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController!),
                                )
                              : null)
                    else
                      const Text("Click to Select Video"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: const Text("Picke Vedio"),
                          onPressed: () {
                            _pickVideo();
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print("pres");
                        try {
                          var id = DateTime.now().millisecond.toString();
                          firebase_storage.Reference ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref('/foldername$id');
                          firebase_storage.UploadTask uploadTask =
                              ref.putFile(imagepath!.absolute);
                          await Future.value(uploadTask).then((value) async {
                            var newurl = await ref.getDownloadURL();
                            databaseRef
                                .child(id)
                                .set({'id': id, 'title': newurl.toString()});
                            print("upload");
                            ReUse().loginErrorToast("Succefully to upload");
                            setState(() {
                              //upload(base64val, _vedio);
                            });
                          });
                        } catch (e) {
                          return ReUse().loginErrorToast("Failed to upload");
                        }
                      },
                      child: const Text("upload"),
                    )
                  ],
                ),
              ]),
        ));
  }
}
