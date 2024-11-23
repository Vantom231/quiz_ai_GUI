import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/utils/session.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget formInput(TextEditingController controller, bool obscureText, String label, Icon icon) {
      return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 100,
                maxWidth: 300,
                minHeight: 40,
                maxHeight: 50,
              ),
              child: TextField(
                controller: controller,
                    obscureText: obscureText,
                style: const TextStyle(color: AppTheme.white),
                decoration: InputDecoration(
                  labelText: label,
                  prefixIcon: icon,
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.accent, width: 2.0),
                  ),
                ),
              ),
            ),
          );
}

  void handleRegistration() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Hasła się nie zgadzają!"),
          );
        },
      );
      return;
    }

    http.Response response = await Session.post(
      "api/register",
      jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "name": username,
        "password": password,
      }),
    );

    if (response.statusCode == 400) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Nieprawidłowe dane!"),
          );
        },
      );
      return;
    }

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Błąd serwera!"),
          );
        },
      );
      return;
    }

    Navigator.pop(context); // Powrót do ekranu logowania po pomyślnej rejestracji
  }

  Widget _registrationForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Rejestracja",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                  fontSize: 35,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
         formInput(firstNameController, false, "Imię", Icon(Icons.person)),
         formInput(lastNameController, false, "Nazwisko", Icon(Icons.person)),
         formInput(emailController, false, "Email", Icon(Icons.email)),
         formInput(usernameController, false, "Nazwa użytkownika", Icon(Icons.person)),
         formInput(passwordController, true, "Hasło", Icon(Icons.lock)),
         formInput(confirmPasswordController, true, "Potwierdź hasło", Icon(Icons.lock)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton.icon(
            label: const Text(
              "Zarejestruj",
              style: TextStyle(color: AppTheme.white),
            ),
            icon: const Icon(Icons.app_registration),
            iconAlignment: IconAlignment.end,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accent,
            ),
            onPressed: handleRegistration,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Row(
        children: [
          const Expanded(child: Column()),
          Column(
            children: [
              const Expanded(child: Row()),
              Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      maxWidth: 500,
                      minHeight: 100,
                      maxHeight: 600,
                    ),
                    child: _registrationForm(),
                  ),
                ],
              ),
              const Expanded(child: Row()),
            ],
          ),
          const Expanded(child: Column()),
        ],
      ),
    );
  }
}

