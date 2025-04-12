import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/controllers/profileController.dart';
import 'package:kertasinapp/pages/home/HomeScreen.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller menggunakan GetX
    final ProfileController controller = Get.put(ProfileController());

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(controller.user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        // Menampilkan loading indicator jika data belum tersedia
        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        // Menampilkan pesan error jika ada error
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading user data"));
        }

        // Menampilkan pesan jika data tidak ditemukan
        if (!snapshot.data!.exists) {
          return const Center(child: Text("User data not found"));
        }

        // Data tersedia, lanjutkan rendering UI
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final userName = userData['name'] as String? ?? 'Unknown';
        final userEmail = userData['email'] as String? ?? 'Unknown';
        final userRole = userData['role'] as String? ?? '';

        // Set nilai awal untuk controller (hanya saat pertama kali data diambil)
        if (controller.namaLengkapController.text.isEmpty) {
          controller.namaLengkapController.text = userName;
        }
        if (controller.namaPerusahaanController.text.isEmpty) {
          controller.namaPerusahaanController.text = userData['namaPerusahaan'] as String? ?? '';
        }
        if (controller.bidangController.text.isEmpty) {
          controller.bidangController.text = userData['bidang'] as String? ?? '';
        }
        if (controller.alamatController.text.isEmpty) {
          controller.alamatController.text = userData['alamat'] as String? ?? '';
        }
        if (controller.selectedRole.value == null) {
          if (controller.roleOptions.contains(userRole)) {
            controller.selectedRole.value = userRole;
          } else if (userRole.isNotEmpty) {
            // Hanya atur ke "Lainnya" jika userRole tidak kosong
            controller.selectedRole.value = 'Lainnya';
            controller.roleManualController.text = userRole;
            controller.showRoleManualField.value = true;
          } else {
            // Jika userRole kosong, biarkan selectedRole tetap null
            controller.selectedRole.value = null;
            controller.roleManualController.text = '';
            controller.showRoleManualField.value = false;
          }
        }

        // Gunakan nilai role yang dinamis (dari dropdown atau field manual jika sedang edit)
        String currentRole = userRole;
        if (controller.isEditing.value) {
          currentRole = controller.selectedRole.value == 'Lainnya' ? controller.roleManualController.text : controller.selectedRole.value ?? '';
        }

        // Hitung persentase kelengkapan data
        double completionPercentage = controller.calculateCompletionPercentage(
          controller.namaLengkapController.text,
          controller.namaPerusahaanController.text,
          controller.bidangController.text,
          controller.alamatController.text,
          currentRole,
        );

        // Tentukan field yang belum diisi
        String incompleteFieldsMessage = controller.getIncompleteFields(
          controller.namaLengkapController.text,
          controller.namaPerusahaanController.text,
          controller.bidangController.text,
          controller.alamatController.text,
          currentRole,
        );

        return Stack(
          children: [
            Scaffold(
              backgroundColor: kColorPureWhite,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: kColorFirst,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Akun Saya",
                                style: TStyle.subtitle1.copyWith(
                                  color: kColorPureWhite,
                                  fontSize: 16,
                                ),
                              ),
                              Obx(() => Row(
                                    children: [
                                      if (!controller.isEditing.value)
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: kColorPureWhite),
                                          onPressed: () {
                                            controller.toggleEditMode(); // Masuk ke mode edit
                                          },
                                          tooltip: "Edit Profil",
                                        ),
                                      if (controller.isEditing.value)
                                        IconButton(
                                          icon: const Icon(Icons.save, color: kColorPureWhite),
                                          onPressed: () {
                                            // Tampilkan alert konfirmasi sebelum menyimpan
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text("Konfirmasi"),
                                                content: const Text("Apakah Anda yakin ingin menyimpan perubahan?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(); // Tutup dialog
                                                    },
                                                    child: const Text("Batal"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(); // Tutup dialog
                                                      controller.saveData(); // Simpan data ke Firestore
                                                    },
                                                    child: const Text("Simpan"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          tooltip: "Simpan",
                                        ),
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: kColorPureWhite,
                                    child: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: kColorFirst,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kColorPureWhite,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      userRole.isNotEmpty ? userRole : 'Role belum diisi', // Tampilkan pesan default jika kosong
                                      style: TStyle.caption.copyWith(
                                        color: kColorFirst,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      style: TStyle.title.copyWith(
                                        color: kColorPureWhite,
                                        fontSize: 20,
                                      ),
                                      maxLines: 1, // Batasi ke 1 baris
                                      overflow: TextOverflow.ellipsis, // Tambahkan ellipsis jika terlalu panjang
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      userEmail,
                                      style: TStyle.body2.copyWith(
                                        color: kColorPureWhite,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    // Progress Bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${completionPercentage.toStringAsFixed(0)}%", // Tampilkan persentase
                                style: TStyle.subtitle1.copyWith(
                                  color: kColorFirst,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  textAlign: TextAlign.right,
                                  incompleteFieldsMessage, // Tampilkan field yang belum diisi
                                  style: TStyle.body2.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: completionPercentage / 100, // Gunakan persentase untuk progress bar
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              kColorFirst,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Data Perusahaan
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Data Perusahaan",
                        style: TStyle.subtitle1.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Obx(() => TextFormField(
                                controller: controller.namaPerusahaanController,
                                enabled: controller.isEditing.value,
                                decoration: InputDecoration(
                                  labelText: "Nama Perusahaan",
                                  labelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  floatingLabelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 16),
                          Obx(() => TextFormField(
                                controller: controller.bidangController,
                                enabled: controller.isEditing.value,
                                decoration: InputDecoration(
                                  labelText: "Bidang",
                                  labelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  floatingLabelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 16),
                          Obx(() => TextFormField(
                                controller: controller.alamatController,
                                enabled: controller.isEditing.value,
                                decoration: InputDecoration(
                                  labelText: "Alamat",
                                  labelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  floatingLabelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Data Pribadi
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Data Pribadi",
                        style: TStyle.subtitle1.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Obx(() => TextFormField(
                                controller: controller.namaLengkapController,
                                enabled: controller.isEditing.value,
                                decoration: InputDecoration(
                                  labelText: "Nama Lengkap",
                                  labelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  floatingLabelStyle: TStyle.body2.copyWith(
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: userEmail,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TStyle.body2.copyWith(
                                color: Colors.grey,
                              ),
                              floatingLabelStyle: TStyle.body2.copyWith(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildRoleDropdown(controller),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Tombol Keluar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: controller.signOut,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          "Keluar",
                          style: TStyle.body1.copyWith(
                            color: kColorPureWhite,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: kColorFirst,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, -1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.off(() => Homescreen());
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.home, color: kColorPureWhite, size: 28),
                          const SizedBox(height: 4),
                          Text("Home", style: TStyle.captionWhite),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.receipt_long, color: kColorPureWhite, size: 28),
                        const SizedBox(height: 4),
                        Text("Pencatatan", style: TStyle.captionWhite),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, color: kColorPureBlack, size: 28),
                        const SizedBox(height: 4),
                        Text("Profil", style: TStyle.captionWhite.copyWith(color: kColorPureBlack)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => controller.isLoading.value
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink()),
          ],
        );
      },
    );
  }

  // Widget terpisah untuk dropdown role
  Widget buildRoleDropdown(ProfileController controller) {
    return Obx(() => Column(
          children: [
            DropdownButtonFormField<String>(
              value: controller.selectedRole.value,
              decoration: InputDecoration(
                labelText: "Role",
                labelStyle: TStyle.body2.copyWith(
                  color: Colors.grey,
                ),
                floatingLabelStyle: TStyle.body2.copyWith(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              items: controller.roleOptions.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: controller.isEditing.value
                  ? (String? newValue) {
                      controller.selectedRole.value = newValue;
                      controller.showRoleManualField.value = newValue == 'Lainnya';
                      if (!controller.showRoleManualField.value) {
                        controller.roleManualController.clear();
                      }
                    }
                  : null,
            ),
            if (controller.showRoleManualField.value && controller.isEditing.value) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.roleManualController,
                decoration: InputDecoration(
                  labelText: "Masukkan Role",
                  labelStyle: TStyle.body2.copyWith(
                    color: Colors.grey,
                  ),
                  floatingLabelStyle: TStyle.body2.copyWith(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ],
        ));
  }
}