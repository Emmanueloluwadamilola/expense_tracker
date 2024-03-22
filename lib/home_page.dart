import 'package:expense_tracker/expense_data.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showSheet() {
    showModalBottomSheet(
        context: context,
        builder: (cxt) {
          return const BottomSheetWidget();
        });
  }

  ExpenseProvider? _provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) {
        _provider ??= provider;
        final state = provider.state;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text(
                'Expense Tracker',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: state.myLIst.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(state.myLIst[index].title),
                          trailing: Text('\$${state.myLIst[index].amount}'),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.myLIst[index].formattedDate),
                              Text(
                                  '${categoryText[state.myLIst[index].category]}')
                            ],
                          ),
                          tileColor: Colors.deepPurple,
                        );
                      }),
                      itemCount: 10,
                    ),
                  )
                : const Center(
                    child: Text(
                      'No expense created',
                      style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: showSheet,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
