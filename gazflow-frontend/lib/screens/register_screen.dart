import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';
import 'dart:convert';

const String baseURL = 'http://192.168.5.1:8000';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  String role = 'customer';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _agreeToTerms = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 900),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      setState(() => _isLoading = true);
      _formKey.currentState!.save();

      try {
        final url = Uri.parse('$baseURL/auth/register');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "full_name": name,
            "email": email,
            "phone": phone,
            "password": password,
            "password_confirmation": confirmPassword,
            "role": role,
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to Login after delay
          await Future.delayed(Duration(milliseconds: 1500));
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        } else {
          final error = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error['message'] ?? 'Registration failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() => _isLoading = false);
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[500]!, Colors.blue[300]!],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: isSmallScreen ? 8 : 12,
              ),
              child: Column(
                children: [
                  // Custom App Bar
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Join GazFlow",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 48), // Balance the back button
                      ],
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 15 : 25),

                  // Logo and Title Section
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_add_rounded,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: isSmallScreen ? 12 : 16),

                          Text(
                            "Create your account",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 20 : 30),

                  // Register Form Container
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Full Name Field
                            CustomTextField(
                              label: "Full Name",
                              hintText: "Enter your full name",
                              icon: Icons.person_outline,
                              onSaved: (v) => name = v!,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your full name';
                                }
                                if (value!.length < 2) {
                                  return 'Name must be at least 2 characters';
                                }
                                return null;
                              },
                            ),

                            // Email Field
                            CustomTextField(
                              label: "Email Address",
                              hintText: "Enter your email",
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (v) => email = v!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                final emailRegex = RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),

                            // Phone Number Field
                            CustomTextField(
                              label: "Phone Number",
                              hintText: "Enter your phone number",
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              onSaved: (v) => phone = v!,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your phone number';
                                }
                                if (value!.length < 9) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),

                            // Password Field
                            CustomTextField(
                              label: "Password",
                              hintText: "Enter your password",
                              icon: Icons.lock_outline,
                              obscureText: !_isPasswordVisible,
                              onSaved: (v) => password = v!,
                              onChanged: (v) => password = v,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter a password';
                                }
                                if (value!.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),

                            // Confirm Password Field
                            CustomTextField(
                              label: "Confirm Password",
                              hintText: "Confirm your Password",
                              icon: Icons.lock_outline,
                              obscureText: !_isConfirmPasswordVisible,
                              onSaved: (v) => confirmPassword = v!,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please confirm your password';
                                }
                                if (value != password) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),

                            // Role Selection
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "I want to join as",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: _buildRoleCard(
                                        'customer',
                                        'Customer',
                                        Icons.shopping_bag_outlined,
                                        'Order gas bottles',
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildRoleCard(
                                        'driver',
                                        'Driver',
                                        Icons.delivery_dining_outlined,
                                        'Deliver gas bottles',
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildRoleCard(
                                        'store_manager',
                                        'Store Manager',
                                        Icons.store_outlined,
                                        'Manage gas inventory',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 20),

                            // Terms and Conditions
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: _agreeToTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      _agreeToTerms = value ?? false;
                                    });
                                  },
                                  activeColor: Colors.blue[600],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 12),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 13,
                                            height: 1.4,
                                          ),
                                          children: [
                                            TextSpan(text: 'I agree to the '),
                                            TextSpan(
                                              text: 'Terms of Service',
                                              style: TextStyle(
                                                color: Colors.blue[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(text: ' and '),
                                            TextSpan(
                                              text: 'Privacy Policy',
                                              style: TextStyle(
                                                color: Colors.blue[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24),

                            // Register Button
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue[600]!,
                                    Colors.blue[700]!,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child:
                                    _isLoading
                                        ? SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                        : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Create Account",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                              ),
                            ),

                            SizedBox(height: 20),

                            // Sign In Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    String value,
    String title,
    IconData icon,
    String description,
  ) {
    bool isSelected = role == value;

    return GestureDetector(
      onTap: () => setState(() => role = value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue[600]! : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue[600] : Colors.grey[600],
              size: 28,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.blue[600] : Colors.grey[700],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600], fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}