import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TodosModel {
  bool checked = false;
  int id;
  String todo;
  String date;

  TodosModel({
    this.id,
    this.todo,
    this.date,
  });
}

class TodoHandler extends ChangeNotifier {
  //final helper = DatabaseHelper.instance;

  List<TodosModel> fileList = [];

  // void initializeOptions(List<dynamic> fileList) {
  //   this.fileList = fileList;
  //   notifyListeners();
  // }
  void addLabour(TodosModel model) {
    print('first length ${fileList.length}');
    fileList.insert(0, model);
    notifyListeners();
    print('second length ${fileList.length}');
  }

  void removeLabour(int id) {
    fileList.removeAt(id);
    notifyListeners();
  }

  Future<void> createTable() async {
    // Create a new PDF document.
    final PdfDocument document = PdfDocument();
// Add a new page to the document.
    final PdfPage page = document.pages.add();
// Create a PDF grid class to add tables.
    final PdfGrid grid = PdfGrid();
// Specify the grid column count.
    grid.columns.add(count: 2);
// Add a grid header row.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    // headerRow.cells[0].value = 'Labour ID';
    headerRow.cells[0].value = 'Todo';
    headerRow.cells[1].value = 'Date';

// Set header font.
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold);
// Add rows to the grid.

    for (int x = 0; x < fileList.length; x++) {
      PdfGridRow row = grid.rows.add();
      // row.cells[0].value = fileList[x].id;
      row.cells[0].value = fileList[x].todo;
      row.cells[1].value = fileList[x].date;

    }

// Add next row.
//     row = grid.rows.add();
//     row.cells[0].value = fileList[1].id;
//     row.cells[1].value = fileList[1].name;
//     row.cells[2].value = fileList[1].title;
//     row.cells[3].value = fileList[1].price;
//     row.cells[4].value = fileList[1].phone;
//     row.cells[5].value = fileList[1].date;
// // Add next row.
//     row = grid.rows.add();
//     row.cells[0].value = '3';
//     row.cells[1].value = 'Antonio Mereno';
//     row.cells[2].value = 'Architectural Engineer';
//     row.cells[3].value = '500';
//     row.cells[4].value = '0912654975';
//     row.cells[5].value = '1/28/2022';
// Set grid format.
    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold);
// Draw table in the PDF page.
    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 0, 0, 0));
// Save the document.
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunch(bytes, 'Todo Sheet.pdf');
    // File('PDFTable.pdf').writeAsBytes(document.save());
// Dispose the document.
    document.dispose();
  }

  Future<void> saveAndLaunch(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory()).path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
}
