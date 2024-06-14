import 'package:flutter/material.dart';
import 'package:project_ecommerce/add_cart.dart';
import 'package:project_ecommerce/buy_now.dart';

class DetailProduct extends StatelessWidget {
  // final Datum? data;

  // const DetailBudaya({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF87CEEB),
          title: Text('Detail Product'),
        ),
        backgroundColor: Color(0xFF87CEEB),
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Image.asset(
                          'images/img2.png',
                          width: 200,
                        ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: data != null && data!.gambar.isNotEmpty
                        //       ? Image.network(
                        //     'http://192.168.1.112/kebudayaan/${data!.gambar}',
                        //     fit: BoxFit.fill,
                        //     width: 200,
                        //     height: 200,
                        //   )
                        //       : Container(),
                        // ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Langit Biru',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // data?.konten ?? 'No Content',
                              'Langit Biru adalah sebuah buku yang menceritakan tentang....',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // data?.judul ?? 'No Title',
                              'Rp. 90.000',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return AddCart();
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min, // Agar Row menyesuaikan dengan ukuran konten
                                children: [
                                  Icon(Icons.shopping_cart, color: Colors.blue), // Mengubah warna ikon menjadi biru
                                  SizedBox(width: 5), // Memberi jarak antara ikon dan teks
                                  Text(
                                    "add to cart",
                                    style: TextStyle(color: Colors.blue), // Mengubah warna teks menjadi biru
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return BuyNow();
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min, // Agar Row menyesuaikan dengan ukuran konten
                                children: [
                                  // Icon(Icons.shopping_cart, color: Colors.blue), // Mengubah warna ikon menjadi biru
                                  SizedBox(width: 5), // Memberi jarak antara ikon dan teks
                                  Text(
                                    "buy now",
                                    style: TextStyle(color: Colors.blue), // Mengubah warna teks menjadi biru
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
