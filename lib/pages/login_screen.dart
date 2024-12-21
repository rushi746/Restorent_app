// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/pages/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false; // Added loading state

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
             child: Padding(
               padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                 mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                     "Login",
                       style: TextStyle(
                         fontSize: 28.0,
                         fontWeight: FontWeight.bold,
                         color: Colors.blue[700],
                       ),
                   ),
                   const SizedBox(height: 20.0),
                   TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                            prefixIcon: Icon(Icons.person, color: Colors.grey[600],),
                             focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(12.0)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0),
                              borderRadius: BorderRadius.circular(12.0)
                            )
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                     ),
                    const SizedBox(height: 16.0),
                     TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                           focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                             borderRadius: BorderRadius.circular(12.0)
                           ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0),
                              borderRadius: BorderRadius.circular(12.0)
                            )
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                     ),
                   const SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                       child: ElevatedButton(
                            onPressed: _isLoading ? null : () {
                              if (_formKey.currentState!.validate()) {
                                _login(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14.0),
                                backgroundColor:  Colors.blue[700],
                                shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                                : const Text("Login",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    )
                  ],
                ),
              ),
             ),
          ),
        ),
      ),
    );
  }

   Future<void> _login(BuildContext context) async {
     setState(() {
       _isLoading = true; // Start loading
      });
     try {
       final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final String userName = _userNameController.text;
        final String password = _passwordController.text;

      if(userName.isNotEmpty && password.isNotEmpty){
          authProvider.login(userName);
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successfully!'))
          );
      }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Credentials!'))
         );
       }
       } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
  }
}