import 'package:flutter/material.dart';
import 'package:trip_chain/main.dart'; // Import to access AppColors
import 'package:google_fonts/google_fonts.dart';

// Converted to a StatefulWidget to manage form state and controllers
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // A GlobalKey for the Form widget to uniquely identify it and allow validation.
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage the text being edited in the TextFormFields.
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  // Manages the visibility of the password field.
  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed to free up resources.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- VALIDATION LOGIC ---

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address.';
    }
    // Regular expression for validating an email address.
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null; // Return null if the input is valid
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    // Regular expressions to check for character types.
    final hasUpperCase = RegExp(r'[A-Z]');
    final hasLowerCase = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'\d');
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!hasUpperCase.hasMatch(value)) {
      return 'Password must contain an uppercase letter.';
    }
    if (!hasLowerCase.hasMatch(value)) {
      return 'Password must contain a lowercase letter.';
    }
    if (!hasDigit.hasMatch(value)) {
      return 'Password must contain a number.';
    }
    if (!hasSpecialChar.hasMatch(value)) {
      return 'Password must contain a special character.';
    }
    return null; // Return null if the input is valid
  }

  // --- SUBMISSION LOGIC ---

  void _submitForm() {
    // This triggers the validator on every TextFormField in the form.
    // If all validators return null, it returns true.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with login logic.
      final email = _emailController.text;
      final password = _passwordController.text;

      // NOTE: This is where you would make an API call to your backend (e.g., Firebase).
      // For this example, we'll use the hardcoded values.
      if (email == 'karankatakdhond23@gmail.com' && password == 'Test@123') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show an error message if credentials are wrong
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password. Please try again.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // Wrap the column in a Form widget
          child: Form(
            key: _formKey,
            // Autovalidate after the user's first interaction with a field.
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 60.0),
                Center(
                  child: Text(
                    'Trip Chain',
                    style: GoogleFonts.poppins(
                      // Using a modern font
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Icon(
                  Icons.route_outlined,
                  size: 50,
                  color: AppColors.primaryText,
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Login to continue your journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 40.0),

                // Email Field - Changed to TextFormField
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16.0),

                // Password Field - Changed to TextFormField
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordObscured,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    // Add an icon to toggle password visibility
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24.0),

                // Login Button
                ElevatedButton(
                  onPressed: _submitForm, // Call the submit function
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.primaryText,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 24.0),

                // Social Login Options
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(Icons.g_mobiledata),
                    const SizedBox(width: 20),
                    _buildSocialButton(Icons.apple),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color:
                              AppColors.accentRed, // Using a more visible color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for social login buttons
  Widget _buildSocialButton(IconData icon) {
    return InkWell(
      onTap: () {
        // TODO: Implement social login
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.primaryText, size: 24),
      ),
    );
  }
}
