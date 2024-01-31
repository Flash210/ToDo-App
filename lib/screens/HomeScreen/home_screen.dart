import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ret_training/busnisses_logic/cubit/my_cubit.dart';
import 'package:ret_training/data/todo_model.dart';
import 'package:ret_training/screens/HomeScreen/widgets/update_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoModel> allTodos = [];
  List<TodoModel> searchedTodos = [];
  bool isSearched = false;
  final searchTextController = TextEditingController();

  Widget buildSearchedField() {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.yellow,
      decoration: InputDecoration(
        hintText: 'find a character ',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      style: TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (searchCharacter) {
        addSearchedItemToList(searchCharacter);
      },
    );
  }

  void addSearchedItemToList(String text) {
    searchedTodos = allTodos
        .where((element) => element.title!.toLowerCase().startsWith(text))
        .toList();

    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearched) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            }, icon: Icon(Icons.clear, color: Colors.grey)),
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              startSearch();
            },
            icon: Icon(Icons.search))
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
        setState(() {
          isSearched=true;
        });
  }

void stopSearching(){
  clearSearch();
  setState(() {
    isSearched=false;
  });
}

void clearSearch(){
  setState(() {
      searchTextController.clear();

    
  });
}

Widget buildAppBarTitle()
{

  return Text("Todos");
}
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyCubit>(context).emitGetAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: isSearched ? buildSearchedField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MyCubit, MyState>(builder: (context, state) {
              if (state is GetAllTodos) {
                allTodos = (state).allTodosList;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount:searchTextController.text.isEmpty ?  allTodos.length :searchedTodos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        color: Colors.yellow,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(searchTextController.text.isEmpty ? 
                                allTodos[index].id.toString() : searchedTodos[index].id.toString())),
                            Expanded(
                                flex: 3,
                                child: Text(searchTextController.text.isEmpty ?
                                allTodos[index].title.toString() : searchedTodos[index].title.toString())),
                            Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: buildCallContainer(
                                          'patch', Colors.redAccent),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        var todoIdToDelete =
                                            allTodos[index].id!;
                                        try {
                                          BlocProvider.of<MyCubit>(context)
                                              .deleteTodo(todoIdToDelete);
                                          setState(() {
                                            allTodos.removeWhere((todo) =>
                                                todo.id == todoIdToDelete);
                                          });
                                          print(
                                              'Todo with ID $todoIdToDelete successfully deleted.');
                                        } catch (e) {
                                          print('Error deleting todo: $e');
                                        }
                                      },
                                      child: buildCallContainer(
                                          'delete', Colors.greenAccent),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateTodoForm()),
                                        );
                                      },
                                      child: buildCallContainer(
                                          'update', Colors.blueAccent),
                                    ),
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

  Container buildCallContainer(String title, MaterialAccentColor redAccent) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: redAccent, borderRadius: BorderRadius.circular(10.0)),
      child: Text(title),
    );
  }
}
