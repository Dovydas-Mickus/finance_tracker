import 'package:finance_tracker/model/finance.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/helper/object_box.dart';
import 'package:intl/intl.dart';
final _formKey = GlobalKey<FormState>();



final TextEditingController _financeTitleController = TextEditingController();
final TextEditingController _financeAmountController = TextEditingController();

String _type = "Income";
String _category = "Food";
DateTime _date = DateTime.now();

final List<String> _types = ["Income", "Expense"];
final List<String> _categories = ["Food", "Travel", "Salary", "Entertainment", "Groceries"];

void _submitForm(BuildContext context, ObjectBox objectBox) {
  if (_formKey.currentState!.validate()) {
    String title = _financeTitleController.text;
    double amount = double.tryParse(_financeAmountController.text) ?? 0.0;

    objectBox.insertFinanceRecord(Finance(title: title, amount: amount, type: _type, category: _category, date: _date));

    _financeTitleController.clear();
    _financeAmountController.clear();

    _type = "Income";
    _category = "Food";
    _date = DateTime.now();

    Navigator.of(context).pop();
  }
}

class AddFinanceDialog extends StatefulWidget {
  final ObjectBox objectBox;
  
  @override
  const AddFinanceDialog({super.key, required this.objectBox});

  @override
  _AddFinanceDialogState createState() => _AddFinanceDialogState(objectBox: objectBox);
}

class _AddFinanceDialogState extends State<AddFinanceDialog> {

  String formatDate(DateTime date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(date);
  }
  final ObjectBox objectBox;
  
  _AddFinanceDialogState({required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(child: 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Add a finance record',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20),

              // Title Input Field
              TextFormField(
                controller: _financeTitleController,
                decoration: InputDecoration(
                  labelText: "Input finance title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Amount Input Field
              TextFormField(
                controller: _financeAmountController,
                decoration: InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Type Dropdown
              DropdownButtonFormField<String>(
                value: _type,
                decoration: InputDecoration(
                  labelText: "Type",
                  border: OutlineInputBorder(),
                ),
                items: _types.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Date Picker for selecting the date
              ListTile(
                title: Text('Date: ${formatDate(_date)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _date) {
                    setState(() {
                      _date = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20),

              // Row of Cancel and Confirm buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle confirmation or action
                      _submitForm(context, objectBox); // Call the submit form function
                    },
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
          )
          
        ),
      ),
    );
  }
}
