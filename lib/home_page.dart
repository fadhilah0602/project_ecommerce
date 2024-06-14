import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecommerce/detail_product.dart';
import 'package:project_ecommerce/favourite_screen.dart';
import 'package:project_ecommerce/profile.dart';
import 'package:project_ecommerce/utils/session_manager.dart';
import 'cart_screen.dart';
import 'edit_profile.dart';
import 'login.dart';
import 'model/model_user.dart';
import 'order_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late ModelUsers currentUser; // Nullable currentUser
  int _selectedIndex = 0;
  bool isLoved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add the observer
    getDataSession(); // Load session data when the widget initializes
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove the observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getDataSession();
    }
  }

  Future<void> getDataSession() async {
    bool hasSession = await sessionManager.getSession();
    if (hasSession) {
      setState(() {
        currentUser = ModelUsers(
          id_user: sessionManager.id_user!,
          username: sessionManager.username!,
          email: sessionManager.email!,
          no_hp: sessionManager.no_hp!,
          fullname: sessionManager.fullname!,
          alamat: sessionManager.alamat!,
          role: sessionManager.role!,
          jenis_kelamin: sessionManager.jenis_kelamin!,
        );
      });
    } else {
      print('Log Session tidak ditemukan!');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
      // Navigasi ke halaman Keranjang
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
        break;
      case 2:
      // Navigasi ke halaman Pesanan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen()),
        );
        break;
      case 3:
      // Navigasi ke halaman Pesanan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavouriteScreen()),
        );
        break;
      case 4:

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(currentUser: currentUser)),
        );
        break;
      // // Tambahkan logika logout
      //   setState(() {
      //     sessionManager.clearSession();
      //     Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               LoginScreen()),
      //           (route) => false,
      //     );
      //   });
        break;
      default:
    }
  }

  Future<void> _refreshData() async {
    // Simulate a long-running operation
    await Future.delayed(Duration(seconds: 2));

    // Fetch new data or update existing data
    // For example, you can fetch data from an API
    setState(() {
      getDataSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFADD8E6),
      // ),
      body: currentUser == null
          ? Center(child: CircularProgressIndicator()) // Show loading indicator if currentUser is null
          : SingleChildScrollView(
        // child: Center(
        //   child: Column(
        //     children: [
        //       Text('Welcome, ${currentUser!.fullname}'),
        //       // Add more widgets related to currentUser
        //     ],
        //   ),
        // ),
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/img_2.png',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Color(0xFFADD8E6),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40, left: 50),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome, ${currentUser!.fullname}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Find Your Book",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25, right: 20),
                        child :IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            icon: Icon(Icons.logout)),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(),
            Positioned(
              top: 120.0,
              left: 40.0,
              right: 40.0,
              child: AppBar(
                elevation: 12,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                // leading: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => FindDoctorPage()));
                //     },
                //     child: Icon(Icons.search)),
                primary: false,
                title: TextField(
                  decoration: InputDecoration(
                      hintText: "Search...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width:80,
                          decoration: BoxDecoration(
                              color: Color(0xFFADD8E6),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Dongeng",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                                // Text("Running")
                            ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 60,
                          width:80,
                          decoration: BoxDecoration(
                              color: Color(0xFFADD8E6),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Biografi",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                                // Text("Ongoing")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 60,
                          width:80,
                          decoration: BoxDecoration(
                              color: Color(0xFFADD8E6),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Pelajaran",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                                // Text("Patient")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width:80,
                          decoration: BoxDecoration(
                              color: Color(0xFFADD8E6),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Komik",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                                // Text("Running")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 60,
                          width:80,
                          decoration: BoxDecoration(
                              color: Color(0xFFADD8E6),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Cerita \nPendek",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                                // Text("Ongoing")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 60,
                          width:80,
                          decoration: BoxDecoration(
                              color: Color(0xFFADD8E6),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Novel",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                                // Text("Patient")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white
                    //   ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoved = !isLoved;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 190, top: 10),
                            // child: Icon(CupertinoIcons.heart_fill,color: Colors.red,),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailProduct()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'images/img1.jpg',
                                  width: 100,
                                ),
                                SizedBox(height: 5,),
                                Text("Datang", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),),
                                SizedBox(height: 5,),
                                Text("Rp. 92.000", style: TextStyle(
                                    color: Colors.blue
                                ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Icon(
                              isLoved ? Icons.favorite : Icons.favorite_border,
                              color: isLoved ? Colors.red : Colors.grey,
                            ),
                          ),
                        ],
                      ),

                    ),

                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoved = !isLoved;
                        });
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 190, top: 10),
                          // child: Icon(CupertinoIcons.heart_fill,color: Colors.red,),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailProduct()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'images/img2.png',
                                width: 100,
                              ),
                              SizedBox(height: 5,),
                              Text("Langit Biru", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              SizedBox(height: 5,),
                              Text("Rp. 90.000", style: TextStyle(
                                  color: Colors.blue
                              ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Icon(
                            isLoved ? Icons.favorite : Icons.favorite_border,
                            color: isLoved ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoved = !isLoved;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 190, top: 10),
                            // child: Icon(CupertinoIcons.heart_fill,color: Colors.red,),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailProduct()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'images/img4.png',
                                  width: 100,
                                ),
                                SizedBox(height: 5,),
                                Text("Pergi", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),),
                                SizedBox(height: 5,),
                                Text("Rp. 90.000", style: TextStyle(
                                    color: Colors.blue
                                ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Icon(
                              isLoved ? Icons.favorite : Icons.favorite_border,
                              color: isLoved ? Colors.red : Colors.grey,
                            ),
                          ),
                        ],
                      ),

                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 190, top: 10),
                    //       // child: Icon(CupertinoIcons.heart_fill,color: Colors.red,),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   EditProfile(currentUser: currentUser)),
                    //         );
                    //       },
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Image.asset(
                    //             'images/img3.png',
                    //             width: 100,
                    //           ),
                    //           SizedBox(height: 5,),
                    //           Text("Pulang", style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 14
                    //           ),),
                    //           SizedBox(height: 5,),
                    //           Text("Rp. 75.000", style: TextStyle(
                    //               color: Colors.blue
                    //           ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        backgroundColor: Color(0xFF87CEEB),
        onTap: _onItemTapped,
      ),
    );
  }
}
