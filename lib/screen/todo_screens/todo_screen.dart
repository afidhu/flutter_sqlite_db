import 'package:flutter/material.dart';

import '../../controller/controller_todo_provider.dart';
import '../../models/todo_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              color: Colors.red,
            child: TextFormField(
              controller: todoController,
              decoration: InputDecoration(
                hintText: 'Enter todo name',
                hintStyle: TextStyle(color: Colors.white),
                helperText: "Enter todo name",
                suffix: GestureDetector(
                  onTap: (){
                    addTodo(TodoModel(todo: todoController.text)).then((value) => readTodo());
                    setState(() {

                    });
                    todoController.clear();
                  },
                  child: Icon(Icons.send, color: Colors.white,),
                ),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
            )
        ),
      ),
    ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: readTodo(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        var data = snapshot.data![index];
                        return ListTile(
                          leading:CircleAvatar(child: Text("${index+1}"),),
                          title: Text(data['todo'].toString()),
                        );
                      }
                  );
                }
                // else if (snapshot.hasError){
                //   return  Text(snapshot.error.toString());
                // }
                else{
                  return Center(child: Text("No Data"));
                }
              }
          ),
        ),
      ),
    );
  }
}
