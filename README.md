# flutter_multi_table

[![pub package](https://img.shields.io/pub/v/flutter_multi_table)](https://pub.dartlang.org/packages/flutter_multi_table)
[![likes](https://img.shields.io/pub/likes/flutter_multi_table)](https://pub.dev/packages/flutter_multi_table/score)
[![popularity](https://img.shields.io/pub/popularity/flutter_multi_table)](https://pub.dev/packages/flutter_multi_table/score)
[![pub points](https://img.shields.io/pub/points/flutter_multi_table)](https://pub.dev/packages/flutter_multi_table/score)
[![GitHub stars](https://img.shields.io/github/stars/adampermana/flutter_multi_table?logo=github)](https://github.com/adampermana/flutter_multi_table/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/adampermana/flutter_multi_table?logo=github)](https://github.com/adampermana/flutter_multi_table/network)

A Flutter packages for creating dynamic, multi-column tables with features like dropdowns, validation, and read-only cells. Ideal for interactive table inputs.

## 💰 You can help me by Donating

[![BuyMeACoffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/adampermana)

## Demo

|                                          Input Data Mode Potrait                                           |                                                       Get Data Mode Potrait                                                       |
| :--------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: |
| ![input-data-table](https://raw.githubusercontent.com/adampermana/flutter_multi_table/refs/heads/master/demo/input-data-table.gif) | ![result-data-table](https://raw.githubusercontent.com/adampermana/flutter_multi_table/refs/heads/dev/demo/result-data-table.gif) |

|                                                    Input Data Mode Landscape                                                     |                                                      Get Data Mode Landscape                                                       |
| :------------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------: |
| ![input-data-table](https://raw.githubusercontent.com/adampermana/flutter_multi_table/refs/heads/dev/demo/input-data-table.jpeg) | ![result-data-table](https://raw.githubusercontent.com/adampermana/flutter_multi_table/refs/heads/dev/demo/result-data-table.jpeg) |

## Features

- ✨ Fully customizable table layout and styling
- 📝 Support for both text input and dropdown cells
- 🔒 Configurable read-only cells
- ✅ Built-in validation support
- 📱 Responsive design for both portrait and landscape orientations
- 🎨 Customizable styling for headers, cells, and error messages
- 🔄 Real-time data updates with onChange callbacks
- 💾 Easy data management with dedicated controller

## Supported platforms

- Flutter Android
- Flutter iOS
- Flutter web
- Flutter desktop
- Flutter macOS
- Flutter Linux

## Installation

1. Add `flutter_multi_table.dart: <latest-version>` to your `pubspec.yaml` dependencies. And import it:
   Get the latest version in the 'Installing' tab on pub.dev

```yaml
dependencies:
  flutter_multi_table: <latest-version>
```

```yaml
flutter pub add flutter_multi_table
```

2. Run pub get.

```yaml
flutter pub get
```

3. Import package.

```dart
import 'package:flutter_multi_table/flutter_multi_table.dart';
```

## Basic Usage

```dart
// 1. Define your headers
List headers = [
  'No',
  'Name',
  'Age',
  'City',
  'Status',
];

// 2. Create initial data
List<Map> initialData = [
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

// 3. Initialize controller
FlutterMultiTableController controller = FlutterMultiTableController(
  initialData: initialData,
  headers: headers,
);

// 4. Configure table
FlutterMultiTableConfig config = FlutterMultiTableConfig(
  headers: headers,
  hint: '....',
);

// 5. Use the widget
FlutterMultiTable(
  controller: controller,
  config: config,
)
```

## Advanced Configuration

### Table Configuration

```dart
FlutterMultiTableConfig config = FlutterMultiTableConfig(
  headers: headers,
  hint: '....',

  // Define which cells are read-only
  isReadOnly: (row, column) {
    if (column == 0 || column == 1 || column == 3 || column == 4) {
      return true;
    }
    return false;
  },

  // Configure dropdown cells
  isDropdown: (row, column) {
    if (column == 2 && (row != 1 && row != 13)) {
      return true;
    }
    return false;
  },
  dropdownOptions: ['Jakarta', 'New York', 'London', 'Tokyo', 'Paris'],

  // Handle value changes
  onChanged: (row, column, value) {
    print('Cell ($row, $column) changed to: $value');
  },

  // Validation
  validator: (row, column, value) {
    if (column == 2 && value.isEmpty) {
      return 'Data wajib diisi';
    }
    return null;
  },

  // Dropdown validation
  dropdownValidator: (row, column, value) {
    if (column == 2 && (value == null || value.isEmpty)) {
      return 'Data wajib diisi';
    }
    return null;
  },

  // Styling
  headerTextStyle: TextStyle(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  ),
  errorTextStyle: TextStyle(fontSize: 8, color: Colors.red),
  cellTextStyle: TextStyle(
    fontSize: 6,
    fontWeight: FontWeight.w600,
  ),
  cellWidth: MediaQuery.of(context).size.width * 0.182,
  cellHeight: MediaQuery.of(context).size.height * 0.04,
  hintTextStyle: TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w400,
  ),
);
```

### FlutterMultiTableController

Main controller class for managing table data and state:

#### Constructor

```dart
FlutterMultiTableController({
  required List<Map> initialData,
  required List headers,
})
```

#### Methods

- `updateCell(int row, int column, String value)`: Updates specific cell value
- `getCellValue(int row, int column)`: Gets value from specific cell
- `setDropdownError(int row, int column, String? error)`: Sets dropdown error message
- `getDropdownError(int row, int column)`: Gets dropdown error message
- `dispose()`: Cleans up resources

### FlutterMultiTableConfig

Configuration class for customizing table appearance and behavior:

```dart
FlutterMultiTableConfig({
  required List headers,
  String hint = "",
  bool Function(int row, int column)? isReadOnly,
  bool Function(int row, int column)? isDropdown,
  List? dropdownOptions,
  void Function(int row, int column, String value)? onChanged,
  String? Function(int row, int column, String value)? validator,
  String? Function(int row, int column, String? value)? dropdownValidator,
  TextStyle? headerTextStyle,
  Color? headerBoxColor,
  TextStyle? cellTextStyle,
  TextStyle? hintTextStyle,
  TextStyle? errorTextStyle,
  TextInputType? textInputType,
  double? cellHeight,
  double? cellWidth,
})
```

### Complete Example

```dart
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
        // return MapEntry(key, value.toString());
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


```

## License

MIT

## Contributing

Pull requests are welcome.
