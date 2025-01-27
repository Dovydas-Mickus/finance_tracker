import 'package:finance_tracker/backend/finance_state.dart';

import '../model/finance_record.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<FinanceRecord> _financeBox;

  ObjectBox._init(this._store) {
    _financeBox = Box<FinanceRecord>(_store);
  }

  static Future<ObjectBox> init() async {
    // Initialize store
    final store = await openStore();
    return ObjectBox._init(store);
  }
  
  /// Fetch a single finance record by ID
  UpdateFinanceValues? getFinanceRecord(int id) {
    final record = _financeBox.get(id);
    return record?.toUpdateFinanceValues(); // Convert to domain model
  }

  void RemoveAllValues() {
    _financeBox.removeAll();
  }

  /// Stream of all finance records, mapped to domain model
  Stream<List<UpdateFinanceValues>> getFinanceRecords() => _financeBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find().map((record) => record.toUpdateFinanceValues()).toList());

  /// Insert or update a finance record
  int insertFinanceRecord(UpdateFinanceValues state) {
    final record = FinanceRecord.fromUpdateFinanceValues(state); // Convert to database model
    return _financeBox.put(record);
  }

  /// Delete a finance record by ID
  bool deleteFinanceRecord(int id) => _financeBox.remove(id);

  /// Expose the raw Box for advanced use if needed
  Box<FinanceRecord> getBox() {
    return _financeBox;
  }

  bool updateFinance(int id, UpdateFinanceValues updatedState) {
  if (id <= 0) {
    throw ArgumentError('Invalid ID value: $id. ID must be greater than 0.');
  }

  final existingRecord = _financeBox.get(id);
  if (existingRecord == null) {
    return false; // No record exists to update
  }

  // Update fields of the existing record
  existingRecord
    ..title = updatedState.title
    ..amount = updatedState.amount
    ..type = updatedState.type.index
    ..category = updatedState.category.index
    ..date = updatedState.date;

  _financeBox.put(existingRecord); // Save the updated record
  return true;
}
}
