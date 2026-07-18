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
5. **Export ke CSV (Excel)** — meng-export seluruh data produk ke file CSV
   yang bisa langsung dibuka di Excel / Google Sheets. File otomatis
   tersimpan di folder `exports/` dengan nama yang mengandung timestamp
   (misal `exports/data_inventaris_2026-07-18_143022.csv`), sehingga hasil
   export sebelumnya tidak akan tertimpa.
6. **Keluar** — mengakhiri program.

note :
untuk fitur simpan data, saya jadikan satu di fitur tambah data agar lebih efektif, karena setiap penambahan data akan otomatis tersimpan.

## Cara Menjalankan Program

Ada 2 cara untuk menjalankan program ini:

### Opsi A — Menjalankan langsung dengan Dart SDK
1. Pastikan Dart SDK sudah terinstall di komputer.
   Cek pada terminal dengan perintah:
   ```
   dart --version
   ```
2. Clone atau download project ini, lalu masuk ke folder project:
   ```
   git clone https://github.com/NabilAriq/Sistem-Inventaris-Toko-Elektronik
   cd Sistem-Inventaris-Toko-Elektronik
   ```
3. Jalankan program dengan perintah:
   ```
   dart run bin/main.dart
   ```
4. Program akan menampilkan menu di terminal. Pilih angka 1-6 sesuai
   fitur yang ingin digunakan, lalu ikuti instruksi input yang muncul.

### Opsi B — Menjalankan sebagai file executable (.exe)
Cara ini menghasilkan file program mandiri yang bisa dijalankan **tanpa perlu
Dart SDK terinstall**, cocok untuk dibagikan ke komputer lain.

1. Compile program menjadi file executable:
   ```
   dart compile exe bin/main.dart -o toko_elektronik.exe
   ```
2. Jalankan file hasil compile:
   - **Windows:**
     ```
     toko_elektronik.exe
     ```
   - **Linux / macOS:**
     ```
     ./toko_elektronik.exe
     ```

> Catatan: file `.exe` hasil compile bersifat khusus per sistem operasi.
> File yang di-compile di Windows hanya bisa dijalankan di Windows, begitu
> juga untuk Linux/macOS. Jika ingin menjalankan di OS lain, lakukan compile
> ulang di OS yang bersangkutan.