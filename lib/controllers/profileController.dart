import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kertasinapp/pages/home/HomeScreen.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';

class ProfileController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;

  // State untuk menentukan mode edit dan loading
  var isEditing = false.obs; // Menggunakan RxBool untuk state edit
  var isLoading = false.obs; // Menggunakan RxBool untuk state loading

  // Controller untuk field Data Perusahaan
  final namaPerusahaanController = TextEditingController();
  final bidangController = TextEditingController();
  final alamatController = TextEditingController();

  // Controller untuk field Data Pribadi
  final namaLengkapController = TextEditingController();
  final roleManualController = TextEditingController(); // Controller untuk role manual

  // Daftar opsi role untuk dropdown
  final List<String> roleOptions = [
    'Pemilik Toko',
    'Owner',
    'CEO',
    'Asisten',
    'Manager',
    'Lainnya',
  ];

  // State untuk role yang dipilih dari dropdown
  var selectedRole = Rxn<String>(); // Menggunakan Rxn<String> untuk nullable value
  var showRoleManualField = false.obs; // Menggunakan RxBool untuk menampilkan field role manual

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi controller atau state lain jika diperlukan
  }

  @override
  void onClose() {
    // Dispose controller untuk menghindari memory leak
    namaPerusahaanController.dispose();
    bidangController.dispose();
    alamatController.dispose();
    namaLengkapController.dispose();
    roleManualController.dispose();
    super.onClose();
  }

  // Fungsi untuk logout
  Future<void> signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      print("Logged out from Google Sign-In");

      await FirebaseAuth.instance.signOut();
      print("Logged out from Firebase Authentication");

      Get.offAll(() => const LoginPage());

      Get.snackbar(
        'Logout Berhasil',
        'Anda telah logout. Silakan login dengan akun lain.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("Logout error: $e");
      Get.snackbar(
        'Logout Gagal',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fungsi untuk menghitung persentase kelengkapan data
  double calculateCompletionPercentage(String namaLengkap, String namaPerusahaan, String bidang, String alamat, String role) {
    int totalFields = 5;
    int filledFields = 0;

    if (namaLengkap.isNotEmpty) filledFields++;
    if (namaPerusahaan.isNotEmpty) filledFields++;
    if (bidang.isNotEmpty) filledFields++;
    if (alamat.isNotEmpty) filledFields++;
    if (role.isNotEmpty) filledFields++;

    return (filledFields / totalFields) * 100;
  }

  // Fungsi untuk menentukan field yang belum diisi
  String getIncompleteFields(String namaLengkap, String namaPerusahaan, String bidang, String alamat, String role) {
    List<String> incompleteFields = [];
    if (namaLengkap.isEmpty) incompleteFields.add("Nama Lengkap");
    if (namaPerusahaan.isEmpty) incompleteFields.add("Nama Perusahaan");
    if (bidang.isEmpty) incompleteFields.add("Bidang");
    if (alamat.isEmpty) incompleteFields.add("Alamat");
    // Periksa field Role dengan logika yang lebih lengkap
    if (isEditing.value) {
      // Dalam mode edit, periksa selectedRole dan roleManualController
      if (selectedRole.value == null) {
        incompleteFields.add("Role");
      } else if (selectedRole.value == 'Lainnya' && roleManualController.text.isEmpty) {
        incompleteFields.add("Role (Masukkan Role Manual)");
      }
    } else {
      // Dalam mode view, gunakan nilai role dari Firestore
      if (role.isEmpty) incompleteFields.add("Role");
    }

    if (incompleteFields.isEmpty) {
      return "Semua data telah lengkap!";
    } else {
      return "Lengkapi data berikut: ${incompleteFields.join(", ")}";
    }
  }

  // Fungsi untuk menyimpan data ke Firestore
  Future<void> saveData() async {
    // Validasi hanya untuk Role jika memilih "Lainnya"
    if (selectedRole.value == 'Lainnya' && roleManualController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Lengkapi data berikut: Role (Masukkan Role Manual)',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true; // Tampilkan loading indicator

    try {
      // Tentukan nilai role yang akan disimpan
      String finalRole = selectedRole.value == 'Lainnya' ? roleManualController.text : (selectedRole.value ?? '');

      // Simpan data ke Firestore, gunakan nilai dari controller
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
        'namaPerusahaan': namaPerusahaanController.text,
        'bidang': bidangController.text,
        'alamat': alamatController.text,
        'name': namaLengkapController.text,
        'role': finalRole, // Simpan role ke Firestore
      });

      Get.snackbar(
        'Berhasil',
        'Data berhasil disimpan',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      isEditing.value = false; // Keluar dari mode edit setelah menyimpan
    } catch (e) {
      Get.snackbar(
        'Gagal Menyimpan',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false; // Sembunyikan loading indicator
    }
  }

  // Fungsi untuk masuk ke mode edit
  void toggleEditMode() {
    isEditing.value = true;
  }
}