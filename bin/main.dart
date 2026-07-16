import 'dart:io';
import '../lib/controllers/admin.dart';
import '../lib/exception/data_invalid_exception.dart';

final Admin admin = Admin();

void main() async {
  bool running = true;

  while (running) {
    print("");
    print("="*60);
    print("    Selamat datang di Sistem Inventaris Toko Elektronik");
    print("="*60);
    print(" Menu Utama:");
    print(" 1. Tambah Produk");
    print(" 2. Tampilkan Inventaris");
    print(" 3. Cari Produk");
    print(" 4. Hitung Total Nilai Inventaris");
    print(" 5. Keluar");
    print("="*60);
    stdout.write(" Pilih menu (1-5) : ");
    var userInput = stdin.readLineSync();
    print("="*60);
    print("");

    try {
      switch (userInput) {
        case '1':
          await admin.tambahProduk();
          break;
        case '2':
          admin.tampilkanInventaris();
          break;
        case '3':
          cariProduk();
          break;
        case '4':
          admin.tampilkanTotalNilaiInventaris();
          break;
        case '5':
          print(" System Shutdown...");
          await Future.delayed(Duration(seconds: 2));
          running = false;
          break;
        default :
        print(" Pilihan tidak valid. Silakan pilih 1-5.");
      }
    } on DataInvalidException catch (e) {
      // untuk error validasi data
      print(e.toString());
    } catch (e) {
      // untuk error lainnya
      print(" Terjadi kesalahan: $e");
    }
  } 
}

// SubMenu (Cari Produk)
void cariProduk() {
  print("="*60);
  print(" Cari Produk");
  print("="*60);
  stdout.write(" Masukkan kata kunci nama Produk : ");
  String keyword = stdin.readLineSync() ?? '';

  if (keyword.trim().isEmpty) {
    throw DataInvalidException(' [!] Kata kunci tidak boleh kosong.'); 
  }
  admin.cariProduk(keyword);
}
