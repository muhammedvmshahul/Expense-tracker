import 'package:expense_tracker_app/components/expense_summery.dart';
import 'package:expense_tracker_app/components/expense_tile.dart';
import 'package:expense_tracker_app/models/expanse_item_model.dart';
import 'package:expense_tracker_app/pages/homeScreen/widgets/expanse_adding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/expanse_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // delete
  void deleteExpense(ExpanseItem expense){
    Provider.of<ExpanseData>(context,listen: false).deleteExpanse(expense);
  }
  void addNewExpanse() {
    // add new expense
    showDialog(
        context: context, builder: (context) => const ExpanseAddingWidget());
  }

  @override
  @override
  void initState() {
    super.initState();
    Provider.of<ExpanseData>(context,listen: false).prepareData();
  }
  Widget build(BuildContext context) {
    return Consumer<ExpanseData>(
        builder: (context, value, child) => SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade100,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: addNewExpanse,
                  child: const Icon(Icons.add,color: Colors.white,),
                ),
                body: ListView(
                  children: [
                    ExpenseSummery(startOfWeek: value.startOfWeekDate()),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.getAllExpanseList().length,
                      itemBuilder: (context, index) => ExpenseTil(
                        name: value.getAllExpanseList()[index].name,
                        amount: value.getAllExpanseList()[index].amount,
                        dateTime: value.getAllExpanseList()[index].dateTime,
                        deleteTapped: (p0)=>value.deleteExpanse(value.getAllExpanseList()[index]),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
