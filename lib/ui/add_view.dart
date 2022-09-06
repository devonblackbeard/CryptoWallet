import 'package:cryptowallet/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = ["Bitcoin", "Ethereum", "Tether"];

  String dropdownValue = "Bitcoin";
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizedBox(height: 40),
          DropdownButton(
            value: dropdownValue,
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: coins.map<DropdownMenuItem<String>>((String v) {
              return DropdownMenuItem<String>(
                value: v,
                child: Text(v),
              );
            }).toList(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              // keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            width: MediaQuery.of(context).size.width / 1.4,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.pink,
            ),
            child: MaterialButton(
              onPressed: () async {
                // todo
                // Navigate
                await addCoin(dropdownValue, _amountController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          )
        ],
      ),
    );
  }
}
