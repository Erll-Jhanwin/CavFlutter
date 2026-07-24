import 'package:flutter/material.dart';

import '../models/cav_item.dart';

class CavRepository {
  const CavRepository._();

  static const studioPackages = [
    CavPackage(
      id: 'studio-portrait',
      title: 'Portrait Session',
      category: CavCategory.studio,
      price: 'From PHP 1,500',
      description:
          'A clean studio portrait session for solo, couple, or family photos.',
      includes: [
        '30-minute shoot',
        '5 enhanced photos',
        'Digital copies',
        'Studio backdrop options',
      ],
      icon: Icons.photo_camera_outlined,
      imageAsset: 'assets/images/studio_portrait.jpg',
    ),
    CavPackage(
      id: 'studio-graduation',
      title: 'Graduation Package',
      category: CavCategory.studio,
      price: 'From PHP 2,800',
      description:
          'Graduation portraits with formal, creative, and family layouts.',
      includes: [
        '1-hour shoot',
        '10 enhanced photos',
        'Toga and formal layouts',
        'Print-ready files',
      ],
      icon: Icons.school_outlined,
      imageAsset: 'assets/images/studio_graduation.jpg',
    ),
    CavPackage(
      id: 'studio-product',
      title: 'Product Shoot',
      category: CavCategory.studio,
      price: 'From PHP 3,200',
      description:
          'Static product photography for menus, catalogs, and social pages.',
      includes: [
        'Up to 10 products',
        'Styled flat lays',
        'Basic retouching',
        'Web-ready exports',
      ],
      icon: Icons.inventory_2_outlined,
      imageAsset: 'assets/images/studio_product.jpg',
    ),
  ];

  static const eventPackages = [
    CavPackage(
      id: 'event-birthday',
      title: 'Birthday Coverage',
      category: CavCategory.event,
      price: 'From PHP 6,500',
      description:
          'Photo coverage for birthdays, reunions, and intimate celebrations.',
      includes: [
        '3-hour coverage',
        'Edited event highlights',
        'Online gallery',
        'Same-week preview',
      ],
      icon: Icons.celebration_outlined,
      imageAsset: 'assets/images/event_birthday.jpg',
    ),
    CavPackage(
      id: 'event-wedding',
      title: 'Wedding Essentials',
      category: CavCategory.event,
      price: 'From PHP 18,000',
      description:
          'Documentary-style coverage for ceremony, portraits, and reception moments.',
      includes: [
        'Full event coverage',
        'Lead photographer',
        'Edited image set',
        'Keepsake album option',
      ],
      icon: Icons.favorite_border,
      imageAsset: 'assets/images/event_wedding.jpg',
    ),
    CavPackage(
      id: 'event-corporate',
      title: 'Corporate Event',
      category: CavCategory.event,
      price: 'From PHP 9,500',
      description:
          'Reliable coverage for launches, seminars, and company gatherings.',
      includes: [
        'Program documentation',
        'Speaker photos',
        'Group portraits',
        'Fast digital delivery',
      ],
      icon: Icons.business_center_outlined,
      imageAsset: 'assets/images/event_corporate.jpg',
    ),
  ];

  static const coffeeProducts = [
    CoffeeProduct(
      id: 'coffee-latte',
      name: 'CAV Signature Latte',
      price: 'PHP 145',
      description:
          'Smooth espresso with steamed milk and a balanced caramel finish.',
      tags: ['Hot', 'Iced', 'Best seller'],
      icon: Icons.local_cafe_outlined,
      imageAsset: 'assets/images/coffee_latte.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-americano',
      name: 'Classic Americano',
      price: 'PHP 110',
      description:
          'Clean espresso, warm water, and a crisp coffee-forward profile.',
      tags: ['Hot', 'Iced'],
      icon: Icons.coffee_outlined,
      imageAsset: 'assets/images/cafe_interior.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-mocha',
      name: 'Mocha Studio Blend',
      price: 'PHP 155',
      description: 'Espresso, cocoa, and milk for a richer coffee shop treat.',
      tags: ['Chocolate', 'Iced option'],
      icon: Icons.emoji_food_beverage_outlined,
      imageAsset: 'assets/images/coffee_mocha.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-croissant',
      name: 'Butter Croissant',
      price: 'PHP 95',
      description: 'Flaky pastry served warm, ideal with any coffee order.',
      tags: ['Pastry', 'Fresh daily'],
      icon: Icons.bakery_dining_outlined,
      imageAsset: 'assets/images/coffee_croissant.jpg',
    ),
  ];

  static const galleryItems = [
    GalleryItem(
      title: 'Studio Portraits',
      caption: 'Clean lighting and polished personal portraits.',
      icon: Icons.person_outline,
      color: Color(0xFF176B5B),
      imageAsset: 'assets/images/studio_portrait.jpg',
    ),
    GalleryItem(
      title: 'Graduation Sets',
      caption: 'Formal and creative looks for milestone photos.',
      icon: Icons.school_outlined,
      color: Color(0xFF6E4C9A),
      imageAsset: 'assets/images/studio_graduation.jpg',
    ),
    GalleryItem(
      title: 'Event Highlights',
      caption: 'Celebration coverage for candid and key moments.',
      icon: Icons.event_available_outlined,
      color: Color(0xFFC05A2B),
      imageAsset: 'assets/images/event_wedding.jpg',
    ),
    GalleryItem(
      title: 'Coffee Bar',
      caption: 'Cafe drinks, pastries, and cozy table scenes.',
      icon: Icons.local_cafe_outlined,
      color: Color(0xFF8B5E3C),
      imageAsset: 'assets/images/cafe_interior.jpg',
    ),
  ];
}
