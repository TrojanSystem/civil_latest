import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class StoragePDFReport {
  String id;
  String name;
  String quantity;
  String date;
  String storekeeper;

  StoragePDFReport({
    this.id,
    this.date,
    this.quantity,
    this.storekeeper,
    this.name,
  });
}

class FileHandlerForStorage extends ChangeNotifier {
  //final helper = DatabaseHelper.instance;

  List<StoragePDFReport> fileList = [];

  // void initializeOptions(List<dynamic> fileList) {
  //   this.fileList = fileList;
  //   notifyListeners();
  // }
  void addLabour(StoragePDFReport model) {
    fileList.insert(0, model);
    notifyListeners();
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
    grid.columns.add(count: 5);
// Add a grid header row.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'ID';
    headerRow.cells[1].value = 'Storekeeper Name';
    headerRow.cells[2].value = 'Item Name';
    headerRow.cells[3].value = 'Item Quantity';

    headerRow.cells[4].value = 'Item Date';

// Set header font.
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold);
// Add rows to the grid.

    for (int x = 0; x < fileList.length; x++) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = fileList[x].id;
      row.cells[1].value = fileList[x].storekeeper;
      row.cells[2].value = fileList[x].name;
      row.cells[3].value = fileList[x].quantity;

      row.cells[4].value = fileList[x].date;
    }

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold);
// Draw table in the PDF page.
    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 0, 0, 0));
// Save the document.
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunch(bytes, 'ShopStore Report.pdf');
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
