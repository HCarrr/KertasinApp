class BarangModel {
  final String id;
  final String nama;
  final int harga;
  final int stok;

  BarangModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
  });

  factory BarangModel.fromMap(Map<String, dynamic> map, String id) {
    return BarangModel(
      id: id,
      nama: map['nama'] ?? '',
      harga: map['harga'] ?? 0,
      stok: map['stok'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'harga': harga,
      'stok': stok,
    };
  }
}
