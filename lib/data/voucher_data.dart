import 'package:project_midterms/models/voucher.dart';

List<Voucher> fnbVouchers = [
  Voucher(title: "Diskon 20% di Restoran Padang", cost: 600, image: 'lib/assets/voucher_images/fnb/Padang.jpg'),
  Voucher(title: "Buy 1 Get 1 Kopi Susu", cost: 400, image: 'lib/assets/voucher_images/fnb/Kopi.jpg'),
  Voucher(title: "Potongan Rp25.000 untuk Makanan Cepat Saji", cost: 800, image: 'lib/assets/voucher_images/fnb/makanancepat.jpg'),
  Voucher(title: "Beli 2 gratis 1 untuk buah buahan", cost: 250, image: 'lib/assets/voucher_images/fnb/buah.jpg'),
  Voucher(title: "Diskon 30% untuk Kue", cost: 550, image: 'lib/assets/voucher_images/fnb/kue.jpg'),
  Voucher(title: "Potongan Rp15.000 untuk Makanan Ringan", cost: 350, image: 'lib/assets/voucher_images/fnb/makaroni.jpg'),
];

List<Voucher> fashionVouchers = [
  Voucher(title: "Diskon 15% untuk pembelian Dress", cost: 700, image: 'lib/assets/voucher_images/fashion/dress.jpg'),
  Voucher(title: "Voucher Belanja Rp100.000 untuk Jas", cost: 1200, image: 'lib/assets/voucher_images/fashion/jas.jpg'),
  Voucher(title: "Cashback 10% untuk Pembelian Sepatu", cost: 900, image: 'lib/assets/voucher_images/fashion/sepatu.jpg'),
  Voucher(title: "Diskon 25% untuk Aksesoris", cost: 450, image: 'lib/assets/voucher_images/fashion/aksesoris.jpg'),
  Voucher(title: "Buy 1 Get 1 untuk pembelian Kaos", cost: 600, image: 'lib/assets/voucher_images/fashion/kaos.jpg'),
  Voucher(title: "Cashback 15% untuk Tas", cost: 850, image: 'lib/assets/voucher_images/fashion/tas.jpg'),
];

List<Voucher> serviceVouchers = [
  Voucher(title: "Gratis Cuci Motor", cost: 300, image: 'lib/assets/voucher_images/service/cucimotor.jpg'),
  Voucher(title: "Potongan 20% Servis AC", cost: 1500, image: 'lib/assets/voucher_images/service/serviceac.jpg'),
  Voucher(title: "Diskon 50% untuk Potong Rambut", cost: 500, image: 'lib/assets/voucher_images/service/potongrambut.jpg'),
  Voucher(title: "Gratis Cuci Mobil", cost: 500, image: 'lib/assets/voucher_images/service/cucimobil.jpg'),
  Voucher(title: "Potongan 30% Servis Laptop", cost: 2000, image: 'lib/assets/voucher_images/service/servislaptop.jpg'),
  Voucher(title: "Diskon 20% untuk spa", cost: 700, image: 'lib/assets/voucher_images/service/spa.jpg'),
];

List<Voucher> othersVouchers = [
  Voucher(title: "Voucher Pulsa Rp10.000", cost: 200, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Diskon Tiket Bioskop", cost: 800, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Gratis 1 Jam Bermain di Game Center", cost: 1000, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Voucher Pulsa Rp25.000", cost: 450, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Diskon Tiket Konser", cost: 1500, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Gratis 2 Jam Karaoke", cost: 1200, image: 'lib/assets/voucher_images/komodo.jpg'),
];

List<Voucher> electronicAndAppliancesVouchers = [
  Voucher(title: "Diskon 10% untuk TV", cost: 2500, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Potongan Rp200.000 untuk Kulkas", cost: 3000, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Cashback 5% untuk Mesin Cuci", cost: 2000, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Gratis Ongkir untuk Pembelian AC", cost: 1000, image: 'lib/assets/voucher_images/komodo.jpg'),
  Voucher(title: "Voucher Belanja Elektronik Rp150.000", cost: 1800, image: 'lib/assets/voucher_images/komodo.jpg'),
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
