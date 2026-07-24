import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../data/cav_repository.dart';
import '../models/cav_item.dart';
import '../widgets/adaptive_grid.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_cards.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';
import 'order_screen.dart';

/// Displays the coffee menu and routes users to pickup-order forms.
class CoffeeScreen extends StatefulWidget {
  /// Creates the coffee menu screen.
  const CoffeeScreen({super.key});

  /// Creates the state that manages menu search and category filtering.
  @override
  State<CoffeeScreen> createState() => _CoffeeScreenState();
}

/// Manages the active café menu query and category selection.
class _CoffeeScreenState extends State<CoffeeScreen> {
  final _searchController = TextEditingController();
  CavMenuCategory? _selectedCategory;
  String _query = '';

  /// Releases the search controller owned by the menu screen.
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Updates the active category filter and refreshes the product grid.
  void _selectCategory(CavMenuCategory? category) {
    setState(() => _selectedCategory = category);
  }

  /// Builds the searchable, filterable café menu and pickup entry point.
  @override
  Widget build(BuildContext context) {
    final products = CavRepository.filterCoffeeProducts(
      query: _query,
      category: _selectedCategory,
    );

    return Scaffold(
      appBar: CavAppHeader(
        title: 'Café',
        subtitle: '14 drinks across four menu categories for pickup',
        primaryLabel: 'Order',
        primaryIcon: Icons.shopping_bag_outlined,
        onPrimaryPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) =>
                  OrderScreen(product: CavRepository.coffeeProducts.first),
            ),
          );
        },
      ),
      body: SafeArea(
        child: ResponsiveContent(
          child: ListView(
            padding: const EdgeInsets.only(
              top: CavSpacing.lg,
              bottom: CavSpacing.xl,
            ),
            children: [
              const _CoffeeIntro(),
              const SizedBox(height: CavSpacing.xl),
              const SectionHeader(
                title: 'Café Menu',
                subtitle: 'Browse Classics, Signatures, Matcha, and Soda.',
              ),
              const SizedBox(height: CavSpacing.md),
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  labelText: 'Search café menu',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.local_cafe_outlined),
                ),
              ),
              const SizedBox(height: CavSpacing.sm),
              Wrap(
                spacing: CavSpacing.xs,
                runSpacing: CavSpacing.xs,
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (_) => _selectCategory(null),
                  ),
                  ...CavMenuCategory.values.map(
                    (category) => ChoiceChip(
                      label: Text(category.label),
                      selected: _selectedCategory == category,
                      onSelected: (_) => _selectCategory(category),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: CavSpacing.md),
              if (products.isEmpty)
                const CavSurface(
                  child: Text('No café items match your search.'),
                )
              else
                CavAdaptiveGrid(
                  minItemWidth: 250,
                  children: products
                      .map(
                        (product) => CoffeeProductCard(
                          product: product,
                          onOrder: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => OrderScreen(product: product),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Introduces the cafe pickup service with responsive image and copy layout.
class _CoffeeIntro extends StatelessWidget {
  /// Creates the coffee introduction panel.
  const _CoffeeIntro();

  /// Builds the responsive cafe introduction panel.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      padding: const EdgeInsets.all(CavSpacing.sm),
      color: CavColors.accentSoft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          final copy = Padding(
            padding: const EdgeInsets.all(CavSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Chip(label: Text('Café pickup')),
                const SizedBox(height: CavSpacing.md),
                Text(
                  'Warm drinks, matcha, and sparkling soda.',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: CavSpacing.sm),
                Text(
                  'Choose from the official CAV menu and send a focused pickup request.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );

          if (!wide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CavImage(
                  asset: 'assets/PICS/business/Store.jpg',
                  aspectRatio: 16 / 10,
                  overlay: CavImageOverlay(opacity: 0.12),
                ),
                copy,
              ],
            );
          }

          return Row(
            children: [
              const Expanded(
                child: CavImage(
                  asset: 'assets/PICS/business/Store.jpg',
                  aspectRatio: 16 / 10,
                  overlay: CavImageOverlay(opacity: 0.12),
                ),
              ),
              const SizedBox(width: CavSpacing.sm),
              Expanded(child: copy),
            ],
          );
        },
      ),
    );
  }
}
