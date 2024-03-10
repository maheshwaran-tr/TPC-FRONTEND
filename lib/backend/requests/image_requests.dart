import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../url_config/urls.dart';

class ImageRequests {
  static Future<Uint8List> fetchImageByName(String imageName) async {
    String theUrl = "${Urls.getImageByUsername}/$imageName";
    Uri uri = Uri.parse(theUrl);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      // Handle error
      print('Error fetching image by name');
      throw Exception('Failed to fetch image');
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Replace with your Spring Boot backend upload URL
      Uri uri = Uri.parse(Urls.uploadImage);

      var request = http.MultipartRequest('POST', uri)
        ..fields['name'] = 'image_name'
        ..files.add(await http.MultipartFile.fromPath('file', pickedFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Image uploaded successfully
        print("Image Uploaded Successfully");
      } else {
        print(response.statusCode);
        // Handle error
        print('Error uploading image');
      }
    }
  }
}
