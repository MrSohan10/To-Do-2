import 'package:flutter/material.dart';
import 'package:to_do_app2/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _fromKey2 = GlobalKey<FormState>();
  List<Item> itemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _fromKey,
            child: Expanded(
              flex: 35,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: TextFormField(
                      controller: _controller1,
                      decoration: formFieldStyle("Title", "Enter title"),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Value";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: _controller2,
                      decoration:
                          formFieldStyle("Description", "Enter Description"),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Value";
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        addItem();
                      }
                    },
                    child: Text("Add"),
                    style: elevatedButtonstyle(),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 65,
            child: ListView.separated(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white30,
                  child: ListTile(
                    onLongPress: () {
                      myAlertDialog(index);
                    },
                    leading: CircleAvatar(),
                    title: Text(itemList[index].title),
                    subtitle: Text(itemList[index].descriptions),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(
                height: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  addItem() {
    itemList.add(Item(_controller1.text.trim(), _controller2.text.trim()));
    _controller1.clear();
    _controller2.clear();
    setState(() {});
  }

  myAlertDialog(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        updateItem(index);
                      },
                      child: Text("Edit")),
                  TextButton(
                      onPressed: () {
                        deleteItem(index);
                      },
                      child: Text("Delete")),
                ],
              ),
            ],
          );
        });
  }

  deleteItem(index) {
    itemList.removeAt(index);
    Navigator.pop(context);
    setState(() {});
  }

  updateItem(index) {
    _controller3.text = itemList[index].title;
    _controller4.text = itemList[index].descriptions;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) {
        return Form(
          key: _fromKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Upadate title & details",
                    style: textStyle(),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.clear))
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextFormField(
                  controller: _controller3,
                  decoration: formFieldStyle("Title", "Enter title"),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Value";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextFormField(
                  controller: _controller4,
                  decoration:
                      formFieldStyle("Description", "Enter Description"),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter Value";
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_fromKey2.currentState!.validate()) {
                    itemList[index].title = _controller3.text.trim();
                    itemList[index].descriptions = _controller4.text.trim();
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
                child: Text("Update"),
                style: elevatedButtonstyle(),
              )
            ],
          ),
        );
      },
    );
  }
}

class Item {
  String title;
  String descriptions;

  Item(this.title, this.descriptions);
}
