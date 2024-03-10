import 'dart:io';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import '../../backend/models/student_model.dart';

class StudentExcelService {
  static Future<void> createExcelFile(List<Student> students,String sheetName) async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    sheet.name = sheetName;
    List<String> columnNames = [
      'ID',
      'Roll No',
      'Reg No',
      'Student Name',
      'Community',
      'Gender',
      'Department',
      'Section',
      'Father Name',
      'Father Occupation',
      'Mother Name',
      'Mother Occupation',
      'Place of Birth',
      'Date of Birth',
      '10th Score',
      '10th Board',
      '10th Year of Passing',
      '12th Score',
      '12th Board',
      '12th Year of Passing',
      'Diploma Score',
      'Diploma Branch',
      'Diploma Year of Passing',
      'Permanent Address',
      'Present Address',
      'Phone Number',
      'Parent Phone Number',
      'Email',
      'Aadhar',
      'Placement Willing',
      'Batch',
      'Current Sem',
      'CGPA',
      'Skills',
      'Standing Arrears',
      'History of Arrears',
      'IV',
      'VIII',
      'II',
      'VI',
      'I',
      'V',
      'VII',
      'III',
    ];
    int len = columnNames.length;

    // ADD HEADERS
    for (var i = 0; i < len; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(columnNames[i]);
    }

    // ADD DATA
    int rowNumber = 2; // Starting from row 2 to insert data
    for (var student in students) {
      sheet.getRangeByIndex(rowNumber, 1).setValue(student.studentId);
      sheet.getRangeByIndex(rowNumber, 2).setText(student.rollNo ?? '');
      sheet.getRangeByIndex(rowNumber, 3).setText(student.regNo ?? '');
      sheet.getRangeByIndex(rowNumber, 4).setText(student.studentName ?? '');

      // Increment row number for the next student
      rowNumber++;
    }

    // Save Excel file
    final List<int> bytes = workbook.saveAsStream();
    // Save the file to a desired location (e.g., device storage)
    // In this example, the file is saved to the app's documents directory
    final String path = '/storage/emulated/0/Documents/test.xlsx';
    await File(path).writeAsBytes(bytes, flush: true);

    workbook.dispose();
  }
}