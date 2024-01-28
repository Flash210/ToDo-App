


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ret_training/busnisses_logic/cubit/my_cubit.dart';
import 'package:ret_training/data/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<TodoModel> todoList=[];


  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyCubit>(context).emitGetAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Todos Now"),
        
      ),
      body: Column(
        children: [
          BlocBuilder<MyCubit,MyState>(
            builder: (context,state){
              if ( state is GetAllTodos){
                todoList=(state).allTodosList;
                return ListView.builder(
                  shrinkWrap: true ,
                  padding: EdgeInsets.all(8),
                  itemCount: todoList.length,

                  itemBuilder: (BuildContext context,int index){
return Container(
  color: Colors.yellow,
  height: 50,
  child: Center(
    child: Text(todoList[index].title.toString()),
  ),
);
                  },
                );
                

              }else {
                return const CircularProgressIndicator();
              }
            })
        ],
      ),
    );
  }
}