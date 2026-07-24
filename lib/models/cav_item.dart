import 'package:flutter/material.dart';

/// Categorizes the services offered by CAV.
enum CavCategory { studio, event, coffee }

/// Groups café products into the official CAV menu sections.
enum CavMenuCategory { classics, signatures, matcha, soda }

/// Provides the display label used for a café menu category.
extension CavMenuCategoryLabel on CavMenuCategory {
  /// Returns the title shown in menu filters and product cards.
  String get label {
    switch (this) {
      case CavMenuCategory.classics:
        return 'Classics';
      case CavMenuCategory.signatures:
        return 'Signatures';
      case CavMenuCategory.matcha:
        return 'Matcha';
      case CavMenuCategory.soda:
        return 'Soda';
    }
  }
}

/// Describes a bookable photo or event service package.
class CavPackage {
  /// Creates an immutable service package from its display and asset data.
  const CavPackage({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.includes,
    required this.icon,
    required this.imageAsset,
  });

  final String id;
  final String title;
  final CavCategory category;
  final String price;
  final String description;
  final List<String> includes;
  final IconData icon;
  final String imageAsset;
}

/// Describes a coffee or pastry item available for pickup.
class CoffeeProduct {
  /// Creates an immutable menu item from its display and asset data.
  const CoffeeProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.tags,
    required this.icon,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final CavMenuCategory category;
  final String price;
  final String description;
  final List<String> tags;
  final IconData icon;
  final String imageAsset;
}

/// Stores the official CAV address and social contact details.
class CavContactDetails {
  /// Creates immutable contact details for the profile screen.
  const CavContactDetails({
    required this.address,
    required this.email,
    required this.facebook,
    required this.instagram,
    required this.tiktok,
  });

  final String address;
  final String email;
  final String facebook;
  final String instagram;
  final String tiktok;
}

/// Describes one gallery entry shown in the application.
class GalleryItem {
  /// Creates an immutable gallery entry.
  const GalleryItem({
    required this.title,
    required this.caption,
    required this.icon,
    required this.color,
    required this.imageAsset,
  });

  final String title;
  final String caption;
  final IconData icon;
  final Color color;
  final String imageAsset;
}

/// Captures the validated details submitted for a booking.
class BookingSummary {
  /// Creates an immutable booking summary for the confirmation screen.
  const BookingSummary({
    required this.serviceName,
    required this.customerName,
    required this.contactNumber,
    required this.email,
    required this.date,
    required this.time,
    required this.notes,
    required this.imageAsset,
  });

  final String serviceName;
  final String customerName;
  final String contactNumber;
  final String email;
  final DateTime date;
  final TimeOfDay time;
  final String notes;
  final String imageAsset;
}

/// Captures the validated details submitted for a coffee order.
class OrderSummary {
  /// Creates an immutable order summary for the confirmation screen.
  const OrderSummary({
    required this.productName,
    required this.customerName,
    required this.contactNumber,
    required this.pickupDate,
    required this.pickupTime,
    required this.quantity,
    required this.notes,
    required this.imageAsset,
  });

  final String productName;
  final String customerName;
  final String contactNumber;
  final DateTime pickupDate;
  final TimeOfDay pickupTime;
  final int quantity;
  final String notes;
  final String imageAsset;
}
