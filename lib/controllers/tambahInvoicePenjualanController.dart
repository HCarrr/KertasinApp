import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:kertasinapp/utilities/colors.dart';

class Barang {
  final String id;
  final String nama;
  final double harga;
  final int stok;

  Barang({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
  });

  factory Barang.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Barang(
      id: doc.id,
      nama: data['nama'] ?? '',
      harga: (data['harga'] ?? 0).toDouble(),
      stok: data['stok'] ?? 0,
    );
  }
}

class InvoiceItem {
  String nama;
  int jumlah;
  double harga;

  InvoiceItem({
    required this.nama,
    required this.jumlah,
    required this.harga,
  });
}

class TambahInvoicePenjualanController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  final items = <InvoiceItem>[].obs;
  final namaPelanggan = ''.obs;
  final tanggalInvoice = DateTime.now().obs;
  final nomorInvoice = ''.obs;
  final searchQuery = ''.obs;
  final searchResults = <Barang>[].obs;
  final isSearching = false.obs;
  final numberFormat = NumberFormat('#,##0', 'id_ID');

  @override
  void onInit() {
    super.onInit();
    generateInvoiceNumber();
  }

  void generateInvoiceNumber() {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyyMMdd-HHmmss');
    final dateStr = dateFormat.format(now);
    final random = Random().nextInt(10000).toString().padLeft(4, '0');
    nomorInvoice.value = 'INV-SALE-$dateStr-$random';
  }

  double get totalHarga =>
      items.fold(0, (sum, item) => sum + (item.harga * item.jumlah));

  String formatNumber(double number) {
    return numberFormat.format(number.floor()).replaceAll(',', '.');
  }

  Future<bool> addItem(InvoiceItem item) async {
    try {
      final querySnapshot = await _firestore
          .collection('barang')
          .where('nama', isEqualTo: item.nama)
          .where('uid', isEqualTo: currentUserId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        Get.snackbar(
          'Error',
          'Barang "${item.nama}" tidak ditemukan di database',
          backgroundColor: kColorFourth.withOpacity(0.8),
          colorText: kColorPureWhite,
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      final doc = querySnapshot.docs.first;
      final currentStock = (doc.data() as Map<String, dynamic>)['stok'] ?? 0;

      final existingIndex =
          items.indexWhere((element) => element.nama == item.nama);
      int totalQuantity = item.jumlah;

      if (existingIndex >= 0) {
        totalQuantity += items[existingIndex].jumlah;
      }

      if (totalQuantity > currentStock) {
        Get.snackbar(
          'Error',
          'Total jumlah barang (${totalQuantity}) melebihi stok yang tersedia (${currentStock})',
          backgroundColor: kColorFourth.withOpacity(0.8),
          colorText: kColorPureWhite,
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      if (existingIndex >= 0) {
        final existingItem = items[existingIndex];
        items[existingIndex] = InvoiceItem(
          nama: existingItem.nama,
          jumlah: existingItem.jumlah + item.jumlah,
          harga: existingItem.harga,
        );
      } else {
        items.add(item);
      }

      return true;
    } catch (e) {
      print('Error adding item: $e');
      Get.snackbar(
        'Error',
        'Gagal menambahkan barang: $e',
        backgroundColor: kColorFourth.withOpacity(0.8),
        colorText: kColorPureWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  Future<void> searchBarang(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    searchResults.clear();

    try {
      final querySnapshot = await _firestore
          .collection('barang')
          .where('uid', isEqualTo: currentUserId)
          .get();

      final allBarang =
          querySnapshot.docs.map((doc) => Barang.fromFirestore(doc)).toList();

      final filteredResults = allBarang
          .where((barang) =>
              barang.nama.toLowerCase().contains(query.trim().toLowerCase()))
          .toList();

      searchResults.assignAll(filteredResults);
    } catch (e) {
      print('Error searching products: $e');
      Get.snackbar(
        'Error',
        'Gagal mencari barang: $e',
        backgroundColor: kColorFourth.withOpacity(0.8),
        colorText: kColorPureWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSearching.value = false;
    }
  }

  Future<void> saveInvoice() async {
    try {
      generateInvoiceNumber();
      final invoiceNumber = nomorInvoice.value;

      final invoiceDoc =
          await _firestore.collection('invoices_penjualan').doc(invoiceNumber).get();
      if (invoiceDoc.exists) {
        Get.snackbar(
          'Error',
          'Nomor invoice "$invoiceNumber" sudah digunakan, coba lagi',
          backgroundColor: kColorFourth.withOpacity(0.8),
          colorText: kColorPureWhite,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      for (var item in items) {
        final querySnapshot = await _firestore
            .collection('barang')
            .where('nama', isEqualTo: item.nama)
            .where('uid', isEqualTo: currentUserId)
            .get();

        if (querySnapshot.docs.isEmpty) {
          Get.snackbar(
            'Error',
            'Barang "${item.nama}" tidak ditemukan di database',
            backgroundColor: kColorFourth.withOpacity(0.8),
            colorText: kColorPureWhite,
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        final doc = querySnapshot.docs.first;
        final currentStock = (doc.data() as Map<String, dynamic>)['stok'] ?? 0;

        if (item.jumlah > currentStock) {
          Get.snackbar(
            'Error',
            'Jumlah barang "${item.nama}" (${item.jumlah}) melebihi stok yang tersedia (${currentStock})',
            backgroundColor: kColorFourth.withOpacity(0.8),
            colorText: kColorPureWhite,
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }

      final batch = _firestore.batch();

      final invoiceData = {
        'nomorInvoice': invoiceNumber,
        'namaPelanggan': namaPelanggan.value,
        'tanggal': Timestamp.fromDate(tanggalInvoice.value),
        'totalItem': items.length,
        'totalHarga': totalHarga,
        'uid': currentUserId,
        'createdAt': FieldValue.serverTimestamp(),
        'items': items
            .map((item) => {
                  'nama': item.nama,
                  'jumlah': item.jumlah,
                  'harga': item.harga,
                  'subtotal': item.harga * item.jumlah,
                })
            .toList(),
      };

      final invoiceRef = _firestore.collection('invoices_penjualan').doc(invoiceNumber);
      batch.set(invoiceRef, invoiceData);

      for (var item in items) {
        final querySnapshot = await _firestore
            .collection('barang')
            .where('nama', isEqualTo: item.nama)
            .where('uid', isEqualTo: currentUserId)
            .get();

        if (querySnapshot.docs.isEmpty) {
          throw Exception(
              'Barang "${item.nama}" tidak ditemukan untuk memperbarui stok');
        }

        final barangRef = querySnapshot.docs.first.reference;
        batch.update(barangRef, {
          'stok': FieldValue.increment(-item.jumlah),
        });
      }

      await batch.commit();

      items.clear();
      namaPelanggan.value = '';
      tanggalInvoice.value = DateTime.now();
      generateInvoiceNumber();

      Get.back(result: true);

      Get.snackbar(
        'Sukses',
        'Invoice penjualan berhasil disimpan',
        backgroundColor: kColorThird.withOpacity(0.8),
        colorText: kColorPureWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error saving invoice: $e');
      Get.snackbar(
        'Error',
        'Gagal menyimpan invoice atau memperbarui stok: $e',
        backgroundColor: kColorFourth.withOpacity(0.8),
        colorText: kColorPureWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}