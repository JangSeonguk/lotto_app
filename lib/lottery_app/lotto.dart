import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_app/lottery_app/dialog.dart';
import 'package:login_app/lottery_app/lotto_ball.dart';
import 'package:lottie/lottie.dart';

class Lotto extends StatefulWidget {
  const Lotto({super.key});

  @override
  State<Lotto> createState() => _LottoState();
}

class _LottoState extends State<Lotto> {
  List<List<int>> listLottery = [];
  final Random _random = Random();

  void _createNumber() {
    if (listLottery.length < 15) {
      setState(() {
        List<int> lottery = [];
        while (true) {
          var rnd = _random.nextInt(45) + 1;
          if (!lottery.contains(rnd)) {
            lottery.add(rnd);
          }
          if (lottery.length == 6) {
            break;
          }
        }
        lottery.sort();
        listLottery.add(lottery);
      });
    } else {
      Fluttertoast.showToast(
        msg: "15번까지만 생성이 가능합니다.",
      );
    }
  }

  void showPopup(context, String title, String number) {
    showDialog(
        context: context,
        builder: (context) {
          return PopupDialog(title2: title, number2: number);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 125, 198),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: RawScrollbar(
                thumbColor: Colors.grey,
                trackColor: Colors.grey[700],
                trackVisibility: true,
                thickness: 15,
                radius: const Radius.circular(10),
                interactive: true,
                child: ListView.builder(
                  itemCount: listLottery.length,
                  itemBuilder: (BuildContext context, int index) {
                    int currentIndex = index + 1;
                    var path_1 = 'svg/${listLottery[index][0]}.svg';
                    var path_2 = 'svg/${listLottery[index][1]}.svg';
                    var path_3 = 'svg/${listLottery[index][2]}.svg';
                    var path_4 = 'svg/${listLottery[index][3]}.svg';
                    var path_5 = 'svg/${listLottery[index][4]}.svg';
                    var path_6 = 'svg/${listLottery[index][5]}.svg';
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("$currentIndex번째 추첨 번호"),
                        subtitle: Scrollbar(
                          trackVisibility: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                LottoBall(path: path_1),
                                const SizedBox(
                                  width: 2,
                                ),
                                LottoBall(path: path_2),
                                const SizedBox(
                                  width: 2,
                                ),
                                LottoBall(path: path_3),
                                const SizedBox(
                                  width: 2,
                                ),
                                LottoBall(path: path_4),
                                const SizedBox(
                                  width: 2,
                                ),
                                LottoBall(path: path_5),
                                const SizedBox(
                                  width: 2,
                                ),
                                LottoBall(path: path_6),
                              ],
                            ),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.summarize_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          showPopup(context, currentIndex.toString(),
                              listLottery[index].toString());
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset('lottie/cat.json'),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(children: [
        Positioned(
          right: MediaQuery.of(context).orientation == Orientation.portrait
              ? 10
              : 76,
          bottom: MediaQuery.of(context).orientation == Orientation.portrait
              ? 66
              : 6,
          child: FloatingActionButton(
            heroTag: 'button1',
            tooltip: "Another number set",
            backgroundColor: Colors.black,
            onPressed: _createNumber,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 6,
          child: FloatingActionButton(
            heroTag: 'button2',
            tooltip: "Clear numbers",
            backgroundColor: Colors.black,
            onPressed: () {
              setState(() {
                listLottery.clear();
              });
            },
            child: const Icon(
              Icons.refresh_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
