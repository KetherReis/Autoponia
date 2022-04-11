import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ava_autoponia/configuration.dart';
import 'package:project_ava_autoponia/screen2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('autoponia').doc(
            'josue').snapshots(),
        builder: (context, snapshot) {
          return AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            duration: const Duration(milliseconds: 250),

            decoration: BoxDecoration(
                color: Colors.grey[200],

                borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)

            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDrawerOpen ? IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        ) : IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,)
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('Rega Automática',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const CircleAvatar()
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.search),
                        Text('Procure por suas plantas favoritas'),
                        Icon(Icons.settings)
                      ],
                    ),
                  ),

                  SizedBox(height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Image.asset(categories[index]['iconPath'],
                                height: 55,
                                width: 55,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(categories[index]['name'],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const Screen2()));
                    },
                    child: Container(
                      height: 260,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: shadowList,
                                  ),
                                  margin: const EdgeInsets.only(top: 50),
                                ),
                                Align(
                                  child: Hero(
                                    tag: 1,
                                    child: Image.network('${snapshot.data?.data()?['url']}'),
                                ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 60, bottom: 20),
                              decoration: BoxDecoration(color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)
                                ),
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 170,
                                        width: 170,
                                        color: Colors.white,
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
                                                              fontSize: 16,
                                                              fontWeight: FontWeight
                                                                  .bold
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          '${snapshot.data?.data()?['subtitle']}',
                                                          style: const TextStyle(
                                                              fontSize: 12
                                                          ),),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .only(bottom: 15),
                                                      child: Text(
                                                        '${snapshot.data?.data()?['mode']}',
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.blue,
                                                            fontWeight: FontWeight
                                                                .bold
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 70,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis
                                                            .horizontal,
                                                        itemCount: detailsPlant
                                                            .length,
                                                        itemBuilder: (context,
                                                            index) {
                                                          return Container(
                                                            decoration: const BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .all(5),
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      left: 16),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      boxShadow: shadowList,
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          10)
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    detailsPlant[index]['iconPath'],
                                                                    height: 30,
                                                                    width: 30,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      left: 16),
                                                                  child: Text(
                                                                    detailsPlant[index]['name'],
                                                                    style: const TextStyle(
                                                                      fontSize: 10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.brown[200],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: shadowList,
                                ),
                                margin: const EdgeInsets.only(top: 50),
                              ),
                              Align(
                                child: Image.asset('images/imag_bonsai.png'),
                              )
                            ],
                          ),
                        ),
                        Expanded(child: Container(
                          margin: const EdgeInsets.only(top: 60, bottom: 20),
                          decoration: BoxDecoration(color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                            ),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 170,
                                    width: 170,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              children: [
                                                const Expanded(
                                                  child: ListTile(
                                                    title: Text("Vaso Bonsai",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                    ),
                                                    subtitle: Text("Pinheiro",
                                                      style: TextStyle(
                                                          fontSize: 12
                                                      ),),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    bottom: 15,),
                                                  child: const Text(
                                                    'Modo Automático',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 70,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    itemCount: detailsBonSai
                                                        .length,
                                                    itemBuilder: (context,
                                                        index) {
                                                      return Container(
                                                        decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets
                                                                  .all(5),
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  left: 16),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: shadowList,
                                                                  borderRadius: BorderRadius
                                                                      .circular(
                                                                      10)
                                                              ),
                                                              child: Image
                                                                  .asset(
                                                                detailsBonSai[index]['iconPath'],
                                                                height: 30,
                                                                width: 30,
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  left: 20),
                                                              child: Text(
                                                                detailsBonSai[index]['name'],
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          );
        },
    );
  }
}
