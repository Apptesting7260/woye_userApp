import 'package:get/get.dart';

class HomeSearchModal {
  bool? status;
  List<Products>? products;
  List<Restaurants>? restaurants;
  String? message;

  HomeSearchModal({this.status, this.products, this.restaurants, this.message});

  HomeSearchModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['Restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['Restaurants'].forEach((v) {
        restaurants!.add(Restaurants.fromJson(v));
      });
    }
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (products != null) {
      data['Products'] = products!.map((v) => v.toJson()).toList();
    }
    if (restaurants != null) {
      data['Restaurants'] = restaurants!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Products {
  String? id;
  String? image;
  String? rating;
  String? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  String? vendorId;
  String? categoryId;
  bool? isInWishlist;
  String? categoryName;
  String? restoName;
  List<String>? addimgUrl;
  String? imageUrl;
  String? cuisineName;
  String? brandName;
  String? packagingName;
  String? applicationName;
  String? productAttributeName;
  Category? category;
  String? cuisine;
  String? brand;
  String? packaging;
  String? application;
  Rx<bool> isLoading = false.obs;

  Products(
      {this.id,
        this.image,
        this.rating,
        this.salePrice,
        this.regularPrice,
        this.title,
        this.addimg,
        this.vendorId,
        this.categoryId,
        this.isInWishlist,
        this.categoryName,
        this.restoName,
        this.addimgUrl,
        this.imageUrl,
        this.cuisineName,
        this.brandName,
        this.packagingName,
        this.applicationName,
        this.productAttributeName,
        this.category,
        this.cuisine,
        this.brand,
        this.packaging,
        this.application});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    image = json['image']?.toString();
    rating = json['rating']?.toString();
    salePrice = json['sale_price']?.toString();
    regularPrice = json['regular_price']?.toString();
    title = json['title']?.toString();
    addimg = json['addimg']?.toString();
    vendorId = json['vendor_id']?.toString();
    categoryId = json['category_id']?.toString();
    isInWishlist = json['is_in_wishlist'];
    categoryName = json['category_name']?.toString();
    restoName = json['resto_name']?.toString();
    addimgUrl = json['addimg_url'].cast<String>();
    imageUrl = json['image_url']?.toString();
    cuisineName = json['cuisine_name']?.toString();
    brandName = json['brand_name']?.toString();
    packagingName = json['packaging_name']?.toString();
    applicationName = json['application_name']?.toString();
    productAttributeName = json['product_attribute_name']?.toString();
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    cuisine = json['cuisine']?.toString();
    brand = json['brand']?.toString();
    packaging = json['packaging']?.toString();
    application = json['application']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['rating'] = rating;
    data['sale_price'] = salePrice;
    data['regular_price'] = regularPrice;
    data['title'] = title;
    data['addimg'] = addimg;
    data['vendor_id'] = vendorId;
    data['category_id'] = categoryId;
    data['is_in_wishlist'] = isInWishlist;
    data['category_name'] = categoryName;
    data['resto_name'] = restoName;
    data['addimg_url'] = addimgUrl;
    data['image_url'] = imageUrl;
    data['cuisine_name'] = cuisineName;
    data['brand_name'] = brandName;
    data['packaging_name'] = packagingName;
    data['application_name'] = applicationName;
    data['product_attribute_name'] = productAttributeName;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['cuisine'] = cuisine;
    data['brand'] = brand;
    data['packaging'] = packaging;
    data['application'] = application;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? imageUrl;
  String? productsCount;

  Category({this.id, this.name, this.imageUrl, this.productsCount});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    imageUrl = json['image_url']?.toString();
    productsCount = json['products_count']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['products_count'] = productsCount;
    return data;
  }
}

class Restaurants {
  String? id;
  String? shopName;
  String? ownerName;
  String? description;
  String? dob;
  String? phoneCode;
  String? phone;
  String? email;
  String? website;
  String? address;
  String? latitude;
  String? longitude;
  String? logo;
  String? coverPhoto;
  String? licenseNumber;
  String? taxNumber;
  String? deaRegistrationNumber;
  String? ncProviderId;
  String? establishedDate;
  String? noOfEmployees;
  String? facebook;
  String? instagram;
  String? twitter;
  String? youtube;
  String? deliveryRadius;
  String? minOrderAmount;
  String? avgPreparationTime;
  String? avgFulfillmentTime;
  List<dynamic>? serviceType;
  String? insuranceNetworks;
  String? securityLevel;
  String? auditFrequency;
  String? scheduleDispensingAuthorized;
  String? electronicPrescribing;
  String? deliveryFee;
  String? delivery;
  List<CategoryIds>? categoryIds;
  OpeningHours? openingHours;
  List<int>? cuisineIds;
  String? commissionRate;
  String? commissionTier;
  DocumentVerification? documentVerification;
  String? storeType;
  String? storeSize;
  List<dynamic>? storeSpecializations;
  String? pciCompliance;
  String? cashDrawerSecurity;
  String? hipaaCompliance;
  String? deaSecurity;
  String? otherDetails;
  String? roleId;
  String? parentId;
  String? type;
  String? otp;
  String? rating;
  String? emailVerify;
  String? step;
  String? deviceToken;
  String? status;
  String? addedBy;
  String? doNotDisturb;
  String? quietHours;
  String? startTime;
  String? endTime;
  String? notificationSounds;
  String? notificationBadges;
  String? notifyNewOrders;
  String? notifyOrderUpdates;
  String? notifyPaymentIssues;
  String? notifyLowStock;
  String? notifyOutOfStock;
  String? notifyTableReservations;
  String? notifyMenuItemRequests;
  String? pushNotifications;
  String? emailNotifications;
  String? smsNotifications;
  String? orderSummaryFrequency;
  String? reviewNotificationFrequency;
  String? inventoryAlertFrequency;
  String? appVersion;
  String? twoFa;
  String? twoFaApp;
  String? twoFaCode;
  String? twoFaExpiresAt;
  String? lastLoginAt;
  String? isOnline;
  String? createdAt;
  String? updatedAt;
  String? logoUrl;
  String? coverPhotoUrl;
  String? roleName;
  Role? role;

  Restaurants(
      {this.id,
        this.shopName,
        this.ownerName,
        this.description,
        this.dob,
        this.phoneCode,
        this.phone,
        this.email,
        this.website,
        this.address,
        this.latitude,
        this.longitude,
        this.logo,
        this.coverPhoto,
        this.licenseNumber,
        this.taxNumber,
        this.deaRegistrationNumber,
        this.ncProviderId,
        this.establishedDate,
        this.noOfEmployees,
        this.facebook,
        this.instagram,
        this.twitter,
        this.youtube,
        this.deliveryRadius,
        this.minOrderAmount,
        this.avgPreparationTime,
        this.avgFulfillmentTime,
        this.serviceType,
        this.insuranceNetworks,
        this.securityLevel,
        this.auditFrequency,
        this.scheduleDispensingAuthorized,
        this.electronicPrescribing,
        this.deliveryFee,
        this.delivery,
        this.categoryIds,
        this.openingHours,
        this.cuisineIds,
        this.commissionRate,
        this.commissionTier,
        this.documentVerification,
        this.storeType,
        this.storeSize,
        this.storeSpecializations,
        this.pciCompliance,
        this.cashDrawerSecurity,
        this.hipaaCompliance,
        this.deaSecurity,
        this.otherDetails,
        this.roleId,
        this.parentId,
        this.type,
        this.otp,
        this.rating,
        this.emailVerify,
        this.step,
        this.deviceToken,
        this.status,
        this.addedBy,
        this.doNotDisturb,
        this.quietHours,
        this.startTime,
        this.endTime,
        this.notificationSounds,
        this.notificationBadges,
        this.notifyNewOrders,
        this.notifyOrderUpdates,
        this.notifyPaymentIssues,
        this.notifyLowStock,
        this.notifyOutOfStock,
        this.notifyTableReservations,
        this.notifyMenuItemRequests,
        this.pushNotifications,
        this.emailNotifications,
        this.smsNotifications,
        this.orderSummaryFrequency,
        this.reviewNotificationFrequency,
        this.inventoryAlertFrequency,
        this.appVersion,
        this.twoFa,
        this.twoFaApp,
        this.twoFaCode,
        this.twoFaExpiresAt,
        this.lastLoginAt,
        this.isOnline,
        this.createdAt,
        this.updatedAt,
        this.logoUrl,
        this.coverPhotoUrl,
        this.roleName,
        this.role});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    shopName = json['shop_name']?.toString();
    ownerName = json['owner_name']?.toString();
    description = json['description']?.toString();
    dob = json['dob']?.toString();
    phoneCode = json['phone_code']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    website = json['website']?.toString();
    address = json['address']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    logo = json['logo']?.toString();
    coverPhoto = json['cover_photo']?.toString();
    licenseNumber = json['license_number']?.toString();
    taxNumber = json['tax_number']?.toString();
    deaRegistrationNumber = json['dea_registration_number']?.toString();
    ncProviderId = json['nc_provider_id']?.toString();
    establishedDate = json['established_date']?.toString();
    noOfEmployees = json['no_of_employees']?.toString();
    facebook = json['facebook']?.toString();
    instagram = json['instagram']?.toString();
    twitter = json['twitter']?.toString();
    youtube = json['youtube']?.toString();
    deliveryRadius = json['delivery_radius']?.toString();
    minOrderAmount = json['min_order_amount']?.toString();
    avgPreparationTime = json['avg_preparation_time']?.toString();
    avgFulfillmentTime = json['avg_fulfillment_time']?.toString();
    if (json['service_type'] != null) {
      serviceType = <dynamic>[];
      json['service_type'].forEach((v) {
        // serviceType!.add(new Null.fromJson(v));
      });
    }
    insuranceNetworks = json['insurance_networks']?.toString();
    securityLevel = json['security_level']?.toString();
    auditFrequency = json['audit_frequency']?.toString();
    scheduleDispensingAuthorized = json['schedule_dispensing_authorized']?.toString();
    electronicPrescribing = json['electronic_prescribing']?.toString();
    deliveryFee = json['delivery_fee']?.toString();
    delivery = json['delivery']?.toString();
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    cuisineIds = json['cuisine_ids'].cast<int>();
    commissionRate = json['commission_rate']?.toString();
    commissionTier = json['commission_tier']?.toString();
    documentVerification = json['document_verification'] != null
        ? DocumentVerification.fromJson(json['document_verification'])
        : null;
    storeType = json['store_type'];
    storeSize = json['store_size'];
    if (json['store_specializations'] != null) {
      storeSpecializations = <dynamic>[];
      json['store_specializations'].forEach((v) {
        // storeSpecializations!.add(new Null.fromJson(v));
      });
    }
    pciCompliance = json['pci_compliance']?.toString();
    cashDrawerSecurity = json['cash_drawer_security']?.toString();
    hipaaCompliance = json['hipaa_compliance']?.toString();
    deaSecurity = json['dea_security']?.toString();
    otherDetails = json['other_details']?.toString();
    roleId = json['role_id']?.toString();
    parentId = json['parent_id']?.toString();
    type = json['type']?.toString();
    otp = json['otp']?.toString();
    rating = json['rating']?.toString();
    emailVerify = json['email_verify']?.toString();
    step = json['step']?.toString();
    deviceToken = json['device_token']?.toString();
    status = json['status']?.toString();
    addedBy = json['added_by']?.toString();
    doNotDisturb = json['do_not_disturb']?.toString();
    quietHours = json['quiet_hours']?.toString();
    startTime = json['start_time']?.toString();
    endTime = json['end_time']?.toString();
    notificationSounds = json['notification_sounds']?.toString();
    notificationBadges = json['notification_badges']?.toString();
    notifyNewOrders = json['notify_new_orders']?.toString();
    notifyOrderUpdates = json['notify_order_updates']?.toString();
    notifyPaymentIssues = json['notify_payment_issues']?.toString();
    notifyLowStock = json['notify_low_stock']?.toString();
    notifyOutOfStock = json['notify_out_of_stock']?.toString();
    notifyTableReservations = json['notify_table_reservations']?.toString();
    notifyMenuItemRequests = json['notify_menu_item_requests']?.toString();
    pushNotifications = json['push_notifications']?.toString();
    emailNotifications = json['email_notifications']?.toString();
    smsNotifications = json['sms_notifications']?.toString();
    orderSummaryFrequency = json['order_summary_frequency']?.toString();
    reviewNotificationFrequency = json['review_notification_frequency']?.toString();
    inventoryAlertFrequency = json['inventory_alert_frequency']?.toString();
    appVersion = json['app_version']?.toString();
    twoFa = json['two_fa']?.toString();
    twoFaApp = json['two_fa_app']?.toString();
    twoFaCode = json['two_fa_code']?.toString();
    twoFaExpiresAt = json['two_fa_expires_at']?.toString();
    lastLoginAt = json['last_login_at']?.toString();
    isOnline = json['is_online']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    logoUrl = json['logo_url']?.toString();
    coverPhotoUrl = json['cover_photo_url']?.toString();
    roleName = json['role_name']?.toString();
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_name'] = shopName;
    data['owner_name'] = ownerName;
    data['description'] = description;
    data['dob'] = dob;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['email'] = email;
    data['website'] = website;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['logo'] = logo;
    data['cover_photo'] = coverPhoto;
    data['license_number'] = licenseNumber;
    data['tax_number'] = taxNumber;
    data['dea_registration_number'] = deaRegistrationNumber;
    data['nc_provider_id'] = ncProviderId;
    data['established_date'] = establishedDate;
    data['no_of_employees'] = noOfEmployees;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    data['youtube'] = youtube;
    data['delivery_radius'] = deliveryRadius;
    data['min_order_amount'] = minOrderAmount;
    data['avg_preparation_time'] = avgPreparationTime;
    data['avg_fulfillment_time'] = avgFulfillmentTime;
    if (serviceType != null) {
      data['service_type'] = serviceType!.map((v) => v.toJson()).toList();
    }
    data['insurance_networks'] = insuranceNetworks;
    data['security_level'] = securityLevel;
    data['audit_frequency'] = auditFrequency;
    data['schedule_dispensing_authorized'] = scheduleDispensingAuthorized;
    data['electronic_prescribing'] = electronicPrescribing;
    data['delivery_fee'] = deliveryFee;
    data['delivery'] = delivery;
    if (categoryIds != null) {
      data['category_ids'] = categoryIds!.map((v) => v.toJson()).toList();
    }
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.toJson();
    }
    data['cuisine_ids'] = cuisineIds;
    data['commission_rate'] = commissionRate;
    data['commission_tier'] = commissionTier;
    if (documentVerification != null) {
      data['document_verification'] = documentVerification!.toJson();
    }
    data['store_type'] = storeType;
    data['store_size'] = storeSize;
    if (storeSpecializations != null) {
      data['store_specializations'] =
          storeSpecializations!.map((v) => v.toJson()).toList();
    }
    data['pci_compliance'] = pciCompliance;
    data['cash_drawer_security'] = cashDrawerSecurity;
    data['hipaa_compliance'] = hipaaCompliance;
    data['dea_security'] = deaSecurity;
    data['other_details'] = otherDetails;
    data['role_id'] = roleId;
    data['parent_id'] = parentId;
    data['type'] = type;
    data['otp'] = otp;
    data['rating'] = rating;
    data['email_verify'] = emailVerify;
    data['step'] = step;
    data['device_token'] = deviceToken;
    data['status'] = status;
    data['added_by'] = addedBy;
    data['do_not_disturb'] = doNotDisturb;
    data['quiet_hours'] = quietHours;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['notification_sounds'] = notificationSounds;
    data['notification_badges'] = notificationBadges;
    data['notify_new_orders'] = notifyNewOrders;
    data['notify_order_updates'] = notifyOrderUpdates;
    data['notify_payment_issues'] = notifyPaymentIssues;
    data['notify_low_stock'] = notifyLowStock;
    data['notify_out_of_stock'] = notifyOutOfStock;
    data['notify_table_reservations'] = notifyTableReservations;
    data['notify_menu_item_requests'] = notifyMenuItemRequests;
    data['push_notifications'] = pushNotifications;
    data['email_notifications'] = emailNotifications;
    data['sms_notifications'] = smsNotifications;
    data['order_summary_frequency'] = orderSummaryFrequency;
    data['review_notification_frequency'] = reviewNotificationFrequency;
    data['inventory_alert_frequency'] = inventoryAlertFrequency;
    data['app_version'] = appVersion;
    data['two_fa'] = twoFa;
    data['two_fa_app'] = twoFaApp;
    data['two_fa_code'] = twoFaCode;
    data['two_fa_expires_at'] = twoFaExpiresAt;
    data['last_login_at'] = lastLoginAt;
    data['is_online'] = isOnline;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['logo_url'] = logoUrl;
    data['cover_photo_url'] = coverPhotoUrl;
    data['role_name'] = roleName;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class CategoryIds {
  String? id;
  String? status;
  String? added;

  CategoryIds({this.id, this.status, this.added});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    status = json['status']?.toString();
    added = json['added']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['added'] = added;
    return data;
  }
}

class OpeningHours {
  Monday? monday;
  Tuesday? tuesday;
  Tuesday? wednesday;
  Tuesday? thursday;
  Tuesday? friday;
  Tuesday? saturday;
  Tuesday? sunday;

  OpeningHours(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    monday =
    json['Monday'] != null ? Monday.fromJson(json['Monday']) : null;
    tuesday =
    json['Tuesday'] != null ? Tuesday.fromJson(json['Tuesday']) : null;
    wednesday = json['Wednesday'] != null
        ? Tuesday.fromJson(json['Wednesday'])
        : null;
    thursday = json['Thursday'] != null
        ? Tuesday.fromJson(json['Thursday'])
        : null;
    friday =
    json['Friday'] != null ? Tuesday.fromJson(json['Friday']) : null;
    saturday = json['Saturday'] != null
        ? Tuesday.fromJson(json['Saturday'])
        : null;
    sunday =
    json['Sunday'] != null ? Tuesday.fromJson(json['Sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monday != null) {
      data['Monday'] = monday!.toJson();
    }
    if (tuesday != null) {
      data['Tuesday'] = tuesday!.toJson();
    }
    if (wednesday != null) {
      data['Wednesday'] = wednesday!.toJson();
    }
    if (thursday != null) {
      data['Thursday'] = thursday!.toJson();
    }
    if (friday != null) {
      data['Friday'] = friday!.toJson();
    }
    if (saturday != null) {
      data['Saturday'] = saturday!.toJson();
    }
    if (sunday != null) {
      data['Sunday'] = sunday!.toJson();
    }
    return data;
  }
}

class Monday {
  String? status;
  String? open;
  String? close;

  Monday({this.status, this.open, this.close});

  Monday.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    open = json['open']?.toString();
    close = json['close']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['open'] = open;
    data['close'] = close;
    return data;
  }
}

class Tuesday {
  String? open;
  String? close;

  Tuesday({this.open, this.close});

  Tuesday.fromJson(Map<String, dynamic> json) {
    open = json['open']?.toString();
    close = json['close']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open'] = open;
    data['close'] = close;
    return data;
  }
}

class DocumentVerification {
  HealthPermit? healthPermit;
  HealthPermit? foodSafetyCertificate;
  HealthPermit? liquorLicense;
  HealthPermit? fireSafetyCertificate;
  HealthPermit? foodHandlerCertificate;
  HealthPermit? businessLicense;
  HealthPermit? buildingPermit;
  HealthPermit? occupancyCertificate;
  HealthPermit? musicEntertainmentLicense;
  HealthPermit? other;

  DocumentVerification(
      {this.healthPermit,
        this.foodSafetyCertificate,
        this.liquorLicense,
        this.fireSafetyCertificate,
        this.foodHandlerCertificate,
        this.businessLicense,
        this.buildingPermit,
        this.occupancyCertificate,
        this.musicEntertainmentLicense,
        this.other});

  DocumentVerification.fromJson(Map<String, dynamic> json) {
    healthPermit = json['health_permit'] != null
        ? HealthPermit.fromJson(json['health_permit'])
        : null;
    foodSafetyCertificate = json['food_safety_certificate'] != null
        ? HealthPermit.fromJson(json['food_safety_certificate'])
        : null;
    liquorLicense = json['liquor_license'] != null
        ? HealthPermit.fromJson(json['liquor_license'])
        : null;
    fireSafetyCertificate = json['fire_safety_certificate'] != null
        ? HealthPermit.fromJson(json['fire_safety_certificate'])
        : null;
    foodHandlerCertificate = json['food_handler_certificate'] != null
        ? HealthPermit.fromJson(json['food_handler_certificate'])
        : null;
    businessLicense = json['business_license'] != null
        ? HealthPermit.fromJson(json['business_license'])
        : null;
    buildingPermit = json['building_permit'] != null
        ? HealthPermit.fromJson(json['building_permit'])
        : null;
    occupancyCertificate = json['occupancy_certificate'] != null
        ? HealthPermit.fromJson(json['occupancy_certificate'])
        : null;
    musicEntertainmentLicense = json['music_entertainment_license'] != null
        ? HealthPermit.fromJson(json['music_entertainment_license'])
        : null;
    other =
    json['other'] != null ? HealthPermit.fromJson(json['other']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (healthPermit != null) {
      data['health_permit'] = healthPermit!.toJson();
    }
    if (foodSafetyCertificate != null) {
      data['food_safety_certificate'] = foodSafetyCertificate!.toJson();
    }
    if (liquorLicense != null) {
      data['liquor_license'] = liquorLicense!.toJson();
    }
    if (fireSafetyCertificate != null) {
      data['fire_safety_certificate'] = fireSafetyCertificate!.toJson();
    }
    if (foodHandlerCertificate != null) {
      data['food_handler_certificate'] = foodHandlerCertificate!.toJson();
    }
    if (businessLicense != null) {
      data['business_license'] = businessLicense!.toJson();
    }
    if (buildingPermit != null) {
      data['building_permit'] = buildingPermit!.toJson();
    }
    if (occupancyCertificate != null) {
      data['occupancy_certificate'] = occupancyCertificate!.toJson();
    }
    if (musicEntertainmentLicense != null) {
      data['music_entertainment_license'] =
          musicEntertainmentLicense!.toJson();
    }
    if (other != null) {
      data['other'] = other!.toJson();
    }
    return data;
  }
}

class HealthPermit {
  String? documentNumber;
  String? issuingAuthority;
  String? issueDate;
  String? expiryDate;
  String? status;
  String? image;
  String? additionalNotes;

  HealthPermit(
      {this.documentNumber,
        this.issuingAuthority,
        this.issueDate,
        this.expiryDate,
        this.status,
        this.image,
        this.additionalNotes});

  HealthPermit.fromJson(Map<String, dynamic> json) {
    documentNumber = json['document_number']?.toString();
    issuingAuthority = json['issuing_authority']?.toString();
    issueDate = json['issue_date']?.toString();
    expiryDate = json['expiry_date']?.toString();
    status = json['status']?.toString();
    image = json['image']?.toString();
    additionalNotes = json['additional_notes']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_number'] = documentNumber;
    data['issuing_authority'] = issuingAuthority;
    data['issue_date'] = issueDate;
    data['expiry_date'] = expiryDate;
    data['status'] = status;
    data['image'] = image;
    data['additional_notes'] = additionalNotes;
    return data;
  }
}

class Role {
  String? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.name, this.guardName, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    guardName = json['guard_name']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['guard_name'] = guardName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

// class HomeSearchModal {
//   bool? status;
//   List<Products>? products;
//   List<Restaurants>? restaurants;
//   String? message;
//
//   HomeSearchModal({this.status, this.products, this.restaurants, this.message});
//
//   HomeSearchModal.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     products = json['Products'] != null
//         ? (json['Products'] as List).map((v) => Products.fromJson(v)).toList()
//         : [];
//     restaurants = json['Restaurants'] != null
//         ? (json['Restaurants'] as List)
//             .map((v) => Restaurants.fromJson(v))
//             .toList()
//         : [];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (products != null) {
//       data['Products'] = products!.map((v) => v.toJson()).toList();
//     }
//     if (restaurants != null) {
//       data['Restaurants'] = restaurants!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = message;
//     return data;
//   }
// }
//
// class Products {
//   String? id;
//   String? image;
//   String? rating;
//   String? salePrice;
//   String? regularPrice;
//   String? title;
//   String? addimg;
//   String? userId;
//   bool? isInWishlist;
//   String? restoName;
//   List<String>? urlAddimg;
//   String? urlImage;
//   String? categoryId;
//   String? categoryName;
//   Rx<bool> isLoading = false.obs;
//
//
//   Products({
//     this.id,
//     this.image,
//     this.rating,
//     this.salePrice,
//     this.regularPrice,
//     this.title,
//     this.addimg,
//     this.userId,
//     this.isInWishlist,
//     this.restoName,
//     this.urlAddimg,
//     this.urlImage,
//     this.categoryId,
//     this.categoryName,
//   });
//
//   // From JSON constructor
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id']?.toString();
//     image = json['image']?.toString();
//     rating = json['rating']?.toString();
//     salePrice = json['sale_price']?.toString();
//     regularPrice = json['regular_price']?.toString();
//     title = json['title']?.toString();
//     addimg = json['addimg']?.toString();
//     userId = json['user_id']?.toString();
//     isInWishlist = json['is_in_wishlist'];
//     restoName = json['resto_name']?.toString();
//     urlAddimg = json['url_addimg'].cast<String>();
//     urlImage = json['url_image']?.toString();
//     categoryId = json['category_id']?.toString();
//     categoryName = json['category_name']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['image'] = image;
//     data['rating'] = rating;
//     data['sale_price'] = salePrice;
//     data['regular_price'] = regularPrice;
//     data['title'] = title;
//     data['addimg'] = addimg;
//     data['user_id'] = userId;
//     data['is_in_wishlist'] = isInWishlist;
//     data['resto_name'] = restoName;
//     data['url_addimg'] = urlAddimg;
//     data['url_image'] = urlImage;
//     data['category_id'] = categoryId;
//     data['category_name'] = categoryName;
//
//     return data;
//   }
// }
//
// class Restaurants {
//   String? id;
//   String? firstName;
//   String? lastName;
//   String? name;
//   String? email;
//   String? image;
//   String? dob;
//   String? gender;
//   String? pPassword;
//   String? rating;
//   String? avgPrice;
//   String? currentStatus;
//   String? phoneCode;
//   String? phone;
//   String? imageUrl;
//   String? shopName;
//   String? shopEmail;
//   String? shopimage;
//   String? shopAddress;
//   String? shopDes;
//   String? countryId;
//   String? stateId;
//   String? cityId;
//   String? role;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Restaurants(
//       {this.id,
//       this.firstName,
//       this.lastName,
//       this.name,
//       this.email,
//       this.image,
//       this.dob,
//       this.gender,
//       this.pPassword,
//       this.rating,
//       this.avgPrice,
//       this.currentStatus,
//       this.phoneCode,
//       this.phone,
//       this.imageUrl,
//       this.shopName,
//       this.shopEmail,
//       this.shopimage,
//       this.shopAddress,
//       this.shopDes,
//       this.countryId,
//       this.stateId,
//       this.cityId,
//       this.role,
//       this.status,
//       this.createdAt,
//       this.updatedAt});
//
//   Restaurants.fromJson(Map<String, dynamic> json) {
//     id = json['id']?.toString();
//     firstName = json['first_name']?.toString();
//     lastName = json['last_name']?.toString();
//     name = json['name']?.toString();
//     email = json['email']?.toString();
//     image = json['image']?.toString();
//     dob = json['dob']?.toString();
//     gender = json['gender']?.toString();
//     pPassword = json['p_password']?.toString();
//     rating = json['rating']?.toString();
//     avgPrice = json['avg_price']?.toString();
//     currentStatus = json['current_status']?.toString();
//     phoneCode = json['phone_code']?.toString();
//     phone = json['phone']?.toString();
//     imageUrl = json['image_url']?.toString();
//     shopName = json['shop_name']?.toString();
//     shopEmail = json['shop_email']?.toString();
//     shopimage = json['shopimage']?.toString();
//     shopAddress = json['shop_address']?.toString();
//     shopDes = json['shop_des']?.toString();
//     countryId = json['country_id']?.toString();
//     stateId = json['state_id']?.toString();
//     cityId = json['city_id']?.toString();
//     role = json['role']?.toString();
//     status = json['status']?.toString();
//     createdAt = json['created_at']?.toString();
//     updatedAt = json['updated_at']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['name'] = name;
//     data['email'] = email;
//     data['image'] = image;
//     data['dob'] = dob;
//     data['gender'] = gender;
//     data['p_password'] = pPassword;
//     data['rating'] = rating;
//     data['avg_price'] = avgPrice;
//     data['current_status'] = currentStatus;
//     data['phone_code'] = phoneCode;
//     data['phone'] = phone;
//     data['image_url'] = imageUrl;
//     data['shop_name'] = shopName;
//     data['shop_email'] = shopEmail;
//     data['shopimage'] = shopimage;
//     data['shop_address'] = shopAddress;
//     data['shop_des'] = shopDes;
//     data['country_id'] = countryId;
//     data['state_id'] = stateId;
//     data['city_id'] = cityId;
//     data['role'] = role;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
// class OpeningHours {
//   Sunday? sunday;
//   Sunday? monday;
//   Sunday? tuesday;
//   Sunday? wednesday;
//   Sunday? thursday;
//   Sunday? friday;
//   Sunday? saturday;
//
//   OpeningHours(
//       {this.sunday,
//       this.monday,
//       this.tuesday,
//       this.wednesday,
//       this.thursday,
//       this.friday,
//       this.saturday});
//
//   OpeningHours.fromJson(Map<String, dynamic> json) {
//     sunday =
//         json['Sunday'] != null ? new Sunday.fromJson(json['Sunday']) : null;
//     monday =
//         json['Monday'] != null ? new Sunday.fromJson(json['Monday']) : null;
//     tuesday =
//         json['Tuesday'] != null ? new Sunday.fromJson(json['Tuesday']) : null;
//     wednesday = json['Wednesday'] != null
//         ? new Sunday.fromJson(json['Wednesday'])
//         : null;
//     thursday =
//         json['Thursday'] != null ? new Sunday.fromJson(json['Thursday']) : null;
//     friday =
//         json['Friday'] != null ? new Sunday.fromJson(json['Friday']) : null;
//     saturday =
//         json['Saturday'] != null ? new Sunday.fromJson(json['Saturday']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (sunday != null) {
//       data['Sunday'] = sunday!.toJson();
//     }
//     if (monday != null) {
//       data['Monday'] = monday!.toJson();
//     }
//     if (tuesday != null) {
//       data['Tuesday'] = tuesday!.toJson();
//     }
//     if (wednesday != null) {
//       data['Wednesday'] = wednesday!.toJson();
//     }
//     if (thursday != null) {
//       data['Thursday'] = thursday!.toJson();
//     }
//     if (friday != null) {
//       data['Friday'] = friday!.toJson();
//     }
//     if (saturday != null) {
//       data['Saturday'] = saturday!.toJson();
//     }
//     return data;
//   }
// }
//
// class Sunday {
//   String? status;
//   String? open;
//   String? close;
//
//   Sunday({this.status, this.open, this.close});
//
//   Sunday.fromJson(Map<String, dynamic> json) {
//     status = json['status']?.toString();
//     open = json['open']?.toString();
//     close = json['close']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['open'] = open;
//     data['close'] = close;
//     return data;
//   }
// }
