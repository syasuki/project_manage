
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pro_sche/util/date_extention.dart';
import 'package:pro_sche/view/setting_view.dart';
import 'package:pro_sche/view/todo_add_view.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../calender.dart';
import '../model/todo_model.dart';
import '../provider/provider.dart';


/// Some keys used for testing
final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();



/// The different ways to filter the list of todos
enum TodoListFilter {
  all,
  active,
  completed,
}

final todoTabProvider = StateProvider<int>((ref) => 0);
/// The currently active filter.
final todoListFilter = StateProvider((_) => TodoListFilter.all);

/// The number of uncompleted todos
final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});

/// The list of todos after applying of [todoListFilter].
final filteredTodos = Provider<List<Task>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});
final dateProvider = StateProvider<DateTime>((ref) {
  return DateExtention.dateOnlyNow();
});


class TodoHome extends HookConsumerWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();
    final indexprovider = ref.watch(todoTabProvider);

    var outputFormat = DateFormat('yyyy-MM-dd');

    void onPressedRaisedButton() async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: ref.watch(dateProvider),
          firstDate: new DateTime(2018),
          lastDate: new DateTime.now().add(new Duration(days: 360))
      );
      if (picked != null) {
        ref.read(dateProvider.notifier).state = picked;
      }
    }



    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("リスト",
              style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.grey[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black87,
              ),
              onPressed: () =>{
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Setting()))
              },
            ),
          ],
        ),
        body: Scrollbar(
          child:ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              //const Title(),

              ToggleSwitch(
                minWidth: (MediaQuery.of(context).size.width - 41) / 2,
                minHeight: 25,
                cornerRadius: 20.0,
                activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: indexprovider,
                totalSwitches: 2,
                labels: ['タイムライン表示', '登録順表示'],
                radiusStyle: true,
                onToggle: (index) {
                  //print('switched to: $index');
                  ref.read(todoTabProvider.notifier).state = index!;
                },
              ),

              const SizedBox(height: 20),
              indexprovider == 0 ? Text("a"):TodoList() ,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => {
              // フローティングアクションボタンを押された時の処理.
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const TodoAdd()))
            },
            child: Icon(Icons.add)
        ),
      ),
    );
  }
}
class TodoList extends HookConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final itemFocusNode = useFocusNode();

    return Column(
      children: [
        const Toolbar(),
        if (todos.isNotEmpty) const Divider(height: 0),
        for (var i = 0; i < todos.length; i++) ...[
          if (i > 0) const Divider(height: 0),
          Dismissible(
            key: ValueKey(todos[i].id),
            onDismissed: (_) {
              ref.read(todoListProvider.notifier).remove(todos[i]);
              ref.read(calenderListProvider.notifier).get();
            },
            child: ProviderScope(
              overrides: [
                _currentTodo.overrideWithValue(todos[i]),
              ],
              child: const TodoItem(),
            ),
          )
        ],
      ],
    );
  }
}

class Toolbar extends HookConsumerWidget {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${ref.watch(uncompletedTodosCount)} items left',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: TextButton(
              onPressed: () =>
              ref.read(todoListFilter.notifier).state = TodoListFilter.all,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
              ),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.active,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.active),
                ),
              ),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'todos',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(38, 47, 47, 247),
        fontSize: 100,
        fontWeight: FontWeight.w100,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}

/// A provider which exposes the [Task] displayed by a [TodoItem].
final _currentTodo = Provider<Task>((ref) => throw UnimplementedError());

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    var outputFormat = DateFormat('yyyy-MM-dd');
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            // Commit changes only when the textfield is unfocused, for performance
            ref.read(todoListProvider.notifier)
                .edit(todo,textEditingController.text);
            ref.read(calenderListProvider.notifier).get();
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          title: itemIsFocused
              ? TextField(
            autofocus: true,
            focusNode: textFieldFocusNode,
            controller: textEditingController,
          )
              : Text(todo.description),
          trailing: Text(outputFormat.format(todo.targetDate)),
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(
        () {
      void listener() {
        isFocused.value = node.hasFocus;
      }
      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );

  return isFocused.value;
}