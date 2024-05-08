import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';

import '../../imports/index.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final randomNumbers = Stream.periodic(
        const Duration(seconds: 1),
        (_) => [
              Random().nextInt(900) + 100,
              Random().nextInt(900) + 100,
              Random().nextInt(900) + 100,
              Random().nextInt(900) + 100,
              Random().nextInt(900) + 100,
              Random().nextInt(900) + 100,
            ]);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Realtime Data',
            style: Style.textStyles.primary(
              color: Style.colors.primaryDart,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: StreamBuilder<List<int>>(
          stream: randomNumbers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final int v1aPrevious = snapshot.hasData
                  ? int.parse(snapshot.data![0].toString())
                  : 0;
              final int v1bPrevious = snapshot.hasData
                  ? int.parse(snapshot.data![1].toString())
                  : 0;
              final int v1cPrevious = snapshot.hasData
                  ? int.parse(snapshot.data![2].toString())
                  : 0;

              final int v2aPrevious = snapshot.hasData ? snapshot.data![1] : 0;
              final int v2bPrevious = snapshot.hasData ? snapshot.data![2] : 0;
              final int v2cPrevious =
                  snapshot.hasData ? snapshot.data![2] + 100 : 0;

              final v1a = snapshot.data![0].toString().padLeft(3, '0');
              final v2a = snapshot.data![1].toString().padLeft(3, '0');
              final currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

              final v1b = snapshot.data![2].toString().padLeft(3, '0');
              final v2b =
                  snapshot.data![3].toString().padLeft(3, '0'); // Use index 3

              final v1c =
                  snapshot.data![4].toString().padLeft(3, '0'); // Use index 4
              final v2c = snapshot.data![0].toString().padLeft(3, '0');

              Color v1aColor = Colors.grey;
              Color v1bColor = Colors.grey;
              Color v1cColor = Colors.grey;

              Color v2aColor = Colors.grey;
              Color v2bColor = Colors.grey;
              Color v2cColor = Colors.grey;

              if (snapshot.hasData) {
                v1aColor =
                    int.parse(v1a) > v1aPrevious ? Colors.green : Colors.red;
                v1bColor =
                    int.parse(v1b) > v1bPrevious ? Colors.green : Colors.red;
                v1cColor =
                    int.parse(v1c) > v1cPrevious ? Colors.green : Colors.red;

                v2aColor =
                    int.parse(v2a) < v2aPrevious ? Colors.green : Colors.red;
                v2bColor =
                    int.parse(v2b) < v2bPrevious ? Colors.green : Colors.red;
                v2cColor =
                    int.parse(v2c) < v2cPrevious ? Colors.green : Colors.red;
              }

              return GridView.count(
                crossAxisCount: 4,
                children: <Widget>[
                  _buildGridTile('Symbol'),
                  _buildGridTile('v1'),
                  _buildGridTile('v2'),
                  _buildGridTile('Time'),
                  _buildGridTile('a', empty: false),
                  _buildGridTile(v1a, empty: true, color: v1aColor),
                  _buildGridTile(v2a, empty: true, color: v2aColor),
                  _buildGridTile(currentTime, empty: true),
                  _buildGridTile('b', empty: false),
                  _buildGridTile(v1b, empty: true, color: v1bColor),
                  _buildGridTile(v2b, empty: true, color: v2bColor),
                  _buildGridTile(currentTime, empty: true),
                  _buildGridTile('c', empty: false),
                  _buildGridTile(v1c, empty: true, color: v1cColor),
                  _buildGridTile(v2c, empty: true, color: v2cColor),
                  _buildGridTile(currentTime, empty: true),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildGridTile(String text,
      {bool empty = false, Color color = Colors.black}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(),
        color:
            empty ? Colors.transparent : Style.colors.primary.withOpacity(0.5),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
