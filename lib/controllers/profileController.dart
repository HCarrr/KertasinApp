import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';

class ProfileController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;

  // State untuk menentukan mode edit dan loading
  var isEditing = false.obs;
  var isLoading = false.obs;

  // Controller untuk field Data Perusahaan
  final namaPerusahaanController = TextEditingController();
  final bidangController = TextEditingController();
  final alamatController = TextEditingController();

  // Controller untuk field Data Pribadi
  final namaLengkapController = TextEditingController();
  final roleManualController = TextEditingController();

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
  var selectedRole = Rxn<String>();
  var showRoleManualField = false.obs;

  // State untuk data dinamis dari Firestore
  var userData = Rx<Map<String, dynamic>?>(null);
  var currentRole = ''.obs;
  var completionPercentage = 0.0.obs;
  var incompleteFieldsMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to Firestore stream and initialize data
    listenToUserData();
  }

  // Method untuk mendengarkan data dari Firestore dan menginisialisasi field
  void listenToUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        userData.value = snapshot.data() as Map<String, dynamic>;
        initializeFields();
        updateCurrentRole();
        calculateAndUpdateCompletion();
      } else {
        Get.snackbar("Error", "User data not found");
      }
    }, onError: (error) {
      Get.snackbar("Error", "Failed to load user data: $error");
    });
  }

  // Method untuk menginisialisasi nilai awal field
  void initializeFields() {
    final userName = userData.value?['name'] as String? ?? 'Unknown';
    final userRole = userData.value?['role'] as String? ?? '';

    if (namaLengkapController.text.isEmpty) {
      namaLengkapController.text = userName;
    }
    if (namaPerusahaanController.text.isEmpty) {
      namaPerusahaanController.text = userData.value?['namaPerusahaan'] as String? ?? '';
    }
    if (bidangController.text.isEmpty) {
      bidangController.text = userData.value?['bidang'] as String? ?? '';
    }
    if (alamatController.text.isEmpty) {
      alamatController.text = userData.value?['alamat'] as String? ?? '';
    }

    if (selectedRole.value == null) {
      if (roleOptions.contains(userRole)) {
        selectedRole.value = userRole;
      } else if (userRole.isNotEmpty) {
        selectedRole.value = 'Lainnya';
        roleManualController.text = userRole;
        showRoleManualField.value = true;
      } else {
        selectedRole.value = null;
        roleManualController.text = '';
        showRoleManualField.value = false;
      }
    }
  }

  // Method untuk memperbarui currentRole
  void updateCurrentRole() {
    final userRole = userData.value?['role'] as String? ?? '';
    if (isEditing.value) {
      currentRole.value = selectedRole.value == 'Lainnya' ? roleManualController.text : selectedRole.value ?? '';
    } else {
      currentRole.value = userRole;
    }
  }

  // Method untuk menghitung persentase kelengkapan dan field yang belum diisi
  void calculateAndUpdateCompletion() {
    completionPercentage.value = calculateCompletionPercentage(
      namaLengkapController.text,
      namaPerusahaanController.text,
      bidangController.text,
      alamatController.text,
      currentRole.value,
    );

    incompleteFieldsMessage.value = getIncompleteFields(
      namaLengkapController.text,
      namaPerusahaanController.text,
      bidangController.text,
      alamatController.text,
      currentRole.value,
    );
  }

  // Fungsi untuk menghitung persentase kelengkapan data
  double calculateCompletionPercentage(
    String namaLengkap,
    String namaPerusahaan,
    String bidang,
    String alamat,
    String role,
  ) {
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
  String getIncompleteFields(
    String namaLengkap,
    String namaPerusahaan,
    String bidang,
    String alamat,
    String role,
  ) {
    List<String> incompleteFields = [];
    if (namaLengkap.isEmpty) incompleteFields.add("Nama Lengkap");
    if (namaPerusahaan.isEmpty) incompleteFields.add("Nama Perusahaan");
    if (bidang.isEmpty) incompleteFields.add("Bidang");
    if (alamat.isEmpty) incompleteFields.add("Alamat");
    if (isEditing.value) {
      if (selectedRole.value == null) {
        incompleteFields.add("Role");
      } else if (selectedRole.value == 'Lainnya' && roleManualController.text.isEmpty) {
        incompleteFields.add("Role (Masukkan Role Manual)");
      }
    } else {
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

    isLoading.value = true;

    try {
      String finalRole = selectedRole.value == 'Lainnya' ? roleManualController.text : (selectedRole.value ?? '');

      await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
        'namaPerusahaan': namaPerusahaanController.text,
        'bidang': bidangController.text,
        'alamat': alamatController.text,
        'name': namaLengkapController.text,
        'role': finalRole,
      });

      Get.snackbar(
        'Berhasil',
        'Data berhasil disimpan',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      isEditing.value = false;
    } catch (e) {
      Get.snackbar(
        'Gagal Menyimpan',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk masuk ke mode edit
  void toggleEditMode() {
    isEditing.value = !isEditing.value;
    updateCurrentRole();
    calculateAndUpdateCompletion();
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

  @override
  void onClose() {
    namaPerusahaanController.dispose();
    bidangController.dispose();
    alamatController.dispose();
    namaLengkapController.dispose();
    roleManualController.dispose();
    super.onClose();
  }
}