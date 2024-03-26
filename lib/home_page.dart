import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/expense_data.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/widgets/bottom_sheet.dart';
import 'package:expense_tracker/widgets/expense_listview.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final width = MediaQuery.of(context).size.width;
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) {
        _provider ??= provider;
        final state = provider.state;
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xff171822),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: state.myLIst.isEmpty
                    ? const Center(
                        child: Text(
                          'No expense created',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : width < 600
                        ? Column(
                            children: [
                              Chart(expenses: state.myLIst),
                              const ExpenseListView(),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(child: Chart(expenses: state.myLIst)),
                              const Expanded(child: ExpenseListView()),
                            ],
                          )),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF212330),
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
