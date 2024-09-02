import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/expanse_data.dart';
import '../../../models/expanse_item_model.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/validation.dart';

class ExpanseAddingWidget extends StatefulWidget {
  const ExpanseAddingWidget({super.key});

  @override
  State<ExpanseAddingWidget> createState() => _ExpanseAddingWidgetState();
}

class _ExpanseAddingWidgetState extends State<ExpanseAddingWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController newExpenseNameController = TextEditingController();

  TextEditingController newExpenseAmountController = TextEditingController();

  void save() {
    // create expense item
    ExpanseItem newExpanse = ExpanseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now());
    // add the new expense
    Provider.of<ExpanseData>(context, listen: false).addNewExpanse(newExpanse);
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    Navigator.pop(context);
  }

  // cansel function
  void cancel() {
    Navigator.pop(context);
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new expense'),
      actions: [
        // save button
        MyButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Form is valid, proceed with the data
                save();
              }
            },
            child: const Text('Save')),
        // cancel button
        MyButton(onPressed: cancel, child: const Text('Cancel'))
      ],
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expanse name
            MyTextField(
                controller: newExpenseNameController,
                hintText: 'Name',
                hintStyle: const TextStyle(color: Colors.grey),
                validator: Validation().validateName),
            // expanse amount
            MyTextField(
              controller: newExpenseAmountController,
              hintText: 'Amount',
              hintStyle: const TextStyle(color: Colors.grey),
              validator: Validation().validateAmount,
            ),
          ],
        ),
      ),
    );
  }
}
