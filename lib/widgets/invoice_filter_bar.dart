import 'package:flutter/material.dart';

class InvoiceFilterBar extends StatefulWidget {
  final void Function(String) onSearchChanged;
  final void Function(DateTime?) onDateSelected;
  final void Function(String?) onStatusChanged;

  final String selectedStatus;
  final DateTime? selectedDate;

  const InvoiceFilterBar({
    super.key,
    required this.onSearchChanged,
    required this.onDateSelected,
    required this.onStatusChanged,
    required this.selectedStatus,
    this.selectedDate,
  });

  @override
  State<InvoiceFilterBar> createState() => _InvoiceFilterBarState();
}

class _InvoiceFilterBarState extends State<InvoiceFilterBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    widget.onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5), // gris clair de fond comme Payment
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              onChanged: widget.onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search invoice...',
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Filters
          Row(
            children: [
              // Date Filter
              Expanded(
                child: InkWell(
                  onTap: pickDate,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          widget.selectedDate == null
                              ? 'Select date'
                              : "${widget.selectedDate!.day}/${widget.selectedDate!.month}/${widget.selectedDate!.year}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Status Filter
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: widget.selectedStatus,
                      items: ['All', 'Paid', 'Pending', 'Overdue']
                          .map(
                            (status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ),
                          )
                          .toList(),
                      onChanged: widget.onStatusChanged,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
