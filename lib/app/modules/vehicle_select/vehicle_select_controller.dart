import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/utils/snackbar_util.dart';
import 'package:get/get.dart';
import '../../data/models/vehicle.dart';
import '../../data/repositories/vehicle_repository.dart';
import '../../routes/app_routes.dart';

class VehicleSelectController extends GetxController {
  final VehicleRepository _vehicleRepo = Get.find();

  final RxList<Vehicle> vehicles = <Vehicle>[].obs;
  final RxList<String> selectedVehicleIds = <String>[].obs;
  final RxBool isLoading = true.obs;

  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final plateController = TextEditingController();
  final RxString selectedType = 'Motor'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    isLoading.value = true;
    try {
      final list = await _vehicleRepo.getVehicles();
      vehicles.assignAll(list);

      if (vehicles.length >= 2) {
        selectedVehicleIds.assignAll([vehicles[0].id, vehicles[1].id]);
      } else if (vehicles.isNotEmpty) {
        selectedVehicleIds.assignAll([vehicles[0].id]);
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  void toggleVehicleSelection(String id) {
    if (selectedVehicleIds.contains(id)) {
      if (selectedVehicleIds.length > 1) {
        selectedVehicleIds.remove(id);
      } else {
        SnackbarUtil.warning(
          'Peringatan',
          'Pilih minimal 1 kendaraan untuk melanjutkan booking.',
        );
      }
    } else {
      selectedVehicleIds.add(id);
    }
  }

  List<Vehicle> get selectedVehicles {
    return vehicles.where((v) => selectedVehicleIds.contains(v.id)).toList();
  }

  void addNewVehicle() {
    if (nameController.text.trim().isEmpty ||
        plateController.text.trim().isEmpty) {
      SnackbarUtil.warning(
        'Form Tidak Lengkap',
        'Mohon isi nama motor dan plat nomor.',
      );
      return;
    }

    final newVeh = Vehicle(
      id: 'v_${DateTime.now().millisecondsSinceEpoch}',
      name: nameController.text.trim(),
      type: selectedType.value,
      brand: 'Honda',
      model: modelController.text.trim().isEmpty
          ? nameController.text.trim()
          : modelController.text.trim(),
      plateNumber: plateController.text.trim().toUpperCase(),
      imageAsset: 'assets/images/beat.png',
    );

    vehicles.add(newVeh);
    selectedVehicleIds.add(newVeh.id);

    nameController.clear();
    modelController.clear();
    plateController.clear();

    Get.back();
    SnackbarUtil.success(
      'Sukses',
      'Kendaraan ${newVeh.name} berhasil ditambahkan!',
    );
  }

  void proceedToServiceConfig() {
    if (selectedVehicles.isEmpty) {
      SnackbarUtil.warning(
        'Pilih Kendaraan',
        'Silakan pilih minimal 1 kendaraan.',
      );
      return;
    }
    Get.toNamed(
      Routes.serviceConfig,
      arguments: {'selectedVehicles': selectedVehicles},
    );
  }
}
