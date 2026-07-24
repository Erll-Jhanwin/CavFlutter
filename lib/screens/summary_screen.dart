import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../models/cav_item.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key, required this.summary});

  final BookingSummary summary;

  @override
  Widget build(BuildContext context) {
    return _SummaryScaffold(
      title: 'Booking Summary',
      imageAsset: summary.imageAsset,
      children: [
        _SummaryRow(label: 'Service', value: summary.serviceName),
        _SummaryRow(label: 'Name', value: summary.customerName),
        _SummaryRow(label: 'Contact', value: summary.contactNumber),
        _SummaryRow(label: 'Email', value: summary.email),
        _SummaryRow(label: 'Date', value: _formatDate(summary.date)),
        _SummaryRow(label: 'Time', value: summary.time.format(context)),
        _SummaryRow(
          label: 'Notes',
          value: summary.notes.isEmpty ? 'None provided' : summary.notes,
        ),
      ],
    );
  }
}

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key, required this.summary});

  final OrderSummary summary;

  @override
  Widget build(BuildContext context) {
    return _SummaryScaffold(
      title: 'Order Summary',
      imageAsset: summary.imageAsset,
      children: [
        _SummaryRow(label: 'Product', value: summary.productName),
        _SummaryRow(label: 'Name', value: summary.customerName),
        _SummaryRow(label: 'Contact', value: summary.contactNumber),
        _SummaryRow(label: 'Quantity', value: '${summary.quantity}'),
        _SummaryRow(
          label: 'Pickup date',
          value: _formatDate(summary.pickupDate),
        ),
        _SummaryRow(
          label: 'Pickup time',
          value: summary.pickupTime.format(context),
        ),
        _SummaryRow(
          label: 'Notes',
          value: summary.notes.isEmpty ? 'None provided' : summary.notes,
        ),
      ],
    );
  }
}

class _SummaryScaffold extends StatelessWidget {
  const _SummaryScaffold({
    required this.title,
    required this.imageAsset,
    required this.children,
  });

  final String title;
  final String imageAsset;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CavAppHeader(
        title: title,
        subtitle: 'Review your request details',
      ),
      body: SafeArea(
        child: ResponsiveContent(
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
                    final wide = constraints.maxWidth >= 720;
                    final detailGrid = LayoutBuilder(
                      builder: (context, gridConstraints) {
                        final twoColumns = gridConstraints.maxWidth >= 460;
                        final width = twoColumns
                            ? (gridConstraints.maxWidth - CavSpacing.md) / 2
                            : gridConstraints.maxWidth;
                        return Wrap(
                          spacing: CavSpacing.md,
                          runSpacing: CavSpacing.sm,
                          children: children
                              .map((child) => SizedBox(width: width, child: child))
                              .toList(),
                        );
                      },
                    );

                    if (!wide) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CavImage(
                            asset: imageAsset,
                            aspectRatio: 16 / 9,
                            overlay: const CavImageOverlay(opacity: 0.10),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(CavSpacing.sm),
                            child: detailGrid,
                          ),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 260,
                          child: CavImage(
                            asset: imageAsset,
                            aspectRatio: 4 / 3,
                            overlay: const CavImageOverlay(opacity: 0.10),
                          ),
                        ),
                        const SizedBox(width: CavSpacing.md),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(CavSpacing.sm),
                            child: detailGrid,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: CavSpacing.lg),
              FilledButton.icon(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                icon: const Icon(Icons.home_outlined),
                label: const Text('Return home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
