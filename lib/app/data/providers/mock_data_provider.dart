import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/vehicle.dart';
import '../models/service_type.dart';
import '../models/spare_part.dart';
import '../models/workshop.dart';

class MockDataProvider {
  Future<List<Vehicle>> loadVehicles() async {
    try {
      final String response = await rootBundle.loadString('assets/data/vehicles.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Vehicle.fromJson(json)).toList();
    } catch (e) {
      return [
        Vehicle(
          id: 'v1',
          name: 'Honda BeAT Street',
          type: 'Motor',
          brand: 'Honda',
          model: 'BeAT 110 CBS',
          plateNumber: 'B 4829 SKS',
          imageAsset: 'assets/images/beat.png',
        ),
        Vehicle(
          id: 'v2',
          name: 'Honda Vario 160',
          type: 'Motor',
          brand: 'Honda',
          model: 'Vario 160 ABS',
          plateNumber: 'B 3102 KJA',
          imageAsset: 'assets/images/vario.png',
        ),
        Vehicle(
          id: 'v3',
          name: 'Honda PCX 160',
          type: 'Motor',
          brand: 'Honda',
          model: 'PCX 160 e:HEV',
          plateNumber: 'B 6699 RFD',
          imageAsset: 'assets/images/pcx.png',
        ),
        Vehicle(
          id: 'v4',
          name: 'Honda Scoopy Prestige',
          type: 'Motor',
          brand: 'Honda',
          model: 'Scoopy Smart Key',
          plateNumber: 'B 1234 ABC',
          imageAsset: 'assets/images/scoopy.png',
        ),
      ];
    }
  }

  Future<List<ServiceType>> loadServiceTypes() async {
    try {
      final String response = await rootBundle.loadString('assets/data/service_types.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => ServiceType.fromJson(json)).toList();
    } catch (e) {
      return [
        ServiceType(
          id: 'st1',
          name: 'Servis Ringan',
          description: 'Pemeriksaan umum, pembersihan filter udara, setel rantai, cek rem & busi.',
          basePrice: 75000,
          estimatedMinutes: 45,
          icon: 'build_outlined',
        ),
        ServiceType(
          id: 'st2',
          name: 'Servis Berkala',
          description: 'Paket servis lengkap, ganti oli mesin, cek kelistrikan, ganti oli gardan, tune up.',
          basePrice: 150000,
          estimatedMinutes: 90,
          icon: 'published_with_changes_outlined',
        ),
        ServiceType(
          id: 'st3',
          name: 'Perawatan & Perbaikan',
          description: 'Perbaikan komponen spesifik, kuras minyak rem, servis CVT/injeksi, penanganan keluhan.',
          basePrice: 250000,
          estimatedMinutes: 120,
          icon: 'home_repair_service_outlined',
        ),
        ServiceType(
          id: 'st4',
          name: 'Overhaul Mesin',
          description: 'Bongkar total mesin, penggantian komponen aus, skir klep, pembersihan ruang bakar.',
          basePrice: 1200000,
          estimatedMinutes: 1440,
          icon: 'engineering_outlined',
        ),
      ];
    }
  }

  Future<List<SparePart>> loadSpareParts() async {
    try {
      final String response = await rootBundle.loadString('assets/data/spare_parts.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => SparePart.fromJson(json)).toList();
    } catch (e) {
      return [
        SparePart(id: 'sp1', name: 'Oli MPX2 Matic 0.8L', category: 'Oli', price: 54000),
        SparePart(id: 'sp2', name: 'Oli SPX2 Synthetic 0.8L', category: 'Oli', price: 68000),
        SparePart(id: 'sp3', name: 'Oli Gardan Scooter 120ml', category: 'Oli', price: 18000),
        SparePart(id: 'sp4', name: 'Kampas Rem Depan', category: 'Sparepart', price: 65000),
        SparePart(id: 'sp5', name: 'Kampas Rem Belakang', category: 'Sparepart', price: 55000),
        SparePart(id: 'sp6', name: 'Filter Udara Viscous Element', category: 'Sparepart', price: 48000),
        SparePart(id: 'sp7', name: 'Busi Spark Plug CPR9EA-9', category: 'Sparepart', price: 30000),
      ];
    }
  }

  Future<List<Workshop>> loadWorkshops() async {
    try {
      final String response = await rootBundle.loadString('assets/data/workshops.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Workshop.fromJson(json)).toList();
    } catch (e) {
      return [
        Workshop(
          id: 'ws1',
          name: 'AHASS Honda Astra Motor Pusat',
          address: 'Jl. Kramat Raya No. 104, Senen, Jakarta Pusat',
          distanceKm: 1.8,
          rating: 4.9,
          reviewCount: 1240,
          imageAsset: 'assets/images/workshop_1.png',
          openHours: '08:00 - 17:00',
        ),
        Workshop(
          id: 'ws2',
          name: 'AHASS Motorku Express South',
          address: 'Jl. RS Fatmawati No. 22, Cilandak, Jakarta Selatan',
          distanceKm: 3.4,
          rating: 4.8,
          reviewCount: 890,
          imageAsset: 'assets/images/workshop_2.png',
          openHours: '07:30 - 16:30',
        ),
      ];
    }
  }
}
