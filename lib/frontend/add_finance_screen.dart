import 'package:finance_tracker/backend/finance_cubit.dart';
import 'package:finance_tracker/backend/finance_state.dart';
import 'package:finance_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '/shared/finance_enums.dart';

class AddFinanceScreen extends StatelessWidget {
  const AddFinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinanceCubit(objectBox),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Finance'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FinanceCubit, UpdateFinanceValues>(
            builder: (context, state) {
              final cubit = context.read<FinanceCubit>();

              return ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: state.title,
                    onChanged: cubit.updateTitle,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) =>
                        cubit.updateAmount(double.tryParse(value) ?? 0.0),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<FinanceType>(
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    value: state.type,
                    items: FinanceType.values.map((type) {
                      return DropdownMenuItem<FinanceType>(
                        value: type,
                        child: Text(type.name),
                      );
                    }).toList(),
                    onChanged: (type) => cubit.updateType(type!),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<FinanceCategory>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    value: state.category,
                    items: FinanceCategory.values.map((category) {
                      return DropdownMenuItem<FinanceCategory>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (category) => cubit.updateCategory(category!),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text('Date: ${DateFormat('yyyy-MM-dd').format(state.date.toLocal())}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: state.date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      cubit.updateDate(pickedDate!);
                      },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Perform submission logic here
                      context.read<FinanceCubit>().saveFinance();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Finance saved successfully!')),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
