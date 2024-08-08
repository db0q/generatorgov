import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:generator/Widgets/homepagewidget.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _loginPhoneController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();
  final TextEditingController _registerPhoneController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _rewritePasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _generatorIdController = TextEditingController();

  int _selectedIndex = 0;

  void _login() {
    if (_loginFormKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  void _register() {
    if (_registerFormKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)], // Two colors for the gradient
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Column(
            children: [
              BottomNavyBar(
                selectedIndex: _selectedIndex,
                showElevation: true,
                onItemSelected: (index) => setState(() {
                  _selectedIndex = index;
                }),
                items: [
                  BottomNavyBarItem(
                    icon: Icon(Icons.login, size: _selectedIndex == 0 ? 24 : 20),
                    title: _selectedIndex == 0 ? const Text('تسجيل الدخول') : const SizedBox.shrink(),
                    activeColor: Colors.teal,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: Icon(Icons.app_registration, size: _selectedIndex == 1 ? 24 : 20),
                    title: _selectedIndex == 1 ? const Text('التسجيل') : const SizedBox.shrink(),
                    activeColor: Colors.teal,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: _selectedIndex == 0
                              ? _buildLoginForm()
                              : _buildRegistrationForm(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _loginPhoneController,
            decoration: InputDecoration(
              labelText: 'رقم الهاتف',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.phone),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال رقم الهاتف';
              }
              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'الرجاء ادخال رقم هاتف صحيح';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _loginPasswordController,
            decoration: InputDecoration(
              labelText: 'كلمة السر',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.lock),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            obscureText: true,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال كلمة السر';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
            ),
            child: Text(
              'تسجيل الدخول',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
              labelText: 'الاسم الكامل',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.person),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال الاسم الكامل';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _registerPhoneController,
            decoration: InputDecoration(
              labelText: 'رقم الهاتف',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.phone),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال رقم الهاتف';
              }
              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'الرجاء ادخال رقم هاتف صحيح';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _registerPasswordController,
            decoration: InputDecoration(
              labelText: 'كلمة السر',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.lock),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            obscureText: true,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال كلمة السر';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _rewritePasswordController,
            decoration: InputDecoration(
              labelText: 'أعد كتابة كلمة السر',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.lock),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            obscureText: true,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال كلمة السر مرة أخرى';
              }
              if (value != _registerPasswordController.text) {
                return 'كلمات السر غير متطابقة';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'العنوان',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.location_on),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال العنوان';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _generatorIdController,
            decoration: InputDecoration(
              labelText: 'رقم المولد',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.numbers),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            style: GoogleFonts.almarai(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال رقم المولد';
              }
              if (!RegExp(r'^\d+$').hasMatch(value)) {
                return 'الرجاء ادخال رقم مولد صحيح';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: _register,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
            ),
            child: Text(
              'التسجيل',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
