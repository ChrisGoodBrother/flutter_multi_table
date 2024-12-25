import 'package:flutter/material.dart';
import 'package:flutter_multi_table/flutter_multi_table.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Multi Table Example')),
        body: const SingleChildScrollView(child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late FlutterMultiTableController _controllerCreate;
  late FlutterMultiTableController _controllerSaved;
  late FlutterMultiTableConfig _create;
  late FlutterMultiTableConfig _saved;
  List<Map<String, String>> savedData = [];

  List<String> headers = [
    'No',
    'Name',
    'Age',
    'City',
    'Status',
  ];

  @override
  void initState() {
    super.initState();
    List<Map<String, String>> initialData = [
      {
        'No': '1',
        'Name': 'John',
        'Age': '',
        'City': 'New York',
        'Status': 'Active',
      },
      {
        'No': '2',
        'Name': 'Alice',
        'Age': '',
        'City': 'London',
        'Status': 'Inactive',
      },
    ];

    _controllerCreate = FlutterMultiTableController(
      initialData: initialData,
      headers: headers,
    );

    _controllerSaved = FlutterMultiTableController(
      initialData: const [],
      headers: headers,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _create = FlutterMultiTableConfig(
      headers: headers,
      hint: '....',
      validator: (row, column, value) {
        if (column == 2 && (value.isEmpty)) {
          return 'Data wajib diisi';
        }
        return null;
      },
      dropdownValidator: (row, column, value) {
        if (column == 2 && (value == null || value.isEmpty)) {
          return 'Data wajib diisi';
        }
        return null;
      },
      headerTextStyle: const TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      errorTextStyle: const TextStyle(fontSize: 8, color: Colors.red),
      cellTextStyle: const TextStyle(
        fontSize: 6,
        fontWeight: FontWeight.w600,
      ),
      cellWidth: MediaQuery.of(context).size.width * 0.182,
      cellHeight: MediaQuery.of(context).size.height * 0.04,
      hintTextStyle: const TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w400,
      ),
      isReadOnly: (row, column) {
        if (column == 0 || column == 1 || column == 3 || column == 4) {
          return true;
        }
        return false;
      },
      isDropdown: (row, column) {
        if (column == 2 && (row != 1 && row != 13)) {
          return true;
        }
        return false;
      },
      dropdownOptions: ['Jakarta', 'New York', 'London', 'Tokyo', 'Paris'],
      onChanged: (row, column, value) {
        debugPrint('Changed: Row $row, Column $column, Value: $value');
      },
    );

    // Config untuk tabel saved data (semua cell readonly)
    _saved = FlutterMultiTableConfig(
      headers: headers,
      headerTextStyle: const TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      cellTextStyle: const TextStyle(
        fontSize: 6,
        fontWeight: FontWeight.w600,
      ),
      cellWidth: MediaQuery.of(context).size.width * 0.182,
      cellHeight: MediaQuery.of(context).size.height * 0.04,
      isReadOnly: (row, column) => true, // Semua cell readonly
    );
  }

  void _saveData() {
    // Get current table data from the controller
    final currentData = _controllerCreate.tableData.map((row) {
      // Convert TextEditingController values to String
      return row.map((key, value) {
        return MapEntry(key, value.text); // Extract text value
      });
    }).toList();

    // Validate data before saving
    bool isValid = true;
    for (var row in currentData) {
      if (row['Age'] == null || row['Age']!.isEmpty) {
        isValid = false;
        break;
      }
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      savedData.addAll(currentData);
      // Update controller untuk saved table
      _controllerSaved = FlutterMultiTableController(
        initialData: savedData,
        headers: headers,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _controllerCreate.dispose();
    _controllerSaved.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Input Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          FlutterMultiTable(
            controller: _controllerCreate,
            config: _create,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _saveData,
              child: const Text('Submit'),
            ),
          ),
          if (savedData.isNotEmpty) ...[
            const SizedBox(height: 30),
            const Text(
              'Get Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            FlutterMultiTable(
              controller: _controllerSaved,
              config: _saved,
            ),
          ],
        ],
      ),
    );
  }
}
