
import 'package:equatable/equatable.dart';

enum FinanceType { income, expense }
enum FinanceCategory {
  food,
  travel,
  salary,
  entertainment,
  groceries,
  rent,
  taxi
}

abstract class FinanceState extends Equatable{}
class UpdateFinanceValues extends FinanceState {
  final String title;
  final double amount;
  final FinanceType type;
  final FinanceCategory category;
  final DateTime date;
  const UpdateFinanceValues({this.title = '', this.amount = 0, this.type = FinanceType.expense, this.category = FinanceCategory.entertainment, this.date = DateTime.now()});

  @override
  List<Object> get props => [title, amount, type, category, date];
  
}