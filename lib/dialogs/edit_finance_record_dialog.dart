import 'package:finance_tracker/helper/object_box.dart';
import 'package:finance_tracker/main.dart';
import 'package:finance_tracker/model/finance.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

final TextEditingController _financeTitleController = TextEditingController();
final TextEditingController _financeAmountController = TextEditingController();

String _type = "";
String _category = "";
DateTime _date = DateTime.now();

final List<String> _types = ["Income", "Expense"];
final List<String> _categories = ["Food", "Travel", "Salary", "Entertainment", "Groceries", "Rent", "Taxi"];


void _submitForm(BuildContext context, Finance record) {
  record.title = _financeTitleController.text;
  record.amount = double.tryParse(_financeAmountController.text) ?? 0.0;
  record.type = _type;
  record.category = _category;

  objectBox.insertFinanceRecord(record);

  Navigator.of(context).pop();
}


class EditFinanceRecordDialog extends StatefulWidget {

  final Finance record;
  final ObjectBox objectBox;

  @override
  EditFinanceRecordDialog({super.key, required this.record, required this.objectBox});
  


  @override
  _EditFinanceReqcordDialogState createState() => _EditFinanceReqcordDialogState();
}

class _EditFinanceReqcordDialogState extends State<EditFinanceRecordDialog> {

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the record values
    _financeTitleController.text = widget.record.title;
    _financeAmountController.text = widget.record.amount.toString();
    _type = widget.record.type;
    _category = widget.record.category;
    _date = widget.record.date;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: 
            SingleChildScrollView(child: 
            Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Edit finance record",
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _financeTitleController,
                decoration: InputDecoration(
                  labelText: "Input finance title",
                  border: OutlineInputBorder()
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _financeAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: _type,
                decoration: InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
                items: _types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
              ),

              SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),

              ListTile(
                title: Text('Date: ${widget.record.formatDate()}'),
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
                }
              ),
              
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      
                    },
                    child: Text("Cancel")
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red
                      ),
                      onPressed: () {
                        widget.objectBox.deleteFinanceRecord(widget.record.id);
                        Navigator.of(context).pop();
                      },
                    child: Text('Delete')),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm(context, widget.record);
                    },
                    child: Text('Confirm'))
                ]
              )


              ],
            ),),
            
        ),
      ),
    );
  }
}