import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Theo dõi đơn hàng",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Thông tin đơn hàng
            Container(
              margin: EdgeInsets.all(16.r),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mã đơn hàng: #123456",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "Đang giao",
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildTimelineItem(
                    isCompleted: true,
                    isActive: false,
                    title: "Đã đặt hàng",
                    time: "10:30 AM",
                    description: "Đơn hàng đã được xác nhận",
                    icon: Icons.receipt_outlined,
                  ),
                  _buildTimelineItem(
                    isCompleted: true,
                    isActive: false,
                    title: "Đang chuẩn bị",
                    time: "10:45 AM",
                    description: "Nhà hàng đang chuẩn bị món ăn",
                    icon: Icons.restaurant_outlined,
                  ),
                  _buildTimelineItem(
                    isCompleted: false,
                    isActive: true,
                    title: "Đang giao hàng",
                    time: "11:15 AM",
                    description: "Tài xế đang trên đường giao hàng",
                    icon: Icons.delivery_dining,
                  ),
                  _buildTimelineItem(
                    isCompleted: false,
                    isActive: false,
                    title: "Đã giao hàng",
                    time: "- - : - -",
                    description: "Đơn hàng sẽ được giao trong 15-20 phút",
                    icon: Icons.done_all,
                    isLast: true,
                  ),
                ],
              ),
            ),

            // Danh sách món ăn
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.r),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chi tiết đơn hàng",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildOrderItem(
                    "Phở bò tái nạm",
                    "45.000đ",
                    "2",
                  ),
                  SizedBox(height: 12.h),
                  _buildOrderItem(
                    "Cơm tấm sườn bì chả",
                    "55.000đ",
                    "1",
                  ),
                  SizedBox(height: 12.h),
                  _buildOrderItem(
                    "Trà đào",
                    "25.000đ",
                    "2",
                  ),
                  SizedBox(height: 16.h),
                  const Divider(height: 1),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tạm tính:",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "195.000đ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phí giao hàng:",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "15.000đ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng cộng:",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "210.000đ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Thông tin người giao hàng
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.r),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: const AssetImage("assets/images/Avatar.png"),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nguyễn Văn A",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Tài xế giao hàng",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone,
                          color: Colors.green,
                          size: 24.r,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Địa chỉ giao hàng
            Container(
              margin: EdgeInsets.all(16.r),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ giao hàng",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[600],
                        size: 24.r,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "123 Đường ABC, Phường XYZ, Quận 1, TP.HCM",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, String price, String quantity) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.amber[800]!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            "$quantity x",
            style: TextStyle(
              color: Colors.amber[800],
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: Colors.amber[800],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required bool isCompleted,
    required bool isActive,
    required String title,
    required String time,
    required String description,
    required IconData icon,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green
                      : isActive
                          ? Colors.amber
                          : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isCompleted || isActive ? Colors.white : Colors.grey[500],
                  size: 16.r,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2.w,
                  height: 50.h,
                  color: isCompleted ? Colors.green : Colors.grey[300],
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.amber[800] : Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                if (!isLast) SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 