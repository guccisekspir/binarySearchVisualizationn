import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampleflutter/blocs/counterBloc/bloc/counter_bloc.dart';
import 'package:sampleflutter/helpers/sizeHelper.dart';
import 'package:sampleflutter/helpers/themeHelper.dart';
import 'package:sampleflutter/pages/homePage/homePage.dart';

class LandPage extends StatefulWidget {
  const LandPage({Key? key}) : super(key: key);

  @override
  State<LandPage> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ThemeHelper(fetchedContext: context);
      SizeHelper(fetchedContext: context);

      setState(() {
        isInit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInit
        ? BlocProvider(
            create: (context) => CounterBloc(),
            child: HomePage(),
          )
        : CircularProgressIndicator();
  }
}
