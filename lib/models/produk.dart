import '../exception/data_invalid_exception.dart';

// Parent class (Produk)
abstract class Produk {
  String _nama;
  double _harga;
  int _stok;

  Produk(this._nama, this._harga, this._stok);

// -------- Getter ---------
  String get nama => _nama;
  double get harga => _harga;
  int get stok => _stok;

// -------- Setter dengan validasi ---------
  set nama(String value) {
    if (value.isEmpty) {
      throw DataInvalidException('[!] Nama tidak boleh kosong');
    }
    _nama = value;
  }

  set harga(double value) {
    if (value <= 0) {
      throw DataInvalidException('[!] Harga harus lebih dari 0');
    }
    _harga = value;
  }

  set stok(int value) {
    if (value < 0) {
      throw DataInvalidException('[!] Stok tidak boleh negatif');
    }
    _stok = value;
  }

  String get kategori;

  // Nilai Total (untuk hitung total inventaris)
  double get nilaiTotal => harga * stok;

  // polymorphism (abstract method, wajib override di subclass)
  void tampilkanInfo();
}


