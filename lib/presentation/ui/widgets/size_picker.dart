import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
    this.title = 'Size',
    this.initialSelected,
  });

  final String title;
  final List<String> sizes;
  final Function(String) onSizeSelected;
  final String? initialSelected;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  late String _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.initialSelected ??
        (widget.sizes.isNotEmpty ? widget.sizes.first : '');
  }

  @override
  void didUpdateWidget(covariant SizePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelected != null &&
        widget.initialSelected != _selectedSize &&
        widget.sizes.contains(widget.initialSelected)) {
      _selectedSize = widget.initialSelected!;
    } else if (_selectedSize.isEmpty && widget.sizes.isNotEmpty) {
      _selectedSize = widget.sizes.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sizes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: widget.sizes.map((item) {
            final bool isSelected = _selectedSize == item;
            return GestureDetector(
              onTap: () {
                _selectedSize = item;
                widget.onSizeSelected(item);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: isSelected ? AppColors.themeColor : null,
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 20,
                    color: isSelected ? Colors.white : null,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
