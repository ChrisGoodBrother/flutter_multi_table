// File: lib/src/flutter_multi_table_controller.dart

part of '../../flutter_multi_table.dart';

class FlutterMultiTableController extends ChangeNotifier {
  List<Map<String, String>> tableData;
  List<String> tableHeaders;

  FlutterMultiTableController({
    required List<Map<String, String>> initialData,
    required List<String> headers,
  })  : tableData = initialData.map((row) {
          return {for (String header in headers) header: row[header] ?? ''};
        }).toList(),
        tableHeaders = List.from(headers);

  void createRow() {
    tableData.add(
      {for (var header in tableHeaders) header: "-"},
    );
    notifyListeners();
  }

  void createColumn(String newHeader) {
    if (tableHeaders.contains(newHeader)) return;
    tableHeaders.add(newHeader);

    for (int i = 0; i < tableData.length; i++) {
      tableData[i].addAll({newHeader: "-"});
    }
    notifyListeners();
  }

  void deleteColumn(String header) {
    for (int i = 0; i < tableData.length; i++) {
      //Remove cell values for each row
      tableData[i].remove(header);
    }

    tableHeaders.remove(header); //Remove header
    notifyListeners();
  }

  void deleteLastRow() {
    tableData.removeLast();
    notifyListeners();
  }

  /// Updates the value of a specific cell in the table.
  void updateCell(int row, int column, String value) {
    
    if (row < tableData.length && column < tableData[row].length) {
      tableData[row][tableHeaders[column]] = value;
    }
    notifyListeners();
  }

  /// Retrieves the value of a specific cell in the table.
  String? getCellValue(int row, int column) {
    if (row < tableData.length && column < tableData[row].length) {
      return tableData[row].values.elementAt(column);
    }
    return null;
  }

  @override
  String toString() {
    String table = "";

    table += tableHeaders.join("-");

    for(var row in tableData) {
      table += "\n${row.values.join("-")}";
    }

    return table;
  }
}
