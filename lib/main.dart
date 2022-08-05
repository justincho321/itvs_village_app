import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:itvs_village_app/unused_features/image_fetcher.dart';
import 'package:itvs_village_app/youtube_player.dart';
import './image_slider.dart';
import 'package:workmanager/workmanager.dart';
import './video_player.dart';
import 'image_fetcher_2.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    print("Task executing : " + taskName);
    return Future.value(true);
  });
}

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //Workmanager().initialize(callbackDispatcher);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITVS Village Flutter App BETA',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.grey,
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'OpenSans'),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
          //scaffoldBackgroundColor: Colors.grey,
        ),
      ),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final cron = Cron();

  ScheduledTask? scheduledTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'ITVS Village Android-IOS BETA',
            //style:
          ),
          actions: [
            /*
            IconButton(
              icon: const Icon(Icons.list),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.push(
                  context,
                  //test all new features here...
                  MaterialPageRoute(builder: (context) => ParsingWidget2()),
                  //YoutubePlayerPage()),
                );
              },
              tooltip: 'Second Page',
            ),
            */

            //Menu to navigate to different pages demonstrating different features
            PopupMenuButton<int>(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).accentColor,
              ),
              itemBuilder: (context) => [
                // popupmenu item 1
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(Icons.video_camera_back),
                      SizedBox(
                        width: 10,
                      ),
                      Text("MP4 Video"),
                    ],
                  ),
                ),
                // popupmenu item 2
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(Icons.live_tv),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Youtube Video")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: const [
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Fetch Image")
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 100),
              elevation: 2,
              onSelected: (value) {
                // if value 1 navigate to VideoPlayer Page
                if (value == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerApp()));
                  // if value 2 navigate to YouTube Player Page
                } else if (value == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YoutubePlayerPage()));
                } else if (value == 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParsingWidget2()));
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 550, child: PrefetchImage()),
              const Text(
                'Daily Message',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
                //TextStyle(fontSize: 25),
              ),

              /* WORKMANAGER - unused 
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Workmanager().registerOneOffTask(
                          "taskOne",
                          "backup",
                          initialDelay: Duration(seconds: 5),
                          //constraints: Constraints(networkType: NetworkType.connected,)
                        );
                      },
                      child: Text("Run Task")),
                  ElevatedButton(
                      onPressed: () {
                        Workmanager().cancelByUniqueName("taskOne");
                      },
                      child: Text("Cancel Task")),
                ],
              ),
              */
            ],
          ),
        ));
  }

  //workmanager
  @override
  @mustCallSuper
  void initState() {
    Future.delayed(Duration.zero, () {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => scheduleSleep_Wake(context));
    });
  }

// CRON
  void scheduleSleep_Wake(BuildContext context) async {
    scheduledTask = cron.schedule(Schedule.parse("* 20 * * *"), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BlackScreen()));

      print("Executing task : " + DateTime.now().toString());
    });
    scheduledTask = cron.schedule(Schedule.parse("30 8 * * *"), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => _MyHomePage()));

      print("BACK TO NORMAL!");
    });
  }

  void cancelTask() {
    scheduledTask!.cancel();
  }
}

//currently unnused (disconnected)
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back!'),
        ),
      ),
    );
  }
}

//scheduled Sleep/Wakeup
class BlackScreen extends StatelessWidget {
  const BlackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('BLACK SCREEN'),
        ),
      ),
    );
  }
}
