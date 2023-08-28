// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:walletapp/components/expense_tile.dart';
import 'package:walletapp/components/expense_summary.dart';
import 'package:walletapp/data/expense_data.dart';
import 'package:walletapp/models/expense_item.dart';
import 'package:walletapp/util/my_button.dart';
import 'package:walletapp/util/my_card.dart';
import 'package:walletapp/util/my_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController
  final _controller = PageController();
  // TextController
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController(text: '0.0');

  bool _btnActive = false;

  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar nuevo gasto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: 'Nombre',
              ),
              onChanged: (value) {
                setState(() {
                  _btnActive = value.isNotEmpty;
                  print(value.isNotEmpty);
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              controller: newExpenseAmountController,
              decoration: const InputDecoration(
                hintText: 'Cantidad',
              ),
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text('Guardar'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancelar'),
          ),
          // cancel button
        ],
      ),
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpnse(expense);
  }

  // save
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text.isEmpty
            ? '0'
            : newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controlles
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.monetization_on,
            size: 32,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    size: 32,
                    color: Colors.pink[200],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    size: 32,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverSafeArea(
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // AppBar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'My',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' cards',
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                          // Plus button
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),

                    // cards
                    SizedBox(
                      height: 200,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: _controller,
                        children: [
                          MyCard(
                            balance: 5250.20,
                            cardNumber: 12345678,
                            expiryMonth: 10,
                            expiryYear: 26,
                            color: Colors.deepPurple[400],
                          ),
                          MyCard(
                            balance: 520.20,
                            cardNumber: 12345678,
                            expiryMonth: 10,
                            expiryYear: 26,
                            color: Colors.blue[400],
                          ),
                          MyCard(
                            balance: 250.20,
                            cardNumber: 12345678,
                            expiryMonth: 10,
                            expiryYear: 26,
                            color: Colors.green[400],
                          ),
                          MyCard(
                            balance: 525.20,
                            cardNumber: 12345678,
                            expiryMonth: 10,
                            expiryYear: 26,
                            color: Colors.cyan[400],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),

                    SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Colors.grey.shade800,
                      ),
                    ),

                    SizedBox(height: 40),

                    // 3 buttons -> send + pay + bill

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Send Button
                          MyButton(
                            iconImagePath: 'lib/icons/send-money.png',
                            buttonText: 'Send',
                          ),
                          MyButton(
                            iconImagePath: 'lib/icons/credit-card.png',
                            buttonText: 'Pay',
                          ),
                          MyButton(
                            iconImagePath: 'lib/icons/send-money.png',
                            buttonText: 'Bill',
                          ),

                          // Pay Button

                          // Bill Button
                        ],
                      ),
                    ),

                    SizedBox(height: 40),

                    // column -> stats + transactions

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          // Statistics
                          MyListTile(
                            iconImagePath: 'lib/icons/statistics.png',
                            tileTitle: 'Statistics',
                            tileSubTitle: 'Payment and Income',
                          ),
                          MyListTile(
                            iconImagePath: 'lib/icons/transactions.png',
                            tileTitle: 'Transactions',
                            tileSubTitle: 'Transactions Hitory',
                          ),

                          // Transactions
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ExpneseSummary(startOfWeek: value.startOfWeekDay()),
            ),
            SliverList.builder(
              itemCount: value.getAllExpnseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpnseList()[index].name,
                dateTime: value.getAllExpnseList()[index].dateTime,
                amount: value.getAllExpnseList()[index].amount,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpnseList()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
