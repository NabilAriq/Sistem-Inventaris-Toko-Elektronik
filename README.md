# Sistem Toko Elektronik — Aplikasi CLI (Command Line Interface)
# UAS Pemrograman Berorientasi Objek (Dart)

## Nama dan NIM
- Nama : Muhammad Nabil 'Ariq
- NIM  : 251240001641

## Tema Aplikasi
Sistem Toko Elektronik — aplikasi CLI (Command Line Interface) untuk mengelola
data produk elektronik yang dijual di sebuah toko, meliputi kategori Laptop,
Smartphone, dan Aksesoris.

## Fitur Program
1. **Tambah Data** — menambahkan produk baru (Laptop, Smartphone, atau Aksesoris)
   lengkap dengan validasi input (nama tidak boleh kosong, harga & stok tidak
   boleh negatif).
2. **Lihat Semua Data** — menampilkan seluruh produk yang tersimpan, jumlah
   produk per kategori, serta peringatan jika ada stok yang menipis.
3. **Cari Data** — mencari produk berdasarkan kata kunci nama.
4. **Hitung Total** — menampilkan jumlah total produk dan total nilai
   inventaris (harga x stok seluruh produk).
5. **Keluar** — mengakhiri program.

note :
untuk fitur simpan data, saya jadikan satu di fitur tambah data agar lebih efektif, karena setiap penambahan data akan otomatis tersimpan.

## Cara Menjalankan Program
1. Pastikan Dart SDK sudah terinstall di komputer.
   Cek pada terminal dengan perintah:
   ```
   dart --version
   ```
2. Clone atau download project ini, lalu masuk ke folder project:
   ```
   git clone https://github.com/NabilAriq/Sistem-Inventaris-Toko-Elektronik
   cd project_uas_toko_elektronik
   ```
3. Jalankan program dengan perintah:
   ```
   dart run bin/main.dart
   ```
4. Program akan menampilkan menu di terminal. Pilih angka 1-6 sesuai
   fitur yang ingin digunakan, lalu ikuti instruksi input yang muncul.
