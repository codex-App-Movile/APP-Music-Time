import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/Customer/serviceCustomer.dart';

class Profile extends StatefulWidget {
  final String customerId;

  Profile({required this.customerId, required String username});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  bool _isProfileExisting = false;
  bool _isEditing = false; // Start with editing disabled

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final profileData = {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'street': _streetController.text,
        'number': _numberController.text,
        'city': _cityController.text,
        'postalCode': _postalCodeController.text,
        'country': _countryController.text,
      };

      print('Submitting profile data: $profileData'); // Debugging line

      http.Response response;
      if (_isProfileExisting) {
        response = await ServiceCustomer().updateCustomer(widget.customerId, profileData);
      } else {
        response = await ServiceCustomer().createCustomer(profileData);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful profile update or creation
        print('Profile saved successfully');
        setState(() {
          _isEditing = false; // Disable editing after saving
        });
      } else {
        // Handle profile update or creation error
        print('Profile save failed: ${response.body}');
      }
    }
  }

  Future<void> _fetchProfile() async {
    final response = await ServiceCustomer().getCustomerById(widget.customerId);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Fetched profile data: $data'); // Debugging line
      setState(() {
        _firstNameController.text = data['firstName'];
        _lastNameController.text = data['lastName'];
        _emailController.text = data['email'];
        _streetController.text = data['street'];
        _numberController.text = data['number'];
        _cityController.text = data['city'];
        _postalCodeController.text = data['postalCode'];
        _countryController.text = data['country'];
        _isProfileExisting = true;
        _isEditing = false; // Ensure editing is disabled after fetching profile
      });
    } else if (response.statusCode == 404) {
      setState(() {
        _isProfileExisting = false;
        _isEditing = true; // Allow editing if profile does not exist
      });
    } else {
      // Handle error
      print('Failed to load profile: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextFormField('First Name', Icons.person, _firstNameController, enabled: _isEditing),
              SizedBox(height: 20),
              _buildTextFormField('Last Name', Icons.person, _lastNameController, enabled: _isEditing),
              SizedBox(height: 20),
              _buildTextFormField('Email', Icons.email, _emailController, enabled: _isEditing),
              SizedBox(height: 20),
              _buildTextFormField('Street', Icons.home, _streetController, enabled: _isEditing),
              SizedBox(height: 20),
              _buildTextFormField('Number', Icons.home, _numberController, enabled: _isEditing),
              SizedBox(height: 20),
              _buildTextFormField('City', Icons.location_city, _cityController, enabled: _isEditing),
              SizedBox(height: 20),
              _buildTextFormField('Postal Code', Icons.location_on, _postalCodeController, enabled: _isEditing),
              SizedBox(height: 20),
              _buildTextFormField('Country', Icons.flag, _countryController, enabled: _isEditing),
              SizedBox(height: 30),
              if (_isEditing)
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Save Profile', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(String label, IconData icon, TextEditingController controller, {bool enabled = true, bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label, icon),
      style: TextStyle(color: Colors.black87),
      obscureText: obscureText,
      enabled: enabled,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.black87),
      labelStyle: TextStyle(color: Colors.black87),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}