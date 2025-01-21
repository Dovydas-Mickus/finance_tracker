import '../model/finance.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Finance> _financeBox;

  ObjectBox._init(this._store) {
    _financeBox = Box<Finance>(_store);
  }

  static Future<ObjectBox> init() async {
    // Initialize store without sync
    final store = await openStore();
    return ObjectBox._init(store);
  }

  Finance? getFinanceRecord(int id) => _financeBox.get(id);

  Stream<List<Finance>> getFinanceRecords() => _financeBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  int insertFinanceRecord(Finance finance) => _financeBox.put(finance);

  bool deleteFinanceRecord(int id) => _financeBox.remove(id);

  Box<Finance> getBox() {
    return _financeBox;
  }
}
