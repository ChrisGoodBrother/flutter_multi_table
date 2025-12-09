/*============================================================
 Summary           :  The module provides the `FlutterMultiTableConfig` class to configure the
 appearance and behavior of a multi-table widget in Flutter. It allows
 developers to define headers, styles, dropdown behavior, read-only conditions,
 and input validations for table cells.

 Functions         :
 - `FlutterMultiTableConfig`: Constructor to initialize configuration options.
 - Callback Functions:
   - `isReadOnly`: Determines if a cell is read-only.
   - `validator`: Validates text input cells.

 Variables         :
 - `headers`: List of column headers.
 - `hint`: Hint text for cells.
 - `isReadOnly`: Callback for read-only cells.
 - `validator`: Validator for text input cells.
 - `dropdownValidator`: Validator for dropdown cells.
 - `headerTextStyle`: Text style for column headers.
 - `headerBoxColor`: Background color for column headers.
 - `cellTextStyle`: Text style for cell text.
 - `hintTextStyle`: Text style for hint text.
 - `errorTextStyle`: Text style for error messages.
 - `textInputType`: Input type for text fields.
 - `cellHeight`: Height of each cell.
 - `cellWidth`: Width of each cell.

 ============================================================*/

part of '../../flutter_multi_table.dart';

/// The `FlutterMultiTableConfig` class is used to configure the table's appearance and behavior.
/// It includes settings for headers, text styles, dropdown options, validators, and more.
class FlutterMultiTableConfig extends ChangeNotifier {
  /// Hint text for cells.
  final String hint;

  bool? isReadOnly;

  void Function(String header)? onRemoveHeader;

  void Function(int row, int column, String? cell)? onUpdateCell;

  /// Validator for text input cells.
  final String? Function(int row, int column, String value)? validator;

  /// Text style for column headers.
  final TextStyle? headerTextStyle;

  /// Background color for column headers.
  final Color? headerBoxColor;

  /// Text style for cell text.
  final TextStyle? cellTextStyle;

  /// Text style for hint text.
  final TextStyle? hintTextStyle;

  /// Text style for error messages.
  final TextStyle? errorTextStyle;

  /// Input type for text fields.
  final TextInputType? textInputType;

  /// Height of each cell.
  final double? cellHeight;

  /// Width of each cell.
  final double? cellWidth;

  /// Constructor for creating an instance of `FlutterMultiTableConfig`.
  ///
  /// This constructor allows setting various table configuration options like headers, dropdown options, text styles, etc.
  ///
  /// For portraits maximum 5 tables.
  FlutterMultiTableConfig({
    this.hint = "",
    this.isReadOnly,
    this.onRemoveHeader,
    this.onUpdateCell,
    this.validator,
    this.headerTextStyle,
    this.headerBoxColor,
    this.cellTextStyle,
    this.hintTextStyle,
    this.errorTextStyle,
    this.textInputType,
    this.cellHeight,
    this.cellWidth,
  });
}
