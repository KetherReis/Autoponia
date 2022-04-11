import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_ava_autoponia/configuration.dart';
import 'package:project_ava_autoponia/edit_screen.dart';

import 'components/custom_button.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('autoponia').doc(
        'josue').snapshots(),
    builder: (context, snapshot) {
      return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.blueGrey[300],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back_ios), onPressed: () {
                      Navigator.pop(context);
                    }),
                    IconButton(icon: const Icon(Icons.share), onPressed: () {})
                  ],
                ),
              ),
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Hero(
                    tag: 1,
                    child: Image.network('${snapshot.data?.data()?['url']}'
                    )),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 110,
                width: 400,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowList,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 7.0,
                      percent: 0.35,
                      center: const Icon(
                        Icons.water_drop,
                        size: 35.0,
                        color: Colors.blue,
                      ),
                      footer: const Text("Umidade"),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 7.0,
                      percent: 0.89,
                      center: const Icon(
                        Icons.health_and_safety,
                        size: 35.0,
                        color: Colors.green,
                      ),
                      footer: const Text("Saúde"),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 5.0,
                      percent: 0.65,
                      center: const Icon(
                        Icons.wb_sunny,
                        size: 35.0,
                        color: Colors.yellow,
                      ),
                      footer: const Text("Luz Solar"),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.yellow,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 500,),
              child: Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 240,
                        width: 400,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                     Expanded(
                                      child: ListTile(
                                        title: Text('${snapshot.data?.data()?['title']}',
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        subtitle: Text('${snapshot.data?.data()?['subtitle']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      margin: const EdgeInsets.symmetric(horizontal: 20),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                      '${snapshot.data?.data()?['description']}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Icon(Icons.shower,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(color: primaryGreen,
                            borderRadius: BorderRadius.circular(20)),
                        child: CustomButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditScreen()));
                          },
                          text: 'Editar Informações',
                          textSize: 18,

                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),)
                ),
              ),
            ),
          ],
        ),
      );
    },
      );
  }
}
