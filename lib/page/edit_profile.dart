import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String Name;
  final String PhoneNumber;
  final String address;
  final String Email;

  const MyTextBox({
    Key? key,
    required this.Name,
    required this.PhoneNumber,
    required this.address,
    required this.Email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //will check boxes are empty
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            label: 'Name',
            icon: Icons.person,
            value: Name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFieldWidget(
            label: 'Phone Numeber',
            icon: Icons.phone,
            value: PhoneNumber,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Phone Number';
              }
              return null;
            },
          ),
          TextFieldWidget(
            label: 'Address',
            icon: Icons.home,
            value: address,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          TextFieldWidget(
            label: 'Email',
            icon: Icons.email,
            value: Email,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Email address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final String? Function(String?)? validator; // Add validator property

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text with icon
        TextFormField(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
          ),
          controller: TextEditingController(text: value),
          validator: validator, // Assign validator
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
