import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 200, // Điều chỉnh chiều cao phù hợp
      child: Stack(
        clipBehavior: Clip.none, // Để phần hình ảnh có thể tràn ra ngoài
        children: [
          // Thẻ chứa nội dung
          Positioned.fill(
            top: 40, // Để tránh hình ảnh bị che mất
            child: Container(
              padding: const EdgeInsets.only(
                top: 50, // Để tránh che phần hình ảnh
                left: 16,
                right: 16,
                bottom: 12,
              ),
              margin: const EdgeInsets.only(
                right: 20,
              ), // Để tránh hình ảnh bị che mất
              decoration: BoxDecoration(
                color: const Color(0x26CEA700),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10), // Khoảng cách từ trên xuống
                  const Text(
                    'Trứng chiên',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF734C10),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.29,
                      letterSpacing: -0.43,
                    ),
                  ),
                  const SizedBox(height: 6), // Khoảng cách giữa các dòng
                  const Text(
                    'Tạo bởi\nTrần Đình Trọng',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF432805),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1.18,
                      letterSpacing: 0.06,
                    ),
                  ),
                  const SizedBox(height: 16), // Khoảng cách đến dòng tiếp theo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '20 phút',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF432805),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          height: 1.18,
                          letterSpacing: 0.06,
                        ),
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            Image(image: AssetImage("assets/images/sticky_note_2.png"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Hình ảnh tròn phía trên
          Positioned(
            top: 0,
            left: 36, // Để căn giữa hình ảnh
            child: Container(
              width: 80,
              height: 80,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Ellipse 1.png"),
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
