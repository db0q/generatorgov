import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _houseNumberControllers = [];
  final List<TextEditingController> _houseStreetControllers = [];
  final List<TextEditingController> _houseGeneratorControllers = [];

  File? _profileImage;

  @override
  void initState() {
    super.initState();
    // Initialize with one house
    _addHouseFields();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    for (var controller in _houseNumberControllers) {
      controller.dispose();
    }
    for (var controller in _houseStreetControllers) {
      controller.dispose();
    }
    for (var controller in _houseGeneratorControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _addHouseFields() {
    setState(() {
      _houseNumberControllers.add(TextEditingController());
      _houseStreetControllers.add(TextEditingController());
      _houseGeneratorControllers.add(TextEditingController());
    });
  }

  void _removeHouseFields(int index) {
    setState(() {
      _houseNumberControllers.removeAt(index);
      _houseStreetControllers.removeAt(index);
      _houseGeneratorControllers.removeAt(index);
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Collect data and save the profile
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving profile...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل الملف الشخصي',
          style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      backgroundColor: Colors.teal,
                      child: _profileImage == null
                          ? const Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'الاسم',
                    labelStyle: GoogleFonts.almarai(),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.fromLTRB(0, 15, 15, 15), // Adjust padding to fit RTL
                  ),
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الاسم';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'رقم الهاتف',
                    labelStyle: GoogleFonts.almarai(),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.fromLTRB(0, 15, 15, 15), // Adjust padding to fit RTL
                  ),
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رقم الهاتف';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'الرجاء إدخال رقم هاتف صالح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ..._houseNumberControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController numberController = entry.value;
                  TextEditingController streetController = _houseStreetControllers[index];
                  TextEditingController generatorController = _houseGeneratorControllers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: numberController,
                                    decoration: InputDecoration(
                                      labelText: 'رقم المنزل ${index + 1}',
                                      labelStyle: GoogleFonts.almarai(),
                                      border: const OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.fromLTRB(0, 15, 15, 15), // Adjust padding to fit RTL
                                    ),
                                    textDirection: TextDirection.rtl,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال رقم المنزل';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: streetController,
                                    decoration: InputDecoration(
                                      labelText: 'شارع المنزل ${index + 1}',
                                      labelStyle: GoogleFonts.almarai(),
                                      border: const OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.fromLTRB(0, 15, 15, 15), // Adjust padding to fit RTL
                                    ),
                                    textDirection: TextDirection.rtl,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال شارع المنزل';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: generatorController,
                                    decoration: InputDecoration(
                                      labelText: 'رقم المولد ${index + 1}',
                                      labelStyle: GoogleFonts.almarai(),
                                      border: const OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.fromLTRB(0, 15, 15, 15), // Adjust padding to fit RTL
                                    ),
                                    textDirection: TextDirection.rtl,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال رقم المولد';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (_houseNumberControllers.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => _removeHouseFields(index),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _addHouseFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Background color
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: Text(
                    'إضافة منزل آخر',
                    style: GoogleFonts.almarai(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    'حفظ',
                    style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
