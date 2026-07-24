import 'package:flutter/material.dart';

enum CavCategory { studio, event, coffee }

class CavPackage {
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

class CoffeeProduct {
  const CoffeeProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.tags,
    required this.icon,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String price;
  final String description;
  final List<String> tags;
  final IconData icon;
  final String imageAsset;
}

class GalleryItem {
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

class BookingSummary {
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

class OrderSummary {
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
