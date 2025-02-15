import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

Future<XFile?> pickImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Or ImageSource.camera for camera
  return pickedFile;
}
