import 'produk.dart';
import '../exception/data_invalid_exception.dart';

class Laptop extends Produk {
  String _processor;
  int _ram;

  Laptop(String nama, double harga, int stok, this._processor, this._ram) : super(nama, harga, stok);

  String get processor => _processor;
  int get ram => _ram;

  set processor(String value) {
    if (value.isEmpty) {
      throw DataInvalidException('[!] Processor tidak boleh kosong');
    }
    _processor = value;
  }

  set ram(int value) {
    if (value <= 0) {
      throw DataInvalidException('[!] RAM harus lebih dari 0');
    }
    _ram = value;
  }

  @override
  String get kategori => 'Laptop';

  @override
  void tampilkanInfo() {
    print("-"*60);
    print(' Info $kategori');
    print("-"*60);
    print(' Nama      : $nama');
    print(' Harga     : Rp${harga.toStringAsFixed(0)}');
    print(' Processor : $processor');
    print(' RAM       : ${ram}GB');
    print(' Stok      : $stok');
    print("-"*60);
  }
}