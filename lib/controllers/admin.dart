import 'dart:io';
import '../models/produk.dart';
import '../models/kamera.dart';
import '../models/laptop.dart';
import '../models/smartphone.dart';
import '../exception/data_invalid_exception.dart';


class Admin {
  // Collection 1 (List)
  // menggunakan final karena tidak akan berubah (tidak ada fitur edit)
  final List<Produk> _produkList = [];

  // Collection 2 (Map)
  final Map<String, int> _totalPerKategori = {};

  List<Produk> get produkList => _produkList;
  Map<String, int> get totalPerKategori => _totalPerKategori;

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

    // Validasi input
    if (nama.trim().isEmpty) {
      print(" [!] Gagal: Nama produk tidak boleh kosong.");
      return;
    }
    if (harga < 0) {
      print(" [!] Gagal: Harga produk tidak boleh negatif.");
      return;
    }
    if (stok < 0) {
      print(" [!] Gagal: Stok produk tidak boleh negatif.");
      return;
    }

    Produk? produk;

  try {
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
    } on DataInvalidException catch (e) {
      print(e.toString());
      return;
    } catch (e) {
      print(" Terjadi kesalahan: $e");
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


// Fitur 5 (Export ke CSV/Excel)
Future<void> exportKeCsv({String namaFile = 'data_inventaris.csv'}) async {
  if (produkList.isEmpty) {
    print(' [!] Tidak ada produk untuk di-export.');
    return;
  }

  // Membungkus value yang mengandung koma dengan string agar CSV tidak rusak
  String amankan(String value) => value.contains(',') ? '"$value"' : value;

  final buffer = StringBuffer();
  buffer.writeln('Nama,Kategori,Harga,Stok,Nilai Total');

  for (var produk in produkList) {
    buffer.writeln([
      amankan(produk.nama),
      produk.kategori,
      produk.harga.toStringAsFixed(0),
      produk.stok,
      produk.nilaiTotal.toStringAsFixed(0),
    ].join(','));
  }

  print("="*60);
  print(' Export Data ke CSV');
  print("="*60);
  print(' Menyimpan data ke file...');
  await Future.delayed(Duration(seconds: 2));

  // Membuat folder exports otomatis jika belum ada
  final folderExport = Directory('exports');
  if (!await folderExport.exists()) {
    await folderExport.create(recursive: true);
  }

  // Nama file unik dengan timestamp agar export sebelumnya tidak tertimpa
  final now = DateTime.now();
  String dua(int angka) => angka.toString().padLeft(2, '0');
  final timestamp = '${now.year}-${dua(now.month)}-${dua(now.day)}_${dua(now.hour)}${dua(now.minute)}${dua(now.second)}';
  final namaFile = 'exports/data_inventaris_$timestamp.csv';

  final file = File(namaFile);
  await file.writeAsString(buffer.toString());

  print(' Data berhasil di-export ke file "$namaFile"');
  print(' File dapat langsung dibuka dengan Excel / Google Sheets.');
  print("-"*60);
}
}
   


   
  
