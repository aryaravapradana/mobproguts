import 'package:project_midterms/models/voucher.dart';

List<Voucher> fnbVouchers = [
  Voucher(title: "Diskon 20% di Restoran Padang", cost: 600, image: 'lib/assets/voucher_images/fnb/Padang.jpg', expiryDate: DateTime.now().add(const Duration(days: 30))),
  Voucher(title: "Buy 1 Get 1 Kopi Susu", cost: 400, image: 'lib/assets/voucher_images/fnb/Kopi.jpg', expiryDate: DateTime.now().add(const Duration(days: 7))),
  Voucher(title: "Potongan Rp25.000 untuk Makanan Cepat Saji", cost: 800, image: 'lib/assets/voucher_images/fnb/makanancepat.jpg', expiryDate: DateTime.now().add(const Duration(days: 14))),
  Voucher(title: "Beli 2 gratis 1 untuk buah buahan", cost: 250, image: 'lib/assets/voucher_images/fnb/buah.jpg', expiryDate: DateTime.now().add(const Duration(days: 3))),
  Voucher(title: "Diskon 30% untuk Kue", cost: 550, image: 'lib/assets/voucher_images/fnb/kue.jpg', expiryDate: DateTime.now().add(const Duration(days: 10))),
  Voucher(title: "Potongan Rp15.000 untuk Makanan Ringan", cost: 350, image: 'lib/assets/voucher_images/fnb/makaroni.jpg', expiryDate: DateTime.now().add(const Duration(days: 60))),
];

List<Voucher> fashionVouchers = [
  Voucher(title: "Diskon 15% untuk pembelian Dress", cost: 700, image: 'lib/assets/voucher_images/fashion/dress.jpg', expiryDate: DateTime.now().add(const Duration(days: 45))),
  Voucher(title: "Voucher Belanja Rp100.000 untuk Jas", cost: 1200, image: 'lib/assets/voucher_images/fashion/jas.jpg', requiredTier: 'Gold', expiryDate: DateTime.now().add(const Duration(days: 90))),
  Voucher(title: "Cashback 10% untuk Pembelian Sepatu", cost: 900, image: 'lib/assets/voucher_images/fashion/sepatu.jpg', expiryDate: DateTime.now().add(const Duration(days: 30))),
  Voucher(title: "Diskon 25% untuk Aksesoris", cost: 450, image: 'lib/assets/voucher_images/fashion/aksesoris.jpg', expiryDate: DateTime.now().add(const Duration(days: 20))),
  Voucher(title: "Buy 1 Get 1 untuk pembelian Kaos", cost: 600, image: 'lib/assets/voucher_images/fashion/kaos.jpg', expiryDate: DateTime.now().add(const Duration(days: 15))),
  Voucher(title: "Cashback 15% untuk Tas", cost: 850, image: 'lib/assets/voucher_images/fashion/tas.jpg', expiryDate: DateTime.now().add(const Duration(days: 25))),
];

List<Voucher> serviceVouchers = [
  Voucher(title: "Gratis Cuci Motor", cost: 300, image: 'lib/assets/voucher_images/service/cucimotor.jpg', expiryDate: DateTime.now().add(const Duration(days: 5))),
  Voucher(title: "Potongan 20% Servis AC", cost: 1500, image: 'lib/assets/voucher_images/service/serviceac.jpg', expiryDate: DateTime.now().add(const Duration(days: 60))),
  Voucher(title: "Diskon 50% untuk Potong Rambut", cost: 500, image: 'lib/assets/voucher_images/service/potongrambut.jpg', expiryDate: DateTime.now().add(const Duration(days: 10))),
  Voucher(title: "Gratis Cuci Mobil", cost: 500, image: 'lib/assets/voucher_images/service/cucimobil.jpg', requiredTier: 'Silver', expiryDate: DateTime.now().add(const Duration(days: 30))),
  Voucher(title: "Potongan 30% Servis Laptop", cost: 2000, image: 'lib/assets/voucher_images/service/servislaptop.jpg', requiredTier: 'Platinum', expiryDate: DateTime.now().add(const Duration(days: 90))),
  Voucher(title: "Diskon 20% untuk spa", cost: 700, image: 'lib/assets/voucher_images/service/spa.jpg', expiryDate: DateTime.now().add(const Duration(days: 40))),
];

List<Voucher> othersVouchers = [
  Voucher(title: "Voucher Pulsa MyXL Rp10.000", cost: 200, image: 'lib/assets/voucher_images/others/pulsa.jpg', expiryDate: DateTime.now().add(const Duration(days: 3))),
  Voucher(title: "Diskon Tiket Bioskop 20%", cost: 800, image: 'lib/assets/voucher_images/others/tiket.jpg', expiryDate: DateTime.now().add(const Duration(days: 14))),
  Voucher(title: "Gratis 1 Jam Bermain di Game Center", cost: 1000, image: 'lib/assets/voucher_images/others/game.jpg', expiryDate: DateTime.now().add(const Duration(days: 30))),
  Voucher(title: "Buy 1 get 1 tiket Dufan ", cost: 1250, image: 'lib/assets/voucher_images/others/dufan.jpg', requiredTier: 'Silver', expiryDate: DateTime.now().add(const Duration(days: 60))),
  Voucher(title: "Diskon Tiket Konser 15%", cost: 300, image: 'lib/assets/voucher_images/others/konser.jpg', expiryDate: DateTime.now().add(const Duration(days: 7))),
  Voucher(title: "Gratis 2 Jam Karaoke", cost: 600, image: 'lib/assets/voucher_images/others/karaoke.jpg', expiryDate: DateTime.now().add(const Duration(days: 20))),
];

List<Voucher> electronicAndAppliancesVouchers = [
  Voucher(title: "Tiket Liburan ke Bali", cost: 5000, image: 'lib/assets/voucher_images/others/dufan.jpg', requiredTier: 'Diamond', expiryDate: DateTime.now().add(const Duration(days: 180))),
  Voucher(title: "Diskon 15% untuk TV", cost: 2500, image: 'lib/assets/voucher_images/electronics/tv.jpg', expiryDate: DateTime.now().add(const Duration(days: 60))),
  Voucher(title: "Potongan Rp200.000 untuk Kulkas", cost: 3000, image: 'lib/assets/voucher_images/electronics/kulkas.jpg', expiryDate: DateTime.now().add(const Duration(days: 90))),
  Voucher(title: "Cashback 13% untuk Mesin Cuci", cost: 2000, image: 'lib/assets/voucher_images/electronics/mesincuci.jpg', expiryDate: DateTime.now().add(const Duration(days: 45))),
  Voucher(title: "Gratis Ongkir untuk Pembelian AC", cost: 1000, image: 'lib/assets/voucher_images/electronics/acgratis.jpg', expiryDate: DateTime.now().add(const Duration(days: 30))),
  Voucher(title: "Voucher Belanja Rp150.000 untuk pembelian Headset", cost: 1800, image: 'lib/assets/voucher_images/electronics/headset.jpg', expiryDate: DateTime.now().add(const Duration(days: 60))),
  Voucher(title: "Diskon 1% iPhone 300 PRO Max+++++", cost: 10000000, image: 'lib/assets/voucher_images/electronics/iphone.jpg', requiredTier: 'Diamond', expiryDate: DateTime.now().add(const Duration(days: 365))),
];

Map<String, List<Voucher>> categorizedVouchers = {
  'FnB': fnbVouchers,
  'Fashion': fashionVouchers,
  'Service': serviceVouchers,
  'Others': othersVouchers,
  'Electronic & Appliances': electronicAndAppliancesVouchers,
};

List<Voucher> dummyVouchers = [
  ...fnbVouchers,
  ...fashionVouchers,
  ...serviceVouchers,
  ...othersVouchers,
  ...electronicAndAppliancesVouchers,
];
