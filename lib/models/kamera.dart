import 'produk.dart';
import '../exception/data_invalid_exception.dart';

// Child class (Aksesoris)
class Kamera extends Produk {
  String _JenisKamera;
  int _resolusi;

  Kamera(String nama, double harga, int stok, this._JenisKamera, this._resolusi) : super(nama, harga, stok);

// -------- Getter ---------
  String get JenisKamera => _JenisKamera;
  int get resolusi => _resolusi;

// -------- Setter dengan validasi ---------
  set JenisKamera(String value) {
    if (value.isEmpty) {
      throw DataInvalidException('[!] Jenis Kamera tidak boleh kosong');
    }
    _JenisKamera = value;
  }

  set resolusi(int value) {
    if (value <= 0) {
      throw DataInvalidException('[!] Resolusi harus lebih dari 0');
    }
    _resolusi = value;
  }

  @override
  String get kategori => 'Kamera';

  @override
  void tampilkanInfo() {
    print("-"*60);
    print(' Info $kategori');
    print("-"*60);
    print(' Nama         : $nama');
    print(' Harga        : Rp${harga.toStringAsFixed(0)}');
    print(' Jenis Kamera : $JenisKamera');
    print(' Resolusi     : ${resolusi}MP');
    print(' Stok         : $stok');
    print("-"*60);
  }
}
