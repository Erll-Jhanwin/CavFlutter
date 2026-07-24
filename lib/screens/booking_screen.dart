import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../models/cav_item.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';
import 'summary_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.package});

  final CavPackage package;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  late DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked == null || !mounted) return;
    setState(() => _selectedTime = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final summary = BookingSummary(
      serviceName: widget.package.title,
      customerName: _nameController.text.trim(),
      contactNumber: _contactController.text.trim(),
      email: _emailController.text.trim(),
      date: _selectedDate,
      time: _selectedTime,
      notes: _notesController.text.trim(),
      imageAsset: widget.package.imageAsset,
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BookingSummaryScreen(summary: summary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CavAppHeader(
        title: 'Sample Booking',
        subtitle: widget.package.title,
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
                            Chip(label: Text(widget.package.category.name)),
                            const SizedBox(height: CavSpacing.sm),
                            Text(
                              widget.package.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: CavSpacing.xs),
                            Text(
                              widget.package.price,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: CavSpacing.sm),
                            Text(
                              widget.package.description,
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
                              asset: widget.package.imageAsset,
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
                              asset: widget.package.imageAsset,
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
                  title: 'Booking Details',
                  subtitle: 'Add your contact information and preferred slot.',
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
                            validator: _required,
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: TextFormField(
                            controller: _contactController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Contact number',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                            validator: _required,
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (value) {
                              final text = value?.trim() ?? '';
                              if (text.isEmpty) {
                                return 'This field is required.';
                              }
                              if (!text.contains('@')) {
                                return 'Enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _PickerTile(
                            icon: Icons.calendar_month_outlined,
                            label: 'Preferred date',
                            value: _formatDate(_selectedDate),
                            onTap: _pickDate,
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _PickerTile(
                            icon: Icons.schedule_outlined,
                            label: 'Preferred time',
                            value: _selectedTime.format(context),
                            onTap: _pickTime,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: CavSpacing.md),
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
                  label: const Text('View booking summary'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if ((value ?? '').trim().isEmpty) return 'This field is required.';
    return null;
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class _PickerTile extends StatelessWidget {
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
