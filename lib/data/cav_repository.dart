import 'package:flutter/material.dart';

import '../models/cav_item.dart';

/// Provides the static service, product, and gallery data used by the app.
class CavRepository {
  /// Prevents instantiation because all repository data is static.
  const CavRepository._();

  static const studioPackages = [
    CavPackage(
      id: 'studio-solo',
      title: 'Solo Package',
      category: CavCategory.studio,
      price: '₱1,000',
      description: 'A focused studio session for up to 2 persons.',
      includes: [
        '2 persons',
        '15 minutes',
      ],
      icon: Icons.photo_camera_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CavPackage(
      id: 'studio-me-and-u',
      title: 'Me & U Package',
      category: CavCategory.studio,
      price: '₱1,000',
      description: 'A two-person studio session for shared portraits.',
      includes: [
        '2 persons',
        '15 minutes',
      ],
      icon: Icons.favorite_border,
      imageAsset: 'assets/PICS/couple/self shoot duo.jpg',
    ),
    CavPackage(
      id: 'studio-me-and-my-friends',
      title: 'Me & My Friends Package',
      category: CavCategory.studio,
      price: '₱1,000',
      description: 'A group studio session for 3 to 5 persons.',
      includes: [
        '3–5 persons',
        '15 minutes',
      ],
      icon: Icons.groups_outlined,
      imageAsset: 'assets/PICS/friends/studio session friends.jpg',
    ),
    CavPackage(
      id: 'studio-family',
      title: 'Family Package',
      category: CavCategory.studio,
      price: '₱1,000',
      description: 'A family studio session for 2 to 6 persons.',
      includes: [
        '2–6 persons',
        '15 minutes',
      ],
      icon: Icons.family_restroom_outlined,
      imageAsset: 'assets/PICS/family/studio session family.jpg',
    ),
    CavPackage(
      id: 'studio-birthday',
      title: 'Birthday Package',
      category: CavCategory.studio,
      price: '₱1,000',
      description: 'A birthday studio session for 2 to 6 persons.',
      includes: [
        '2–6 persons',
        '15 minutes',
      ],
      icon: Icons.celebration_outlined,
      imageAsset: 'assets/PICS/birthday/studio session bday.jpg',
    ),
  ];

  static const eventPackages = [
    CavPackage(
      id: 'photo-service-booking',
      title: 'Photo Service Booking',
      category: CavCategory.event,
      price: 'Inquire for pricing',
      description:
          'Book CAV photo coverage for events and outdoor photoshoots.',
      includes: [
        'Events',
        'Outdoor photoshoots',
      ],
      icon: Icons.camera_alt_outlined,
      imageAsset: 'assets/PICS/events/standard event package.jpg',
    ),
  ];

  static const coffeeProducts = [
    CoffeeProduct(
      id: 'coffee-americano',
      name: 'Americano',
      category: CavMenuCategory.classics,
      price: '₱70',
      description: 'A classic café selection from the Classics menu.',
      tags: ['Classics'],
      icon: Icons.local_cafe_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-cappuccino',
      name: 'Cappuccino',
      category: CavMenuCategory.classics,
      price: '₱110',
      description: 'A classic café selection from the Classics menu.',
      tags: ['Classics'],
      icon: Icons.coffee_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-spanish-latte',
      name: 'Spanish Latte',
      category: CavMenuCategory.classics,
      price: '₱105',
      description: 'A classic café selection from the Classics menu.',
      tags: ['Classics'],
      icon: Icons.emoji_food_beverage_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-caramel-macchiato',
      name: 'Caramel Macchiato',
      category: CavMenuCategory.classics,
      price: '₱105',
      description: 'A classic café selection from the Classics menu.',
      tags: ['Classics'],
      icon: Icons.local_cafe_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-chocnut-latte',
      name: 'Chocnut Latte',
      category: CavMenuCategory.signatures,
      price: '₱125',
      description: 'A signature CAV café selection.',
      tags: ['Signatures'],
      icon: Icons.emoji_food_beverage_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'coffee-triple-chocolate-latte',
      name: 'Triple Chocolate Latte',
      category: CavMenuCategory.signatures,
      price: '₱140',
      description: 'A signature CAV café selection.',
      tags: ['Signatures'],
      icon: Icons.emoji_food_beverage_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'matcha-classic',
      name: 'Classic Matcha',
      category: CavMenuCategory.matcha,
      price: '₱130',
      description: 'A matcha favorite from the CAV café menu.',
      tags: ['Matcha'],
      icon: Icons.local_cafe_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'matcha-dirty',
      name: 'Dirty Matcha',
      category: CavMenuCategory.matcha,
      price: '₱145',
      description: 'A matcha favorite from the CAV café menu.',
      tags: ['Matcha'],
      icon: Icons.local_cafe_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'matcha-chocnut',
      name: 'Chocnut Matcha',
      category: CavMenuCategory.matcha,
      price: '₱155',
      description: 'A matcha favorite from the CAV café menu.',
      tags: ['Matcha'],
      icon: Icons.local_cafe_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'matcha-strawberry',
      name: 'Strawberry Matcha',
      category: CavMenuCategory.matcha,
      price: '₱145',
      description: 'A matcha favorite from the CAV café menu.',
      tags: ['Matcha'],
      icon: Icons.local_cafe_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'soda-sparkling-mango',
      name: 'Sparkling Mango',
      category: CavMenuCategory.soda,
      price: '₱75',
      description: 'A sparkling fruit soda from the CAV café menu.',
      tags: ['Soda'],
      icon: Icons.local_drink_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'soda-sparkling-strawberry',
      name: 'Sparkling Strawberry',
      category: CavMenuCategory.soda,
      price: '₱75',
      description: 'A sparkling fruit soda from the CAV café menu.',
      tags: ['Soda'],
      icon: Icons.local_drink_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'soda-sparkling-blueberry',
      name: 'Sparkling Blueberry',
      category: CavMenuCategory.soda,
      price: '₱75',
      description: 'A sparkling fruit soda from the CAV café menu.',
      tags: ['Soda'],
      icon: Icons.local_drink_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    CoffeeProduct(
      id: 'soda-sparkling-green-apple',
      name: 'Sparkling Green Apple',
      category: CavMenuCategory.soda,
      price: '₱65',
      description: 'A sparkling fruit soda from the CAV café menu.',
      tags: ['Soda'],
      icon: Icons.local_drink_outlined,
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
  ];

  static const contactDetails = CavContactDetails(
    address: '028B M.P. Casanova Street, Purok 1, Tambo, Lipa City, Batangas',
    email: 'cav.photostudio.cafe@gmail.com',
    facebook: 'CAV Photo Studio & Cafe',
    instagram: 'CAV Photo Studio Cafe',
    tiktok: 'CAV Photo Studio and Cafe PH',
  );

  /// Returns menu products matching [query] and the optional [category].
  static List<CoffeeProduct> filterCoffeeProducts({
    String query = '',
    CavMenuCategory? category,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    return coffeeProducts.where((product) {
      final matchesCategory = category == null || product.category == category;
      final searchableText = [
        product.name,
        product.category.label,
        ...product.tags,
      ].join(' ').toLowerCase();
      final matchesQuery =
          normalizedQuery.isEmpty || searchableText.contains(normalizedQuery);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  static const galleryItems = [
    GalleryItem(
      title: 'Studio Portraits',
      caption: 'Clean lighting and polished personal portraits.',
      icon: Icons.person_outline,
      color: Color(0xFF176B5B),
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
    GalleryItem(
      title: 'Family Sessions',
      caption: 'Studio portraits for families and groups.',
      icon: Icons.family_restroom_outlined,
      color: Color(0xFF6E4C9A),
      imageAsset: 'assets/PICS/family/studio session family.jpg',
    ),
    GalleryItem(
      title: 'Event Highlights',
      caption: 'Celebration coverage for candid and key moments.',
      icon: Icons.event_available_outlined,
      color: Color(0xFFC05A2B),
      imageAsset: 'assets/PICS/events/event.jpg',
    ),
    GalleryItem(
      title: 'Coffee Bar',
      caption: 'Café drinks and a welcoming CAV storefront.',
      icon: Icons.local_cafe_outlined,
      color: Color(0xFF8B5E3C),
      imageAsset: 'assets/PICS/business/Store.jpg',
    ),
  ];
}
