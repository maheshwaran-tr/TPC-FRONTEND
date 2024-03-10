



import 'package:sit_placement_app/backend/models/student_model.dart';
import '../backend/requests/student_request.dart';

class Initializer{

  static Future<Student> initializeStudents(String token) {
    return StudentRequest.getStudentProfile(token);
  }
}