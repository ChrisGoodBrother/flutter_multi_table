import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_multi_table/flutter_multi_table.dart';

void main() {
  late FlutterMultiTableController controller;
  late FlutterMultiTableConfig config;

  setUp(() {
    // Initialize test data
    List<String> headers = ['No', 'Name', 'Age', 'City', 'Status'];
    List<Map<String, String>> initialData = [
      {
        'No': '1',
        'Name': 'John',
        'Age': '25',
        'City': 'New York',
        'Status': 'Active',
      },
      {
        'No': '2',
        'Name': 'Alice',
        'Age': '30',
        'City': 'London',
        'Status': 'Inactive',
      },
    ];

    controller = FlutterMultiTableController(
      initialData: initialData,
      headers: headers,
    );

    config = FlutterMultiTableConfig(
      headers: headers,
      hint: "Enter value",
      dropdownOptions: ['Active', 'Inactive'],
      isReadOnly: (row, column) => column == 0,
      isDropdown: (row, column) => column == 4,
    );
  });

  tearDown(() {
    controller.dispose();
  });

  group('Controller Tests', () {
    test('initializes with correct data', () {
      expect(controller.tableData.length, 2);
      expect(controller.getCellValue(0, 0), '1');
      expect(controller.getCellValue(0, 1), 'John');
    });

    test('updates cell value correctly', () {
      controller.updateCell(0, 1, 'Jane');
      expect(controller.getCellValue(0, 1), 'Jane');
    });

    test('handles dropdown errors', () {
      controller.setDropdownError(0, 4, 'Invalid status');
      expect(controller.getDropdownError(0, 4), 'Invalid status');

      controller.setDropdownError(0, 4, null);
      expect(controller.getDropdownError(0, 4), null);
    });
  });

  group('Widget Tests', () {
    testWidgets('renders correctly with initial data',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterMultiTable(
              controller: controller,
              config: config,
            ),
          ),
        ),
      );

      // Verify headers are rendered
      expect(find.text('No'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Age'), findsOneWidget);
      expect(find.text('City'), findsOneWidget);
      expect(find.text('Status'), findsOneWidget);

      // Verify initial data is rendered
      expect(find.text('1'), findsOneWidget);
      expect(find.text('John'), findsOneWidget);
    });
  });

  group('Configuration Tests', () {
    test('respects header configuration', () {
      expect(config.headers.length, 5);
      expect(config.headers.first, 'No');
      expect(config.headers.last, 'Status');
    });

    test('handles dropdown options', () {
      expect(config.dropdownOptions, ['Active', 'Inactive']);
    });

    test('correctly identifies readonly cells', () {
      expect(config.isReadOnly!(0, 0), true);
      expect(config.isReadOnly!(0, 1), false);
    });

    test('correctly identifies dropdown cells', () {
      expect(config.isDropdown!(0, 4), true);
      expect(config.isDropdown!(0, 0), false);
    });
  });
}
