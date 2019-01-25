import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(MyApp());

@immutable
class AppState {
  final conter;
  AppState(this.conter);
}

enum Action { Increment }

AppState reducer(AppState prev, action) {
  if (action == Action.Increment) {
    return AppState(prev.conter + 1);
  }
  return prev;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Redux',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Redux app'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final store = Store(reducer, initialState: AppState(0));
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreProvider(
      store: store,
      child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                StoreConnector(
                  converter: (store) => store.state.conter,
                  builder: (context, conter) {
                    Text("$conter");
                  },
                )
              ],
            ),
          ),
          floatingActionButton: StoreConnector(
            converter: (store) {
              return () => store.dispatch(Action.Increment);
            },
            builder: (context, callback) => FloatingActionButton(
                  onPressed: callback,
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
          )),
    );
    ;
  }
}
