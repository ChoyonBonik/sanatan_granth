import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/category_entity.dart';

class CategoryChipBar extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const CategoryChipBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final CategoryEntity category = categories[index];
          final bool isSelected = category.name == selectedCategory;

          return ChoiceChip(
            label: Text(category.name),
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                onSelected(category.name);
              }
            },
            labelStyle: AppTypography.englishUi.copyWith(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : null,
            ),
            selectedColor: AppColors.saffronPrimary,
            backgroundColor: Theme.of(context).cardColor,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? AppColors.saffronPrimary
                    : Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
