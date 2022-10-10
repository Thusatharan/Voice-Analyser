import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_note/constants/app_colors.dart';
import 'package:rapid_note/constants/concave_decoration.dart';
import 'package:rapid_note/constants/recorder_constants.dart';
import 'package:rapid_note/screens/home_screen/cubit/record/record_cubit.dart';
import 'package:rapid_note/screens/home_screen/widgets/audio_visualizer.dart';
import 'package:rapid_note/screens/home_screen/widgets/mic.dart';
import 'package:rapid_note/screens/recordings_list/cubit/files/files_cubit.dart';
import 'package:rapid_note/screens/recordings_list/view/recordings_list_screen.dart';

class MaleOrFemale extends StatefulWidget {
  const MaleOrFemale({Key? key}) : super(key: key);

  @override
  State<MaleOrFemale> createState() => _MaleOrFemaleState();
}

class _MaleOrFemaleState extends State<MaleOrFemale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BlocBuilder<RecordCubit, RecordState>(
        builder: (context, state) {
          if (state is RecordStopped || state is RecordInitial) {
            return SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                appTitle(),
                Spacer(),
                NeumorphicMic(onTap: () {
                  context.read<RecordCubit>().startRecording();
                }),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => new AlertDialog(
                              title: new Text('Result'),
                              content: new Text(
                                'MALE VOICE',
                                style: TextStyle(
                                    color: AppColors.highlightColor,
                                    fontSize: 25),
                              ),
                              actions: <Widget>[
                                new IconButton(
                                    icon: new Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ));
                  },
                  child: myNotes(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.highlightColor),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ));
          } else if (state is RecordOn) {
            return SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                appTitle(),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    StreamBuilder<double>(
                        initialData: RecorderConstants.decibleLimit,
                        stream: context.read<RecordCubit>().aplitudeStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AudioVisualizer(amplitude: snapshot.data);
                          }
                          if (snapshot.hasError) {
                            return Text(
                              'Visualizer failed to load',
                              style: TextStyle(color: AppColors.accentColor),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                    Spacer(),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.read<RecordCubit>().stopRecording();

                    ///We need to refresh [FilesState] after recording is stopped
                    context.read<FilesCubit>().getFiles();
                  },
                  child: Container(
                    decoration: ConcaveDecoration(
                      shape: CircleBorder(),
                      depression: 10,
                      colors: [
                        AppColors.highlightColor,
                        AppColors.shadowColor,
                      ],
                    ),
                    child: Icon(
                      Icons.stop,
                      color: AppColors.accentColor,
                      size: 50,
                    ),
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ));
          } else {
            return Center(
                child: Text(
              'An Error occured',
              style: TextStyle(color: AppColors.accentColor),
            ));
          }
        },
      ),
    );
  }

  Text myNotes() {
    return Text(
      'DETECT MALE / FEMALE',
      style: TextStyle(
          color: AppColors.accentColor,
          fontSize: 20,
          letterSpacing: 5,
          shadows: [
            Shadow(
                offset: Offset(3, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2)),
          ]
          //decoration: TextDecoration.underline,
          ),
    );
  }

  Widget appTitle() {
    return Text(
      'Male/Female',
      style: TextStyle(
          color: AppColors.accentColor,
          fontSize: 40,
          letterSpacing: 5,
          fontWeight: FontWeight.w200,
          shadows: [
            Shadow(
                offset: Offset(3, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2)),
          ]),
    );
  }

  Route _customRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) =>
          RecordingsListScreen(),
    );
  }
}
