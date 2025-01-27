import 'package:finance_tracker/backend/finance_state.dart';
import 'package:objectbox/objectbox.dart';
import 'package:finance_tracker/shared/finance_enums.dart';

@Entity()
class FinanceRecord {
  @Id(assignable: true) // Ensure ObjectBox manages `id` automatically
  int id;
  String title;
  double amount;
  int type; // Store as an integer
  int category; // Store as an integer
  DateTime date;

  FinanceRecord({
    this.id = 0, // Default to 0 for new records (ObjectBox will assign a value)
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  // Convert to domain model
  UpdateFinanceValues toUpdateFinanceValues() {
    return UpdateFinanceValues(
      id: id,
      title: title,
      amount: amount,
      type: FinanceType.values[type],
      category: FinanceCategory.values[category],
      date: date,
    );
  }

  // Convert from domain model
  factory FinanceRecord.fromUpdateFinanceValues(UpdateFinanceValues state) {
    return FinanceRecord(
      id: state.id,
      title: state.title,
      amount: state.amount,
      type: state.type.index,
      category: state.category.index,
      date: state.date,
    );
  }
}
