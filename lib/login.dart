import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_ecommerce/forgot_password.dart';
import 'package:project_ecommerce/home_page.dart';
import 'package:project_ecommerce/register.dart';
import 'package:project_ecommerce/utils/session_manager.dart';

import 'model/model_login.dart';
import 'model/model_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  String? _name;

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('http://192.168.1.112/e-commerce/login.php'),
        body: {
          "login": "1",
          "email": txtEmail.text,
          "password": txtPassword.text,
        },
      );

      if (res.statusCode == 200) {
        ModelLogin data = ModelLogin.fromJson(json.decode(res.body));
        if (data.sukses) {
          if (data.data != null &&
              data.data.id_user != null &&
              data.data.username != null &&
              data.data.fullname != null &&
              data.data.jenis_kelamin != null &&
              data.data.no_hp != null &&
              data.data.alamat != null &&
              data.data.email != null &&
              data.data.created != null &&
              data.data.updated != null &&
              data.data.role != null) {
            sessionManager.saveSession(
              data.status,
              data.data.id_user,
              data.data.username,
              data.data.fullname,
              data.data.jenis_kelamin,
              data.data.no_hp,
              data.data.alamat,
              data.data.email,
              data.data.role,
              data.data.created,
              data.data.updated,
            );

            print('Nilai sesi disimpan:');
            print('ID user: ${data.data.id_user}');
            print('Username: ${data.data.username}');
            print('Email: ${data.data.email}');

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${data.pesan}')));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            throw Exception('Data pengguna tidak lengkap atau null');
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.pesan}')));
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Welcome To Culture Application',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'It\'s great to see you again. Log in to continue your journey.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: keyForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        Container(
                          width: 450,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Email Tidak Boleh kosong"
                                  : null;
                            },
                            controller: txtEmail,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              // fillColor: Colors.white.withOpacity(0.2),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Email',
                              suffixIcon: _name != null && _name!.isNotEmpty
                                  ? Icon(Icons.check, color: Colors.blue)
                                  : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _name = value.trim();
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 450,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Password Tidak Boleh kosong"
                                  : null;
                            },
                            controller: txtPassword,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width - (2 * 98),
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 7,
                              backgroundColor: Color(0xFF00BFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (keyForm.currentState?.validate() == true) {
                                loginAccount();
                              }
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return ForgotPassword();
                                      });
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpScreen()),
                                  );
                                },
                                child: Text(
                                  'Don\'t have an account? Join us',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
