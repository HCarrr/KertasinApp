import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/model/barang/barang_model.dart';

class BarangController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // List barang
  final RxList<BarangModel> barangList = <BarangModel>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Form controllers
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchBarang();
  }

  void fetchBarang() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    _firestore
        .collection('barang')
        .where('uid', isEqualTo: uid) // Filter data hanya milik user ini
        .snapshots()
        .listen((snapshot) {
      barangList.value = snapshot.docs.map((doc) {
        return BarangModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> addBarang() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    final uid = _auth.currentUser?.uid;

    try {
      await _firestore.collection('barang').add({
        'uid': uid,
        'nama': namaController.text.trim(),
        'harga': int.tryParse(hargaController.text.trim()) ?? 0,
        'stok': int.tryParse(stokController.text.trim()) ?? 0,
      });

      Get.back();
      Get.snackbar("Sukses", "Barang berhasil ditambahkan",
          backgroundColor: Colors.green, colorText: Colors.white);
      clearForm();
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateBarang(String id) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await _firestore.collection('barang').doc(id).update({
        'nama': namaController.text.trim(),
        'harga': int.tryParse(hargaController.text.trim()) ?? 0,
        'stok': int.tryParse(stokController.text.trim()) ?? 0,
      });

      Get.back();
      Get.snackbar("Sukses", "Barang berhasil diupdate",
          backgroundColor: Colors.blue, colorText: Colors.white);
      clearForm();
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBarang(String id) async {
    try {
      await _firestore.collection('barang').doc(id).delete();
      Get.snackbar("Berhasil", "Barang berhasil dihapus",
          backgroundColor: Colors.orange, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void fillForm(BarangModel barang) {
    namaController.text = barang.nama;
    hargaController.text = barang.harga.toString();
    stokController.text = barang.stok.toString();
  }

  void clearForm() {
    namaController.clear();
    hargaController.clear();
    stokController.clear();
  }

  @override
  void onClose() {
    namaController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.onClose();
  }
}
