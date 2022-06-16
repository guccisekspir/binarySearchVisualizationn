import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampleflutter/blocs/counterBloc/bloc/counter_bloc.dart';
import 'package:sampleflutter/helpers/sizeHelper.dart';
import 'package:sampleflutter/helpers/themeHelper.dart';
import 'package:sampleflutter/models/binaryNumber.dart';
import 'package:sampleflutter/pages/homePage/widgets/customTextField.dart';
import 'package:sampleflutter/pages/homePage/widgets/titleWidget.dart';

enum HomePageKeys { textFieldKey, generalTextField, startSearchButtonKey }

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      this.currentWillSearchList = const [
        3,
        4,
        6,
        9,
        10,
        12,
        14,
        15,
        17,
        19,
        21,
        25,
        29,
        32,
        35,
        39,
        45,
        49,
        55,
        57,
        59,
        62,
        65,
        68
      ]})
      : super(key: key);
  final List<int> currentWillSearchList;

  @override
  State<HomePage> createState() => HomePageState();
}

@visibleForTesting
class HomePageState extends State<HomePage> {
  bool isClicked = false;
  int counter = 0;
  late CounterBloc counterBloc;

  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();

  late List<int> currentwillSearchList;

  late List<BinaryNumber> currentWillSearchBinaryNumber;

  late int currentMiddle;
  late int currentMinimum;
  late int currentMaximum;
  int? currentResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentwillSearchList = widget.currentWillSearchList;
    counterBloc = BlocProvider.of<CounterBloc>(context);
    currentMiddle = (currentwillSearchList.length / 2).floor();
    currentMinimum = 0;
    currentMaximum = currentwillSearchList.length;
    currentWillSearchBinaryNumber = currentwillSearchList
        .map((int currentValue) => BinaryNumber(
            index: currentwillSearchList.indexOf(currentValue),
            value: currentValue,
            isOnScoped: true,
            isMiddle: currentwillSearchList.indexOf(currentValue) == currentMiddle))
        .toList();

    willSearchTextEditingController = TextEditingController(text: "10");

    //binarySearch(currentwillSearchList, 63);
    // letsMakeSearching();
    //  func1(a, 13);
  }

  late TextEditingController willSearchTextEditingController;
  FocusNode willSearchTextFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: sizeHelper.height,
            width: sizeHelper.width,
            child: Column(
              children: [
                const TitleWidget(title: "Binary Search Flutter Sample"),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      height: sizeHelper.height! * 0.025,
                      width: sizeHelper.height! * 0.025,
                      color: Colors.green,
                    ),
                    const Text(
                      " : Middle Number",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      height: sizeHelper.height! * 0.025,
                      width: sizeHelper.height! * 0.025,
                      color: Colors.blue,
                    ),
                    const Text(
                      " : Result Number",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
                const TitleWidget(title: "Will searched list : "),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(currentwillSearchList.toString()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GeneralTextField(
                        key: const ValueKey(HomePageKeys.generalTextField),
                        iconData: Icons.search,
                        title: "Will Search Number",
                        textFieldKey: const ValueKey(HomePageKeys.textFieldKey),
                        textEditingController: willSearchTextEditingController,
                        context: context,
                        focusNode: willSearchTextFieldFocusNode),
                    ElevatedButton(
                        key: const ValueKey(HomePageKeys.startSearchButtonKey),
                        onPressed: () {
                          //we have to reset if is searched before.
                          steps = [];
                          currentResult = null;
                          willSearchTextFieldFocusNode.unfocus();
                          binarySearch(currentwillSearchList, int.parse(willSearchTextEditingController.text));
                        },
                        child: const Text("Start Search"))
                  ],
                ),
                SizedBox(
                  height: sizeHelper.height! * 0.3,
                  width: sizeHelper.width! * 0.9,
                  child: Center(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: currentWillSearchBinaryNumber.length,
                      itemBuilder: ((context, index) {
                        BinaryNumber currentBinaryNumber = currentWillSearchBinaryNumber[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          // we are looking in there are current index is between
                          // min-max . Main reason is define and visualize focused scope
                          //
                          color: ((currentBinaryNumber.index >= currentMinimum &&
                                  currentBinaryNumber.index <= currentMaximum))
                              ? currentResult != null
                                  ? Colors.transparent
                                  : Colors.amber
                              : Colors.transparent,
                          child: Center(
                            child: AutoSizeText(
                              "${currentBinaryNumber.value} ",
                              style: TextStyle(
                                  // in this conditon we are try to change color
                                  // if is currentResult will be blue color
                                  // if currentResult is not finding yet will be black
                                  // if currentResult is null and currentindex is middle will be green
                                  color: currentResult == currentBinaryNumber.value
                                      ? Colors.blue
                                      : currentResult != null
                                          ? Colors.black
                                          : currentBinaryNumber.index == currentwillSearchList.indexOf(currentMiddle)
                                              ? Colors.green
                                              : Colors.black,
                                  fontSize: 40),
                            ),
                          ),
                        );
                      }),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                    ),
                  ),
                ),
                const TitleWidget(title: "Steps"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: steps.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: SizedBox(
                            height: sizeHelper.height! * 0.05,
                            width: sizeHelper.width,
                            child: AutoSizeText(
                              steps[index],
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      })),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> steps = [];

  Future<int> binarySearch(List<int> integerList, int willSearchNumber) async {
    debugPrint("geldi " + integerList.toString());

    debugPrint("gelmiş " + widget.currentWillSearchList.toString());
    int? result;
    //if given integerList is empty return instantly -1
    if (integerList.isEmpty) {
      steps.add("List is empty, Final result founded : -1");
      setState(() {
        currentResult = -1;
      });
      return -1;
    }
    // if first member of array is higher than searched number
    // that means there areny any equal or lower object
    // so return -1 instantly
    if (integerList[0] > willSearchNumber) {
      steps.add("First number is higher than searched number, Final result founded : -1");
      setState(() {
        currentResult = -1;
      });
      return -1;
    }
    // if last member of array is lower than will search number
    // that means last member less lower number so we will return last member instantly
    if (integerList[integerList.length - 1] < willSearchNumber) {
      steps.add(
          "Last number is lower than searched number, result is last number  Final result founded : ${integerList[integerList.length - 1]}");

      setState(() {
        currentResult = integerList[integerList.length - 1];
      });
      return integerList[integerList.length - 1];
    }

    int low = 0;
    int maximum = integerList.length;
    while (low <= maximum) {
      int middleIndex = ((low + maximum) / 2).floor();
      int middleNumber = integerList[middleIndex];
      setState(() {
        currentMiddle = middleNumber;
      });
      setState(() {
        currentMaximum = maximum;
        currentMinimum = low;
      });
      if (middleNumber == willSearchNumber) {
        steps.add("Middle number is equal to searched number : $middleNumber");
        result = middleNumber;
        break;
      }
      if (middleNumber < willSearchNumber) {
        low = middleIndex + 1;
        result = middleNumber;
        steps.add("Middle number is lower than searched number. New minimum index will set $low");
      } else {
        maximum = middleIndex - 1;
        steps.add("Middle number is higher than searched number. New maximum index will set $maximum");
      }

      await Future.delayed(const Duration(seconds: 1));
    }
    steps.add("Final result founded : $result Result finded in ${steps.length + 1} step");

    setState(() {
      currentResult = result ?? -1;
    });

    return result ?? -1;
  }
}
 /* letsMakeSearching() {
    int result1 = binarySearch(currentwillSearchList, 12);
    debugPrint("12 test case result :" + result1.toString());

    int result2 = binarySearch(currentwillSearchList, 13);
    debugPrint("13 test case result " + result2.toString());

    int result3 = binarySearch(currentwillSearchList, 1);
    debugPrint("1 test case result " + result3.toString());

    int result4 = binarySearch(currentwillSearchList, 24);
    debugPrint("24 test case result " + result4.toString());

    int result5 = binarySearch(currentwillSearchList, 3);
    debugPrint("3 test case result " + result5.toString());

    int result6 = binarySearch(currentwillSearchList, 21);
    debugPrint("21 test case result " + result6.toString());

    int result7 = binarySearch([], 21);
    debugPrint("null array result " + result7.toString());
  }*/
