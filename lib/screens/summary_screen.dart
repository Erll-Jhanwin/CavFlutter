import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../models/cav_item.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';

/// Displays the submitted booking details and provides a return-home action.
class BookingSummaryScreen extends StatelessWidget {
  /// Creates a booking confirmation from [summary].
  const BookingSummaryScreen({super.key, required this.summary});

  final BookingSummary summary;

  /// Builds the shared summary layout with booking-specific fields.
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

/// Displays the submitted order details and provides a return-home action.
class OrderSummaryScreen extends StatelessWidget {
  /// Creates an order confirmation from [summary].
  const OrderSummaryScreen({super.key, required this.summary});

  final OrderSummary summary;

  /// Builds the shared summary layout with order-specific fields.
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
          label: 'Add-ons',
          value: summary.addOns.isEmpty
              ? 'None'
              : summary.addOns.map((addOn) => addOn.name).join(', '),
        ),
        _SummaryRow(
          label: 'Subtotal',
          value: _formatPesos(summary.subtotalInPesos),
        ),
        _SummaryRow(
          label: 'Total to Pay',
          value: _formatPesos(summary.totalInPesos),
        ),
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

String _formatPesos(int amountInPesos) => '₱$amountInPesos';

/// Provides the responsive image, detail grid, and return-home action.
class _SummaryScaffold extends StatelessWidget {
  /// Creates a summary layout using [title], [imageAsset], and detail [children].
  const _SummaryScaffold({
    required this.title,
    required this.imageAsset,
    required this.children,
  });

  final String title;
  final String imageAsset;
  final List<Widget> children;

  /// Builds the summary card in a stacked or two-column responsive layout.
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
                    // Switch to a side-by-side summary once the card is wide enough.
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

/// Displays one label/value pair in a summary detail grid.
class _SummaryRow extends StatelessWidget {
  /// Creates a summary row from its [label] and [value].
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  /// Builds the label and truncated value text.
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

/// Formats [date] as the month/day/year string used in summaries.
String _formatDate(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}
