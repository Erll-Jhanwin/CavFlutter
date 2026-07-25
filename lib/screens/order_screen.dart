import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/design_tokens.dart';
import '../models/cav_item.dart';
import '../utils/form_validators.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';
import 'summary_screen.dart';

const _coffeeAddOns = [
  CoffeeAddOn(id: 'extra-shot', name: 'Extra espresso shot', priceInPesos: 25),
  CoffeeAddOn(id: 'oat-milk', name: 'Oat milk', priceInPesos: 20),
  CoffeeAddOn(id: 'whipped-cream', name: 'Whipped cream', priceInPesos: 15),
];

/// Collects customer details and a pickup slot for a coffee product.
class OrderScreen extends StatefulWidget {
  /// Creates an order form for [product].
  const OrderScreen({super.key, required this.product});

  final CoffeeProduct product;

  /// Creates the state that owns form controllers and order selections.
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

/// Manages order input state, quantity bounds, validation, and navigation.
class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _notesController = TextEditingController();

  late DateTime _pickupDate = DateTime.now();
  TimeOfDay _pickupTime = const TimeOfDay(hour: 10, minute: 30);
  int _quantity = 1;
  final Set<String> _selectedAddOnIds = <String>{};

  /// Releases all text controllers owned by the order form.
  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  /// Opens a date picker constrained to today through the next 30 days.
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _pickupDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (picked == null || !mounted) return;
    setState(() => _pickupDate = picked);
  }

  /// Opens a time picker and stores the selected pickup time.
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _pickupTime,
    );
    if (picked == null || !mounted) return;
    setState(() => _pickupTime = picked);
  }

  /// Validates the form, creates a summary, and opens its confirmation screen.
  void _submit() {
    // Do not construct or navigate to a summary until every required field passes.
    if (!_formKey.currentState!.validate()) return;

    final selectedAddOns = _selectedAddOns;
    final summary = OrderSummary(
      productName: widget.product.name,
      customerName: _nameController.text.trim(),
      contactNumber: _contactController.text.trim(),
      pickupDate: _pickupDate,
      pickupTime: _pickupTime,
      quantity: _quantity,
      addOns: selectedAddOns,
      subtotalInPesos: _subtotalInPesos,
      totalInPesos: _totalInPesos,
      notes: _notesController.text.trim(),
      imageAsset: widget.product.imageAsset,
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => OrderSummaryScreen(summary: summary),
      ),
    );
  }

  /// Builds the product preview, order fields, and submit action.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CavAppHeader(
        title: 'Café Pickup Order',
        subtitle: widget.product.name,
      ),
      body: SafeArea(
        child: ResponsiveContent(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(
                top: CavSpacing.lg,
                bottom: CavSpacing.xl,
              ),
              children: [
                CavSurface(
                  padding: const EdgeInsets.all(CavSpacing.sm),
                  color: CavColors.accentSoft,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 680;
                      final details = Padding(
                        padding: const EdgeInsets.all(CavSpacing.sm),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Chip(label: Text('Café pickup')),
                            const SizedBox(height: CavSpacing.sm),
                            Text(
                              widget.product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: CavSpacing.xs),
                            Text(
                              widget.product.price,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: CavSpacing.sm),
                            Text(
                              widget.product.description,
                              maxLines: wide ? 3 : 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
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
                            CavImage(
                              asset: widget.product.imageAsset,
                              aspectRatio: 16 / 9,
                            ),
                            details,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          SizedBox(
                            width: 240,
                            child: CavImage(
                              asset: widget.product.imageAsset,
                              aspectRatio: 4 / 3,
                            ),
                          ),
                          const SizedBox(width: CavSpacing.sm),
                          Expanded(child: details),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: CavSpacing.xl),
                const SectionHeader(
                  title: 'Order Details',
                  subtitle: 'Set quantity, pickup time, and contact details.',
                ),
                const SizedBox(height: CavSpacing.md),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final twoColumns = constraints.maxWidth >= 680;
                    final fieldWidth = twoColumns
                        ? (constraints.maxWidth - CavSpacing.md) / 2
                        : constraints.maxWidth;
                    return Wrap(
                      spacing: CavSpacing.md,
                      runSpacing: CavSpacing.md,
                      children: [
                        SizedBox(
                          width: fieldWidth,
                          child: TextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Full name',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: CavValidators.required,
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: TextFormField(
                            controller: _contactController,
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Contact number',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                            validator: CavValidators.cellphone,
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _StepperTile(
                            value: _quantity,
                            onChanged: (value) =>
                                setState(() => _quantity = value),
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _PickerTile(
                            icon: Icons.calendar_month_outlined,
                            label: 'Pickup date',
                            value: _formatDate(_pickupDate),
                            onTap: _pickDate,
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _PickerTile(
                            icon: Icons.schedule_outlined,
                            label: 'Pickup time',
                            value: _pickupTime.format(context),
                            onTap: _pickTime,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: CavSpacing.md),
                const SectionHeader(
                  title: 'Add-ons',
                  subtitle: 'Customize your drink before pickup.',
                ),
                const SizedBox(height: CavSpacing.sm),
                ..._coffeeAddOns.map(
                  (addOn) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _selectedAddOnIds.contains(addOn.id),
                    onChanged: (selected) {
                      setState(() {
                        if (selected ?? false) {
                          _selectedAddOnIds.add(addOn.id);
                        } else {
                          _selectedAddOnIds.remove(addOn.id);
                        }
                      });
                    },
                    title: Text(addOn.name),
                    subtitle: Text(addOn.displayPrice),
                    secondary: const Icon(Icons.add_circle_outline),
                  ),
                ),
                const SizedBox(height: CavSpacing.md),
                _TotalToPay(
                  quantity: _quantity,
                  productPriceInPesos: widget.product.priceInPesos,
                  addOns: _selectedAddOns,
                  subtotalInPesos: _subtotalInPesos,
                  totalInPesos: _totalInPesos,
                ),
                const SizedBox(height: CavSpacing.lg),
                TextFormField(
                  controller: _notesController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Notes or requests',
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                ),
                const SizedBox(height: CavSpacing.lg),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.receipt_long_outlined),
                  label: const Text('View order summary'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Formats [date] as a compact month/day/year string for display.
  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  List<CoffeeAddOn> get _selectedAddOns {
    return _coffeeAddOns
        .where((addOn) => _selectedAddOnIds.contains(addOn.id))
        .toList(growable: false);
  }

  int get _subtotalInPesos {
    final addOnsPerDrink = _selectedAddOns.fold<int>(
      0,
      (total, addOn) => total + addOn.priceInPesos,
    );
    return (widget.product.priceInPesos + addOnsPerDrink) * _quantity;
  }

  int get _totalInPesos => _subtotalInPesos;
}

/// Displays the current order breakdown and final amount to pay.
class _TotalToPay extends StatelessWidget {
  const _TotalToPay({
    required this.quantity,
    required this.productPriceInPesos,
    required this.addOns,
    required this.subtotalInPesos,
    required this.totalInPesos,
  });

  final int quantity;
  final int productPriceInPesos;
  final List<CoffeeAddOn> addOns;
  final int subtotalInPesos;
  final int totalInPesos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      color: CavColors.accentSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total to Pay', style: theme.textTheme.titleLarge),
          const SizedBox(height: CavSpacing.sm),
          _PriceRow(
            label: '$quantity × drink',
            amountInPesos: productPriceInPesos * quantity,
          ),
          ...addOns.map(
            (addOn) =>
                _PriceRow(
                  label: '$quantity × ${addOn.name}',
                  amountInPesos: addOn.priceInPesos * quantity,
                ),
          ),
          const Divider(height: CavSpacing.lg),
          _PriceRow(label: 'Subtotal', amountInPesos: subtotalInPesos),
          const SizedBox(height: CavSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Final total',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                _formatPesos(totalInPesos),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.amountInPesos});

  final String label;
  final int amountInPesos;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label)),
        Text(_formatPesos(amountInPesos)),
      ],
    );
  }
}

String _formatPesos(int amountInPesos) => '₱$amountInPesos';

/// Provides bounded increment and decrement controls for order quantity.
class _StepperTile extends StatelessWidget {
  /// Creates a quantity control for [value] using [onChanged] for updates.
  const _StepperTile({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  /// Builds quantity controls and disables buttons at the allowed bounds.
  @override
  Widget build(BuildContext context) {
    return CavSurface(
      color: CavColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: CavSpacing.sm,
        vertical: CavSpacing.xs,
      ),
      child: Row(
        children: [
          const Icon(Icons.format_list_numbered_outlined),
          const SizedBox(width: 12),
          const Expanded(child: Text('Quantity')),
          IconButton(
            tooltip: 'Decrease quantity',
            onPressed: value > 1 ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove_circle_outline),
          ),
          SizedBox(
            width: 36,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton(
            tooltip: 'Increase quantity',
            onPressed: value < 12 ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}

/// Renders a tappable date or time value using an input-like appearance.
class _PickerTile extends StatelessWidget {
  /// Creates a picker tile with its icon, label, displayed [value], and action.
  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  /// Builds the input decorator and forwards taps to [onTap].
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(CavRadii.control),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: const Icon(Icons.edit_calendar_outlined),
        ),
        child: Text(value),
      ),
    );
  }
}
