import 'package:finance_tracker/backend/finance_event.dart';
import 'package:finance_tracker/backend/finance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc() : super(InitialFinanceValues('', 0, FinanceType.expense, FinanceCategory.food, DateTime.now()));

  @override
  Stream<FinanceState> mapEventToState(FinanceEvent event) async* {
    if(event is ChangeName) {
      yield UpdatedFinanceValues(state.title = , amount, type, category, date)
    }
  }
}