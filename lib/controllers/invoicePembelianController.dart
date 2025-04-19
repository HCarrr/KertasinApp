import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kertasinapp/utilities/colors.dart';

class InvoicePembelianController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  final invoices = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;
  late final DateFormat dateFormat;
  final numberFormat = NumberFormat('#,##0', 'id_ID');
  StreamSubscription<QuerySnapshot>? _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    print('Initializing InvoicePembelianController with user ID: $currentUserId');
    await initializeDateFormatting('id_ID', null);
    dateFormat = DateFormat('dd - MM - yyyy', 'id_ID');
    _startStream();
  }

  void _startStream() {
    print('Starting Firestore stream for invoices_pembelian');
    _streamSubscription?.cancel(); // Batalkan stream lama kalau ada
    _streamSubscription = _firestore
        .collection('invoices_pembelian')
        .where('uid', isEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .listen(
          (QuerySnapshot snapshot) {
            print('Stream received snapshot with ${snapshot.docs.length} docs');
            for (var change in snapshot.docChanges) {
              print('Doc change: ${change.type}, ID: ${change.doc.id}, Data: ${change.doc.data()}');
            }
            isLoading.value = false;
            final fetchedInvoices = snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'id': doc.id,
                'nomorInvoice': data['nomorInvoice'],
                'tanggal': data['tanggal'],
                'totalItem': data['totalItem'],
                'totalHarga': data['totalHarga'],
              };
            }).toList();
            print('Updating invoices with ${fetchedInvoices.length} items: $fetchedInvoices');
            invoices.assignAll(fetchedInvoices);
          },
          onError: (e) {
            isLoading.value = false;
            print('Error streaming invoices: $e');
            String errorMessage = 'Gagal memuat riwayat invoice: $e';
            if (e.toString().contains('requires an index')) {
              errorMessage = 'Gagal memuat riwayat invoice: Indeks Firestore diperlukan. Silakan buat indeks di konsol Firebase.';
            }
            Get.snackbar(
              'Error',
              errorMessage,
              backgroundColor: kColorFourth.withOpacity(0.8),
              colorText: kColorPureWhite,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        );
  }

  @override
  void onClose() {
    print('InvoicePembelianController closed, cancelling stream');
    _streamSubscription?.cancel();
    super.onClose();
  }

  void refreshData() {
    _startStream();
  }

  String formatDate(dynamic tanggal) {
    if (tanggal is Timestamp) {
      return dateFormat.format(tanggal.toDate());
    } else if (tanggal is DateTime) {
      return dateFormat.format(tanggal);
    }
    print('Invalid date format: $tanggal');
    return '-';
  }

  String formatHarga(dynamic harga) {
    if (harga == null || harga == '') {
      return '';
    }
    return numberFormat.format(harga is num ? harga.floor() : 0);
  }
}
