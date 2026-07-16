import 'dart:io';
import '../models/produk.dart';
import '../models/kamera.dart';
import '../models/laptop.dart';
import '../models/smartphone.dart';

class Admin {
  // Collection 1 (List)
  // menggunakan final karena tidak akan berubah (tidak ada fitur edit)
  final List<Produk> _produkList = [];

  // Collection 2 (Map)
  final Map<String, int> _totalPerKategori = {};

  get produkList => _produkList;
  get totalPerKategori => _totalPerKategori;

// Fitur 1 (Tambah Produk) - menggunakan async dan await untuk membuat simulasi loading
  Future<void> tambahProduk() async {  
     print("="*60);
     print(" Tambah Produk Baru");
     print("="*60);

     print(" Kategori Produk  :");
     print(" 1. Smartphone");
     print(" 2. Laptop");
     print(" 3. Kamera");
     print("-"*60);
     stdout.write(" Pilih kategori produk (1-3) : ");
     var inputUser = stdin.readLineSync() ?? '';
     print("-"*60);


     stdout.write(" Nama Produk   : ");
     String nama = stdin.readLineSync() ?? '';

     stdout.write(" Harga Produk  : ");
     double harga = double.tryParse(stdin.readLineSync() ?? '') ?? -1;

     stdout.write(" Stok Produk   : ");
     int stok = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

     Produk? produk;

     switch (inputUser) {
       case '1':
         stdout.write(" Chipset       : ");
         String chipset = stdin.readLineSync() ?? '';

         stdout.write(" RAM (GB)      : ");
         int ram = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

         stdout.write(" ROM (GB)      : ");
         int rom = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

         produk = Smartphone(nama, harga, stok, chipset, ram, rom);
         break;

       case '2':
         stdout.write(" Processor     : ");
         String processor = stdin.readLineSync() ?? '';

         stdout.write(" RAM (GB)      : ");
         int ram = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

         produk = Laptop(nama, harga, stok, processor, ram);
         break;

       case '3':
         stdout.write(" Jenis Kamera  : ");
         String jenisKamera = stdin.readLineSync() ?? '';

         stdout.write(" Resolusi (MP) : ");
         int resolusiKamera = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

         produk = Kamera(nama, harga, stok, jenisKamera, resolusiKamera);
         break;

       default:
         print(" Pilihan tidak valid. Silakan pilih 1-3.");
         return;
     }

    print("\n Menambahkan Data ke database...");
    await Future.delayed(Duration(seconds: 2));

    produkList.add(produk);
    totalPerKategori.update(
      produk.kategori,
      (int value) => value + 1,
      ifAbsent: () => 1,
    );

    print(' Produk "${produk.nama}" berhasil ditambahkan.');
  } 

// Fitur 2 (Lihat Inventaris)
  void tampilkanInventaris() {
    if (produkList.isEmpty) {
      print(' [!] Tidak ada produk dalam inventaris.');
      return;
    } 
    print("="*60);
    print(' Daftar Inventaris');
    print("="*60);
    for (var produk in _produkList) {
      produk.tampilkanInfo();
    }

    print("-"*60);
    print(' Total Per Kategori');
    print("-"*60);
    totalPerKategori.forEach((kategori, jumlah) {
      print(' - $kategori : $jumlah');
    });
    print("-"*60);

// Higher Order Function (any) untuk cek apakah ada produk dengan stok <= 3
  bool stokMenipisAlert = produkList.any((Produk p) => p.stok <= 3);
  if (stokMenipisAlert) {
    print('\n [!] ada produk dengan stok menipis (<= 3)!');
  }

// Higher Order Function (every) untuk cek apakah semua produk masih tersedia
  bool semuaTersedia = produkList.every((Produk p) => p.stok > 0);
  print(semuaTersedia ? " Semua Produk masih tersedia." : " Ada produk yang stoknnya habis.");
}

// Fitur 3 (Cari Produk)
  void cariProduk(String keyword) {
    var hasil = produkList.where((Produk produk) => produk.nama.toLowerCase().contains(keyword.toLowerCase()));
    if (hasil.isEmpty) {
      print(' [!] Produk dengan keyword "$keyword" tidak ditemukan.');
      return;
    }

    print("="*60);
    print(' Hasil Pencarian');
    print("="*60);
    for (var produk in hasil) {
      produk.tampilkanInfo();
    }
  }

// Fitur 4 (hitung total)
double hitungTotalNilaiInventaris() {
  // HOF (.fold) untuk menghitung total nilai inventaris
  return produkList.fold(0.0, (total, produk) => total + produk.nilaiTotal);
}

void tampilkanTotalNilaiInventaris() {
  // HOF (.map) untuk mengambil daftar nama produk
  var daftarNama = produkList.map((produk) => produk.nama).toList();
  var total = hitungTotalNilaiInventaris();

  print("="*60);
  print(' Total Nilai Inventaris');
  print("="*60);

  print("-"*60);
  print(' Daftar Nama Produk');
  print("-"*60);
  for (var nama in daftarNama) {
    print('- $nama');
  }
  print("-"*60);
  print(' Total Nilai Inventaris : Rp${total.toStringAsFixed(0)}');
  print("-"*60);
}
}
   
  
