import 'package:project_midterms/models/voucher.dart';

List<Voucher> fnbVouchers = [
  Voucher(
    title: "Diskon 20% di Restoran Padang",
    cost: 600,
    image: 'lib/assets/voucher_images/fnb/Padang.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 30)),
    description:
        "Nikmati diskon 20% untuk semua hidangan di restoran Padang favoritmu. Minimal transaksi Rp 100.000.",
  ),
  Voucher(
    title: "Buy 1 Get 1 Kopi Susu",
    cost: 400,
    image: 'lib/assets/voucher_images/fnb/Kopi.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 7)),
    description:
        "Beli 1 Kopi Susu, gratis 1 lagi! Sempurna untuk dinikmati bersama teman.",
  ),
  Voucher(
    title: "Potongan Rp25.000 untuk Makanan Cepat Saji",
    cost: 800,
    image: 'lib/assets/voucher_images/fnb/makanancepat.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 14)),
    description:
        "Dapatkan potongan Rp 25.000 untuk pesanan makanan cepat saji di atas Rp 150.000.",
  ),
  Voucher(
    title: "Beli 2 gratis 1 untuk buah buahan",
    cost: 250,
    image: 'lib/assets/voucher_images/fnb/buah.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 3)),
    description:
        "Beli 2 jenis buah apa saja, dapatkan 1 buah gratis! Jaga kesehatan dengan buah segar setiap hari.",
  ),
  Voucher(
    title: "Diskon 30% untuk Kue",
    cost: 550,
    image: 'lib/assets/voucher_images/fnb/kue.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 10)),
    description:
        "Manjakan dirimu dengan diskon 30% untuk semua jenis kue. Cocok untuk merayakan momen spesial.",
  ),
  Voucher(
    title: "Potongan Rp15.000 untuk Makanan Ringan",
    cost: 350,
    image: 'lib/assets/voucher_images/fnb/makaroni.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 60)),
    description:
        "Jajan hemat dengan potongan Rp 15.000 untuk semua makanan ringan. Minimal pembelian Rp 50.000.",
  ),
];

List<Voucher> fashionVouchers = [
  Voucher(
    title: "Diskon 15% untuk pembelian Dress",
    cost: 700,
    image: 'lib/assets/voucher_images/fashion/dress.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 45)),
    description:
        "Tampil menawan dengan diskon 15% untuk semua koleksi dress terbaru.",
  ),
  Voucher(
    title: "Voucher Belanja Rp100.000 untuk Jas",
    cost: 1200,
    image: 'lib/assets/voucher_images/fashion/jas.jpg',
    requiredTier: 'Gold',
    expiryDate: DateTime.now().add(const Duration(days: 90)),
    description:
        "Eksklusif untuk member Gold! Dapatkan voucher belanja Rp 100.000 untuk pembelian jas.",
  ),
  Voucher(
    title: "Cashback 10% untuk Pembelian Sepatu",
    cost: 900,
    image: 'lib/assets/voucher_images/fashion/sepatu.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 30)),
    description:
        "Dapatkan cashback 10% untuk setiap pembelian sepatu. Melangkah lebih gaya dengan koleksi terbaru kami.",
  ),
  Voucher(
    title: "Diskon 25% untuk Aksesoris",
    cost: 450,
    image: 'lib/assets/voucher_images/fashion/aksesoris.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 20)),
    description: "Lengkapi gayamu dengan diskon 25% untuk semua aksesoris.",
  ),
  Voucher(
    title: "Buy 1 Get 1 untuk pembelian Kaos",
    cost: 600,
    image: 'lib/assets/voucher_images/fashion/kaos.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 15)),
    description:
        "Beli 1 kaos, gratis 1 kaos lagi! Pilih dari berbagai desain menarik.",
  ),
  Voucher(
    title: "Cashback 15% untuk Tas",
    cost: 850,
    image: 'lib/assets/voucher_images/fashion/tas.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 25)),
    description:
        "Dapatkan cashback 15% untuk semua koleksi tas. Tampil stylish setiap saat.",
  ),
];

List<Voucher> serviceVouchers = [
  Voucher(
    title: "Gratis Cuci Motor",
    cost: 300,
    image: 'lib/assets/voucher_images/service/cucimotor.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 5)),
    description:
        "Tukarkan poinmu dengan cuci motor gratis. Motor bersih, hati senang!",
  ),
  Voucher(
    title: "Potongan 20% Servis AC",
    cost: 1500,
    image: 'lib/assets/voucher_images/service/serviceac.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 60)),
    description:
        "Dapatkan potongan 20% untuk servis AC. Ruangan sejuk, aktivitas lancar.",
  ),
  Voucher(
    title: "Diskon 50% untuk Potong Rambut",
    cost: 500,
    image: 'lib/assets/voucher_images/service/potongrambut.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 10)),
    description:
        "Tampil beda dengan diskon 50% untuk potong rambut di salon mitra kami.",
  ),
  Voucher(
    title: "Gratis Cuci Mobil",
    cost: 500,
    image: 'lib/assets/voucher_images/service/cucimobil.jpg',
    requiredTier: 'Silver',
    expiryDate: DateTime.now().add(const Duration(days: 30)),
    description:
        "Khusus member Silver! Nikmati cuci mobil gratis di partner kami.",
  ),
  Voucher(
    title: "Potongan 30% Servis Laptop",
    cost: 2000,
    image: 'lib/assets/voucher_images/service/servislaptop.jpg',
    requiredTier: 'Platinum',
    expiryDate: DateTime.now().add(const Duration(days: 90)),
    description:
        "Member Platinum? Dapatkan potongan 30% untuk servis laptopmu. Performa laptop kembali maksimal.",
  ),
  Voucher(
    title: "Diskon 20% untuk spa",
    cost: 700,
    image: 'lib/assets/voucher_images/service/spa.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 40)),
    description:
        "Relaksasi tubuh dan pikiran dengan diskon 20% untuk semua perawatan spa.",
  ),
];

List<Voucher> othersVouchers = [
  Voucher(
    title: "Voucher Pulsa MyXL Rp10.000",
    cost: 200,
    image: 'lib/assets/voucher_images/others/pulsa.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 3)),
    description: "Isi ulang pulsa MyXL Rp 10.000 dengan menukarkan poinmu.",
  ),
  Voucher(
    title: "Diskon Tiket Bioskop 20%",
    cost: 800,
    image: 'lib/assets/voucher_images/others/tiket.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 14)),
    description: "Nonton film favoritmu dengan diskon 20% di semua bioskop.",
  ),
  Voucher(
    title: "Gratis 1 Jam Bermain di Game Center",
    cost: 1000,
    image: 'lib/assets/voucher_images/others/game.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 30)),
    description:
        "Seru-seruan bareng teman dengan gratis 1 jam bermain di game center.",
  ),
  Voucher(
    title: "Buy 1 get 1 tiket Dufan ",
    cost: 1250,
    image: 'lib/assets/voucher_images/others/dufan.jpg',
    requiredTier: 'Silver',
    expiryDate: DateTime.now().add(const Duration(days: 60)),
    description:
        "Spesial untuk member Silver! Beli 1 tiket Dufan, gratis 1 tiket lagi.",
  ),
  Voucher(
    title: "Diskon Tiket Konser 15%",
    cost: 300,
    image: 'lib/assets/voucher_images/others/konser.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 7)),
    description:
        "Jangan lewatkan konser idolamu! Dapatkan diskon 15% untuk tiket konser.",
  ),
  Voucher(
    title: "Gratis 2 Jam Karaoke",
    cost: 600,
    image: 'lib/assets/voucher_images/others/karaoke.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 20)),
    description:
        "Nyanyi sepuasnya! Gratis 2 jam karaoke di tempat karaoke favoritmu.",
  ),
];

List<Voucher> electronicAndAppliancesVouchers = [
  Voucher(
    title: "Diskon 15% untuk TV",
    cost: 2500,
    image: 'lib/assets/voucher_images/electronics/tv.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 60)),
    description:
        "Upgrade TV-mu dengan diskon 15%. Nonton lebih seru dengan kualitas gambar terbaik.",
  ),
  Voucher(
    title: "Potongan Rp200.000 untuk Kulkas",
    cost: 3000,
    image: 'lib/assets/voucher_images/electronics/kulkas.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 90)),
    description:
        "Dapatkan potongan Rp 200.000 untuk pembelian kulkas baru. Makanan lebih awet, tagihan listrik lebih hemat.",
  ),
  Voucher(
    title: "Cashback 13% untuk Mesin Cuci",
    cost: 2000,
    image: 'lib/assets/voucher_images/electronics/mesincuci.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 45)),
    description:
        "Cuci baju lebih mudah dengan cashback 13% untuk semua mesin cuci.",
  ),
  Voucher(
    title: "Gratis Ongkir untuk Pembelian AC",
    cost: 1000,
    image: 'lib/assets/voucher_images/electronics/acgratis.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 30)),
    description:
        "Nikmati gratis ongkir untuk pembelian AC. Ruangan sejuk tanpa biaya tambahan.",
  ),
  Voucher(
    title: "Voucher Belanja Rp150.000 untuk pembelian Headset",
    cost: 1800,
    image: 'lib/assets/voucher_images/electronics/headset.jpg',
    expiryDate: DateTime.now().add(const Duration(days: 60)),
    description:
        "Dengarkan musik favoritmu dengan kualitas suara terbaik. Dapatkan voucher belanja Rp 150.000 untuk pembelian headset.",
  ),
  Voucher(
    title: "Diskon 1% iPhone 300 PRO Max+++++",
    cost: 10000000,
    image: 'lib/assets/voucher_images/electronics/iphone.jpg',
    requiredTier: 'Diamond',
    expiryDate: DateTime.now().add(const Duration(days: 365)),
    description:
        "Kesempatan langka! Dapatkan diskon 1% untuk iPhone 300 PRO Max+++++. Hanya untuk member Diamond.",
  ),
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
