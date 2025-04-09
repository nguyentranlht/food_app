import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/features/app/food_app/order_bloc/order_bloc.dart';
import 'package:itc_food/features/app/food_app/order_bloc/order_event.dart';
import 'package:itc_food/features/app/food_app/order_bloc/order_state.dart';
import 'package:itc_food/router/routers.dart';
import 'package:intl/intl.dart';

class HistoryOrdersScreen extends StatefulWidget {
  const HistoryOrdersScreen({super.key});

  @override
  State<HistoryOrdersScreen> createState() => _HistoryOrdersScreenState();
}

class _HistoryOrdersScreenState extends State<HistoryOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Tải danh sách đơn hàng khi màn hình được khởi tạo
    context.read<OrderBloc>().add(FetchOrdersEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Lịch sử đơn hàng",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.amber[800],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.amber[800],
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: "Chờ xác nhận"),
            Tab(text: "Đang giao"),
            Tab(text: "Đã giao"),
            Tab(text: "Đã hủy"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList("pending"),
          _buildOrderList("delivering"),
          _buildOrderList("completed"),
          _buildOrderList("cancelled"),
        ],
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is OrderError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is OrderLoaded) {
          final orders = state.orders
              .where((order) => order.status == status)
              .toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Không có đơn hàng nào',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () => context.push(RoutesPages.tracking),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Đơn hàng #${order.id.substring(0, 8)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            _buildStatusChip(order.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm').format(order.createdAt),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Địa chỉ: ${order.address}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tổng cộng:",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              "${order.totalPrice.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (match) => '${match[1]},')}đ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.amber[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildStatusChip(String status) {
    String text;
    Color color;
    IconData icon;
    switch (status) {
      case "pending":
        text = "Chờ xác nhận";
        color = Colors.orange;
        icon = Icons.schedule;
        break;
      case "delivering":
        text = "Đang giao";
        color = Colors.blue;
        icon = Icons.local_shipping;
        break;
      case "completed":
        text = "Đã giao";
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case "cancelled":
        text = "Đã hủy";
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        text = "Không xác định";
        color = Colors.grey;
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
} 