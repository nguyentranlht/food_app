import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/router/routers.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Tài khoản",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            context.go(RoutesPages.login);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Thông tin người dùng
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/Avatar.png"),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Trần Thanh Nguyên",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "0123456789",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => context.push(RoutesPages.updateProfile),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Các tùy chọn khác
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: "Địa chỉ giao hàng",
                      onTap: () => context.push(RoutesPages.location),
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.notifications_outlined,
                      title: "Thông báo",
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.payment_outlined,
                      title: "Phương thức thanh toán",
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      title: "Cài đặt",
                      onTap: () => context.push(RoutesPages.settings),
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: "Trợ giúp & Phản hồi",
                      onTap: () {},
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Colors.grey[700], size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor ?? Colors.black,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[200]);
  }
}
