
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/shared/finance_enums.dart';


class UpdateFinanceValues extends Equatable {
  final int id;
  final String title;
  final double amount;
  final FinanceType type;
  final FinanceCategory category;
  final DateTime date;

  UpdateFinanceValues({
    this.id = 0, // Default to 0 if not provided
    this.title = '',
    this.amount = 0,
    this.type = FinanceType.expense,
    this.category = FinanceCategory.entertainment,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  UpdateFinanceValues copyWith({
    int? id,
    String? title,
    double? amount,
    FinanceType? type,
    FinanceCategory? category,
    DateTime? date,
  }) {
    return UpdateFinanceValues(
      id: id ?? this.id, // Preserve or override id
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [id, title, amount, type, category, date]; // Include id in props
}