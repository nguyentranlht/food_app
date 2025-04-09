import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "Trần Thanh Nguyên");
  final _phoneController = TextEditingController(text: "0123456789");
  final _emailController = TextEditingController(text: "nguyen@gmail.com");
  final _birthDateController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(2000, 1, 1); // Giá trị mặc định
    _birthDateController.text = _formatDate(_selectedDate!);
    _birthDateController.addListener(_formatDateInput);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _formatDateInput() {
    String text = _birthDateController.text.replaceAll('/', '');
    if (text.length <= 8) {
      String formatted = '';
      for (var i = 0; i < text.length; i++) {
        if (i == 2 || i == 4) {
          formatted += '/';
        }
        formatted += text[i];
      }
      
      if (formatted != _birthDateController.text) {
        _birthDateController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }

      if (_isValidDate(formatted)) {
        final parts = formatted.split('/');
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        setState(() {
          _selectedDate = DateTime(year, month, day);
        });
      }
    }
  }

  void _showNumberPicker(BuildContext context) {
    // Lấy ngày tháng năm hiện tại từ TextField
    DateTime initialDate;
    try {
      if (_isValidDate(_birthDateController.text)) {
        final parts = _birthDateController.text.split('/');
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        initialDate = DateTime(year, month, day);
      } else {
        initialDate = _selectedDate ?? DateTime(2000, 1, 1);
      }
    } catch (e) {
      initialDate = _selectedDate ?? DateTime(2000, 1, 1);
    }

    int selectedDay = initialDate.day;
    int selectedMonth = initialDate.month;
    int selectedYear = initialDate.year;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
                      ),
                      const Text(
                        'Chọn ngày sinh',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
                          _birthDateController.text = _formatDate(_selectedDate!);
                          Navigator.pop(context);
                        },
                        child: const Text('Xong', style: TextStyle(color: Colors.amber)),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: Row(
                      children: [
                        // Ngày
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 31,
                              builder: (context, index) {
                                return Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: selectedDay == index + 1
                                          ? Colors.amber
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedDay = index + 1;
                              });
                            },
                            controller: FixedExtentScrollController(
                              initialItem: (initialDate.day - 1),
                            ),
                          ),
                        ),
                        // Tháng
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 12,
                              builder: (context, index) {
                                return Center(
                                  child: Text(
                                    'Tháng ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: selectedMonth == index + 1
                                          ? Colors.amber
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedMonth = index + 1;
                              });
                            },
                            controller: FixedExtentScrollController(
                              initialItem: (initialDate.month - 1),
                            ),
                          ),
                        ),
                        // Năm
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: DateTime.now().year - 1900 + 1,
                              builder: (context, index) {
                                final year = 1900 + index;
                                return Center(
                                  child: Text(
                                    '$year',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: selectedYear == year
                                          ? Colors.amber
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedYear = 1900 + index;
                              });
                            },
                            controller: FixedExtentScrollController(
                              initialItem: (initialDate.year - 1900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  bool _isValidDate(String input) {
    try {
      final parts = input.split('/');
      if (parts.length != 3) return false;
      
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      
      if (year < 1900 || year > DateTime.now().year) return false;
      if (month < 1 || month > 12) return false;
      if (day < 1 || day > 31) return false;
      
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) return false;
      
      return true;
    } catch (e) {
      return false;
    }
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // TODO: Xử lý cập nhật thông tin
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật thông tin thành công'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Cập nhật thông tin",
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Avatar
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.amber,
                            width: 2,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 48,
                          backgroundImage: AssetImage("assets/images/Avatar.png"),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Form fields
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: "Họ và tên",
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập họ tên';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _birthDateController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: "Ngày sinh",
                          counterText: "",
                          hintText: "dd/mm/yyyy",
                          prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.amber),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.calendar_month, color: Colors.amber),
                              //   onPressed: () => _selectDate(context),
                              // ),
                              IconButton(
                                icon: const Icon(Icons.calendar_month, color: Colors.amber),
                                onPressed: () => _showNumberPicker(context),
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.amber),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập ngày sinh';
                          }
                          if (!_isValidDate(value)) {
                            return 'Ngày sinh không hợp lệ (dd/mm/yyyy)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _phoneController,
                        label: "Số điện thoại",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _emailController,
                        label: "Email",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: ElevatedButton(
          onPressed: _isLoading ? null : _updateProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'Cập nhật',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.amber),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
} 