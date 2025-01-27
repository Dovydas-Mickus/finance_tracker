
import 'package:finance_tracker/frontend/add_finance_screen.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/model/finance.dart';
import 'package:finance_tracker/helper/object_box.dart';
import 'package:finance_tracker/dialogs/edit_finance_record_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final ObjectBox objectBox;
  final Function(ThemeMode) onThemeChange;

  const MyHomePage({
    super.key,
    required this.title,
    required this.objectBox,
    required this.onThemeChange,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  late Stream<List<Finance>> streamFinances;

  @override
  void initState() {
    super.initState();
    streamFinances = widget.objectBox.getFinanceRecords();
  }

  List<double> calculateCurrentBudget(List<Finance> finances) {
    double totalIncome = 0.0;
    double totalExpenses = 0.0;

    for (var finance in finances) {
      if (finance.type == "Income") {
        totalIncome += finance.amount;
      } else if (finance.type == "Expense") {
        totalExpenses += finance.amount;
      }
    }

    return [totalIncome - totalExpenses, totalIncome, totalExpenses];
  }

  Future<void> requestPermissions(BuildContext context) async {
    var status = await Permission.storage.request();

    if (!status.isGranted) {
      print("Permission denied");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required for export')),
      );
      return;
    }
  }


  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _key.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              title: const Text('Change Theme'),
              onTap: () {
                widget.onThemeChange(
                  Theme.of(context).brightness == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light,
                );
              },
            ),
            ListTile(
              title: const Text('Delete All Data'),
              onTap: () {
                // Add confirmation dialog logic here
                widget.objectBox.getBox().removeAll();
              },
            ),
            ListTile(
              title: const Text('Export database'),
              onTap: () {
                requestPermissions(context);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<Finance>>(
        stream: streamFinances,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final finances = snapshot.data!;
          return Column(
            children: [
              Text("Current Budget: ${calculateCurrentBudget(finances)[0].toStringAsFixed(2)}"),
              Text("Total income: ${calculateCurrentBudget(finances)[1].toStringAsFixed(2)}"),
              Text("Total expenses: ${calculateCurrentBudget(finances)[2].toStringAsFixed(2)}"),
              Expanded(
                child: ListView.builder(
                  itemCount: finances.length,
                  itemBuilder: (context, index) {
                    final finance = finances[index];
                    return ListTile(
                      title: Text(finance.title),
                      subtitle: Table(
                        border: TableBorder.symmetric(),
                        children: [
                          TableRow(
                            children: [
                              Padding(padding: EdgeInsets.all(1.0), child: Text(finance.category),),
                              Padding(padding: EdgeInsets.all(1.0), child: Text(finance.type),),
                              Padding(padding: EdgeInsets.all(1.0), child: Text(finance.amount.toString()),),
                              Padding(padding: EdgeInsets.all(1.0), child: Text(finance.formatDate()),),
                            ]
                          )
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditFinanceRecordDialog(
                            record: finance,
                            objectBox: widget.objectBox,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final route = MaterialPageRoute(
            builder: (context) => AddFinanceScreen()
          );
          Navigator.push(context, route);
        },
      ),
    );
  }
}
