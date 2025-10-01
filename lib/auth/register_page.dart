import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_midterms/data/user_data.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/screens/home_page.dart';
import '../colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _handleRegister() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final phone = _phoneController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && phone.isNotEmpty) {
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate a unique ID
        name: name,
        email: email,
        password: password,
        phone: phone,
        poin: 0,
        spending: 0,
        xp: 0,
        qrCode: "qr_$email", // Generate QR code based on email
      );
      dummyUsers.add(newUser);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(user: newUser)),
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add, color: AppColors.gold, size: 80),

                const SizedBox(height: 16),
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Sign up to get started",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.white.withAlpha(153),
                  ),
                ),
                const SizedBox(height: 32),

                _buildTextField(Icons.person, "Full Name", _nameController),
                const SizedBox(height: 16),
                _buildTextField(Icons.email, "Email", _emailController),
                const SizedBox(height: 16),
                _buildTextField(Icons.lock, "Password", _passwordController, isPassword: true),
                const SizedBox(height: 16),
                _buildTextField(Icons.lock, "Confirm Password", _confirmPasswordController, isPassword: true),
                const SizedBox(height: 16),
                _buildTextField(Icons.phone, "Phone", _phoneController),

                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 8,
                    shadowColor: AppColors.gold.withAlpha(128),
                  ),
                  onPressed: _handleRegister,
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.white.withAlpha(153),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.gold),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.white.withAlpha(102)),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
