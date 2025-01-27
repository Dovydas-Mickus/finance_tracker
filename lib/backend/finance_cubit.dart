import 'package:finance_tracker/backend/finance_state.dart';
import 'package:finance_tracker/helper/object_box.dart';
import 'package:finance_tracker/model/finance_record.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/shared/finance_enums.dart';

class FinanceCubit extends Cubit<UpdateFinanceValues> {
  final ObjectBox objectBox;

  FinanceCubit(this.objectBox)
      : super(
          UpdateFinanceValues(
            title: '',
            amount: 0.0,
            type: FinanceType.expense,
            category: FinanceCategory.entertainment,
            date: DateTime.now(),
          ),
        );

  // Update the title
  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  // Update the amount
  void updateAmount(double amount) {
    emit(state.copyWith(amount: amount));
  }

  // Update the type
  void updateType(FinanceType type) {
    emit(state.copyWith(type: type));
  }

  // Update the category
  void updateCategory(FinanceCategory category) {
    emit(state.copyWith(category: category));
  }

  // Update the date
  void updateDate(DateTime date) {
    emit(state.copyWith(date: date));
  }

  void saveFinance() {
    objectBox.insertFinanceRecord(state);
  }

  // Fetch all records from ObjectBox
  Stream<List<UpdateFinanceValues>> fetchAllFinances() {
    return objectBox.getFinanceRecords();
  }

  // Delete a record from ObjectBox
  void deleteFinance(int id) {
    objectBox.deleteFinanceRecord(id);
  }

  void loadFinanceRecord(FinanceRecord record) {
    emit(
      UpdateFinanceValues(
        title: record.title,
        amount: record.amount,
        type: FinanceType.values[record.type],
        category: FinanceCategory.values[record.category],
        date: record.date,
      ),
    );
  }
  void updateFinance(FinanceRecord record) {
  // Convert the FinanceRecord to UpdateFinanceValues
  final updatedState = record.toUpdateFinanceValues();

  // Call the ObjectBox updateFinance method
  final success = objectBox.updateFinance(record.id, updatedState);

  if (success) {
    print('Finance record updated successfully!');
  } else {
    print('Failed to update. Record with ID ${record.id} not found.');
  }
}

}
