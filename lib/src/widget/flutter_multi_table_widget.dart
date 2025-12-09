/*============================================================
 Summary           : Implementation of a customizable table widget for Flutter
                     using StatelessWidget.

 Functions         :
 - _buildHeaderCell(String text): Builds header cell widget
 - _buildEditableCell(...): Builds editable cell widget
 - _buildTextFieldCell(...): Builds text field cell widget

 Variables         :
 - controller: FlutterMultiTableController for managing table data
 - config: FlutterMultiTableConfig for table customization

 ============================================================*/

part of '../../flutter_multi_table.dart';

/// The `FlutterMultiTable` widget is a customizable table component.
/// It uses `FlutterMultiTableController` to manage the table data and `FlutterMultiTableConfig` to define its configuration.
class FlutterMultiTable extends HookWidget {
  /// Controller for managing table data.
  final FlutterMultiTableController controller;

  /// Configuration object for customizing table appearance and behavior.
  final FlutterMultiTableConfig config;

  /// Constructor for creating a `FlutterMultiTable` widget.
  ///
  /// [controller] is required for managing table data.
  /// [config] is required for defining table appearance and behavior.
  const FlutterMultiTable({
    Key? key,
    required this.controller,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useListenable(controller);

    return Table(
      border: TableBorder.all(),
      columnWidths: {
        for (int i = 0; i < controller.tableHeaders.length; i++)
          i: config.cellWidth != null ? FixedColumnWidth(config.cellWidth!) : const FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: config.headerBoxColor ?? Colors.red,
            shape: BoxShape.rectangle,
          ),
          children: controller.tableHeaders.map((header) => _buildHeaderCell(header)).toList(),
        ),
        ...controller.tableData.asMap().entries.map((entry) {
          int rowIndex = entry.key;
          Map<String, String> row = entry.value;
          return TableRow(
            children: row.entries.map((cellEntry) {
              int columnIndex = controller.tableHeaders.indexOf(cellEntry.key);
              return _buildEditableCell(rowIndex, columnIndex, cellEntry.value);
            }).toList(),
          );
        }),
      ],
    );
  }

  /// Builds a header cell widget.
  ///
  /// [text] is the header text to display.
  Widget _buildHeaderCell(String text) {
    return GestureDetector(
      onLongPress: () {
        if (!(config.isReadOnly ?? true)) {
          config.onRemoveHeader?.call(text);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: config.headerTextStyle ?? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }

  /// Builds an editable cell widget for text or dropdown input.
  ///
  /// [row] is the row index of the cell.
  /// [column] is the column index of the cell.
  /// [controller] is the text controller for the cell.
  Widget _buildEditableCell(int row, int column, String value) {
    bool isReadOnly = config.isReadOnly ?? true;

    return _buildText(row, column, isReadOnly);
  }

  /// Builds a text field cell widget.
  ///
  /// [row] is the row index of the cell.
  /// [column] is the column index of the cell.
  /// [controller] is the text controller for the cell.
  /// [isReadOnly] indicates whether the text field is read-only.
  Widget _buildText(int row, int column, bool isReadOnly) {
    final value = controller.tableData[row][controller.tableData[row].keys.elementAt(column)] ?? "";

    final textController = useState<TextEditingController?>(null);
    final isEditing = useState<bool>(false);

    void addTextField() {
      isEditing.value = true;
      textController.value = TextEditingController(text: value);
    }

    void removeTextField(bool save) {
      if (save) {
        config.onUpdateCell?.call(row, column, textController.value!.text);
      }

      isEditing.value = false;
      //textController.value!.dispose();
      //textController.value = null;
    }

    return GestureDetector(
      onTap: () async {
        if (!(config.isReadOnly ?? true)) {
          addTextField();
        }
      },
      child: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: config.cellHeight ?? 40.0,
                minWidth: config.cellWidth ?? 100.0,
              ),
              child: IntrinsicHeight(
                child: !(isEditing.value)
                    ? Text(
                        value,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: config.cellTextStyle,
                      )
                    : TextField(
                        controller: textController.value,
                        decoration: const InputDecoration(
                          fillColor: Colors.red,
                        ),
                        autofocus: true,
                        onEditingComplete: () => removeTextField(true),
                        onTapOutside: (event) => removeTextField(false),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
