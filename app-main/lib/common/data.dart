class Data {
  static List<Map<String, dynamic>> shopServices = [
    {'id': 1, 'label': 'Super fast delivery', 'imageUrl': 'assets/icons/ic_shipping.png'},
    {'id': 2, 'label': 'Exchange at your location', 'imageUrl': 'assets/icons/ic_exchange.png'},
    {'id': 3, 'label': '120% refund', 'imageUrl': 'assets/icons/ic_refund.png'},
    {'id': 4, 'label': '24/7 hotline for consultation', 'imageUrl': 'assets/icons/ic_hotline.png'},
    {'id': 5, 'label': 'High-quality products', 'imageUrl': 'assets/icons/ic_quality.png'},
    {'id': 6, 'label': '7-day effectiveness guarantee', 'imageUrl': 'assets/icons/ic_guarantee.png'}
  ];

  static List<String> shopBanners = [
    'assets/images/shop/banner_1.webp',
    'assets/images/shop/banner_2.jpg',
    'assets/images/shop/banner_3.webp',
    'assets/images/shop/banner_4.jpg',
    'assets/images/shop/banner_5.webp',
  ];

  static List<Map<String, dynamic>> categories = [
    {'id': 1, 'label': 'Hair care', 'imageUrl': ''},
    {'id': 2, 'label': 'Hair styling', 'imageUrl': ''},
    {'id': 3, 'label': 'Perfume', 'imageUrl': ''},
    {'id': 4, 'label': 'Beard care', 'imageUrl': ''},
    {'id': 5, 'label': 'Skin care', 'imageUrl': ''},
    {'id': 6, 'label': 'Body care', 'imageUrl': ''}
  ];

  static List<String> comboBanners = [
    "https://bellavitaorganic.com/cdn/shop/files/QR-Code-OSM-BVL-Mobile-Category-Banner-v2_9d14a8de-1930-41e4-85d5-d2cb2bc85607.jpg?v=1675772805",
    "https://cdn.shopify.com/s/files/1/0561/9256/5292/files/900x600-Website-Hero-Banner.png?v=1673417597",
    "https://img.freepik.com/free-vector/cosmetic-products-body-care-water-splash_107791-2611.jpg",
    "https://img.freepik.com/free-psd/horizontal-banner-template-skin-care-products_23-2148806587.jpg",
  ];

  static String descriptionProduct =
      'Your daily conditioner was created for quicker results when compared to a hair mask, but should still be kept on your hair for about three minutes before rinsing away with cooler temperature water.';

  static List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'label': 'Uno Hot Clearer Gel',
      'category': 1,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1610705267928-1b9f2fa7f1c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 2,
      'label': 'Uno Hot Clearer Gel',
      'category': 1,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=556&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 3,
      'label': 'Uno Hot Clearer Gel',
      'category': 1,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=753&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 4,
      'label': 'Uno Hot Clearer Gel',
      'category': 1,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1615397349754-cfa2066a298e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 5,
      'label': 'Uno Hot Clearer Gel',
      'category': 1,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1567721913486-6585f069b332?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 6,
      'label': 'Uno Hot Clearer Gel',
      'category': 1,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1556227834-09f1de7a7d14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 7,
      'label': 'Uno Hot Clearer Gel',
      'category': 2,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1556228578-8c89e6adf883?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 8,
      'label': 'Uno Hot Clearer Gel',
      'category': 2,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1680320778399-1b7804686bf4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 9,
      'label': 'Uno Hot Clearer Gel',
      'category': 2,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1662020252056-929f908cd77d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 10,
      'label': 'Uno Hot Clearer Gel',
      'category': 2,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=465&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 11,
      'label': 'Uno Hot Clearer Gel',
      'category': 2,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 12,
      'label': 'Uno Hot Clearer Gel',
      'category': 2,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1661573161359-5039424a8c17?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 13,
      'label': 'Uno Hot Clearer Gel',
      'category': 3,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1610705267928-1b9f2fa7f1c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 14,
      'label': 'Uno Hot Clearer Gel',
      'category': 3,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=556&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 15,
      'label': 'Uno Hot Clearer Gel',
      'category': 3,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=753&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 16,
      'label': 'Uno Hot Clearer Gel',
      'category': 3,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1615397349754-cfa2066a298e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 17,
      'label': 'Uno Hot Clearer Gel',
      'category': 3,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1567721913486-6585f069b332?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 18,
      'label': 'Uno Hot Clearer Gel',
      'category': 3,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1556227834-09f1de7a7d14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 19,
      'label': 'Uno Hot Clearer Gel',
      'category': 4,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1556228578-8c89e6adf883?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 20,
      'label': 'Uno Hot Clearer Gel',
      'category': 4,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1680320778399-1b7804686bf4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 21,
      'label': 'Uno Hot Clearer Gel',
      'category': 4,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1662020252056-929f908cd77d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 22,
      'label': 'Uno Hot Clearer Gel',
      'category': 4,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=465&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 23,
      'label': 'Uno Hot Clearer Gel',
      'category': 4,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 24,
      'label': 'Uno Hot Clearer Gel',
      'category': 4,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1661573161359-5039424a8c17?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 25,
      'label': 'Uno Hot Clearer Gel',
      'category': 5,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1610705267928-1b9f2fa7f1c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 26,
      'label': 'Uno Hot Clearer Gel',
      'category': 5,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=556&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 27,
      'label': 'Uno Hot Clearer Gel',
      'category': 5,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=753&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 28,
      'label': 'Uno Hot Clearer Gel',
      'category': 5,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1615397349754-cfa2066a298e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 29,
      'label': 'Uno Hot Clearer Gel',
      'category': 5,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1567721913486-6585f069b332?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 30,
      'label': 'Uno Hot Clearer Gel',
      'category': 5,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1556227834-09f1de7a7d14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 31,
      'label': 'Uno Hot Clearer Gel',
      'category': 6,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1556228578-8c89e6adf883?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 32,
      'label': 'Uno Hot Clearer Gel',
      'category': 6,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1680320778399-1b7804686bf4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 33,
      'label': 'Uno Hot Clearer Gel',
      'category': 6,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1662020252056-929f908cd77d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 34,
      'label': 'Uno Hot Clearer Gel',
      'category': 6,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=465&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 35,
      'label': 'Uno Hot Clearer Gel',
      'category': 6,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
    {
      'id': 36,
      'label': 'Uno Hot Clearer Gel',
      'category': 6,
      'fixedPrice': 3.5,
      'discount': 0.2,
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1661573161359-5039424a8c17?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'usage':
          'Shampoo and conditioner serve two different purposes and while the duo pairs well, you don’t have to use them together every time you’re in the shower.Shampooing your hair can be done when you start to experience an excess of build up, unwanted oils, dirt, grime and or product build up.',
      'guidance': 'You may use shampoo and conditioner back to back but ensure your shampoo is rinsed out prior to applying your conditioner if you are looking for the best results.'
    },
  ];
}
