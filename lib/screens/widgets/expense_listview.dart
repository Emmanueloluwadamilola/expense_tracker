import 'package:expense_tracker/model/expense_data.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ExpenseListView extends StatefulWidget {
  const ExpenseListView({super.key});

  @override
  State<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends State<ExpenseListView> {
  ExpenseProvider? _provider;
  @override
  Widget build(BuildContext context) {
    
    return Consumer<ExpenseProvider>(builder: (context, provider, _) {
      _provider ??= provider;
      final state = provider.state;
     return Expanded(
        child: ListView.separated(
          itemBuilder: ((context, index) {
            return Dismissible(
              key: ValueKey(state.myLIst[index]),
              background: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 3, 3),
                    borderRadius: BorderRadius.circular(5)),
              ),
              onDismissed: (direction) {
                provider.removeExpense(index);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Expense deleted'),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            state.myLIst.insert(
                                index,
                                ExpenseModel(
                                    amount: state.deletedList[0].amount,
                                    category: state.deletedList[0].category,
                                    date: state.deletedList[0].date,
                                    title: state.deletedList[0].title));
                          });
                        }),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                    color: const Color(0xFF212330),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.myLIst[index].title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          '\$${state.myLIst[index].amount}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${categoryText[state.myLIst[index].category]}',
                          style: const TextStyle(
                            color: Color(0xff7B7F9E),
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          state.myLIst[index].formattedDate,
                          style: const TextStyle(
                            color: Color(0xff7B7F9E),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
          itemCount: state.myLIst.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(10);
          },
        ),
      );
    });
  }
}
