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
  List<TodoModel> todoList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyCubit>(context).emitGetAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos Now"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MyCubit, MyState>(builder: (context, state) {
              if (state is GetAllTodos) {
                todoList = (state).allTodosList;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        color: Colors.yellow,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(todoList[index].id.toString())),
                            Expanded(
                                flex: 3,
                                child: Text(todoList[index].title.toString())),

                            Expanded(flex:3, child:Row(
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Text('Path'),
                                )
                              ],
                            )),
                          ],
                        ));
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            })
          ],
        ),
      ),
    );
  }
}
