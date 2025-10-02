import 'package:project_midterms/models/voucher.dart';

List<Voucher> fnbVouchers = [
  Voucher(title: "Diskon 20% di Restoran Padang", cost: 600),
  Voucher(title: "Buy 1 Get 1 Kopi Susu", cost: 400),
  Voucher(title: "Potongan Rp25.000 untuk Makanan Cepat Saji", cost: 800),
];

List<Voucher> fashionVouchers = [
  Voucher(title: "Diskon 15% di Toko Pakaian", cost: 700),
  Voucher(title: "Voucher Belanja Rp100.000", cost: 1200),
  Voucher(title: "Cashback 10% untuk Pembelian Sepatu", cost: 900),
];

List<Voucher> serviceVouchers = [
  Voucher(title: "Gratis Cuci Motor", cost: 300),
  Voucher(title: "Potongan Harga Servis AC", cost: 1500),
  Voucher(title: "Diskon 50% untuk Potong Rambut", cost: 500),
];

List<Voucher> othersVouchers = [
  Voucher(title: "Voucher Pulsa Rp10.000", cost: 200),
  Voucher(title: "Diskon Tiket Bioskop", cost: 800),
  Voucher(title: "Gratis 1 Jam Bermain di Game Center", cost: 1000),
];

Map<String, List<Voucher>> categorizedVouchers = {
  'FnB': fnbVouchers,
  'Fashion': fashionVouchers,
  'Service': serviceVouchers,
  'Others': othersVouchers,
};

List<Voucher> dummyVouchers = [
  ...fnbVouchers,
  ...fashionVouchers,
  ...serviceVouchers,
  ...othersVouchers,
];