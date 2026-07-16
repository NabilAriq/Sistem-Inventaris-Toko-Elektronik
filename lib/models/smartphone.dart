import 'produk.dart';
import '../exception/data_invalid_exception.dart';

// Child class (Smartphone)
class Smartphone extends Produk {
  String _chipset;
  int _ram;
  int _rom;

  Smartphone(String nama, double harga, int stok, this._chipset, this._ram, this._rom) : super(nama, harga, stok);

// -------- Getter ---------
  String get chipset => _chipset;
  int get ram => _ram;
  int get rom => _rom;

// -------- Setter dengan validasi ---------
  set chipset(String value) {
    if (value.isEmpty) {
      throw DataInvalidException('[!] Chipset tidak boleh kosong');
    }
    _chipset = value;
  }

  set ram(int value) {
    if (value <= 0) {
      throw DataInvalidException('[!] RAM harus lebih dari 0');
    }
    _ram = value;
  }

  set rom(int value) {
    if (value <= 0) {
      throw DataInvalidException('[!] ROM harus lebih dari 0');
    }
    _rom = value;
  }

  @override
  String get kategori => 'Smartphone';

  @override
  void tampilkanInfo() {
    print("-"*60);
    print(' Info $kategori');
    print("-"*60);
    print(' Nama    : $nama');
    print(' Harga   : Rp${harga.toStringAsFixed(0)}');
    print(' Chipset : $chipset');
    print(' RAM     : ${ram}GB');
    print(' ROM     : ${rom}GB');
    print(' Stok    : $stok');
    print("-"*60);
  }
  
}