# Servisin Aja — Multi-Vehicle Service Booking App 🛵💨

**Servisin Aja** adalah aplikasi mobile berbasis Flutter & GetX untuk booking servis kendaraan (sepeda motor) resmi AHASS secara praktis. Aplikasi ini memiliki fitur utama **Multi-Vehicle Booking**, di mana pengguna dapat melakukan booking servis untuk **beberapa sepeda motor sekaligus dalam 1 kali transaksi**.

---

## 🌟 Fitur Utama (Core & Bonus Features)

### 1. 🚀 Multi-Vehicle Booking (Core Feature)
- **Satu Transaksi untuk Banyak Motor**: Pengguna dapat memilih 1, 2, atau lebih motor dari garasi (misal: *Honda BeAT Street* + *Honda Vario 160*).
- **Konfigurasi Independen per Unit**:
  - **Tipe Servis per Motor**: Servis Ringan, Servis Berkala, Perawatan & Perbaikan, atau Overhaul Mesin.
  - **Oli & Sparepart Tambahan**: Pemilihan oli (MPX2, SPX2) dan sparepart (kampas rem, busi, filter udara, aki, CVT) dengan kalkulasi otomatis per unit.
  - **Catatan Keluhan Khusus (Free Text)**: Keluhan spesifik untuk tiap-tiap motor (misal: motor A "suara CVT kasar", motor B "tarikan rem dalam").
- **Tampilan Accordion / Card per Motor**: Antarmuka ringkas dan tidak menumpuk.
- **Kalkulasi Total Fleet**: Menampilkan subtotal harga & durasi estimasi per unit serta grand total seluruh fleet secara realtime di *sticky bottom bar*.

### 2. 🏁 Garasi & Tambah Kendaraan
- Garasi motor pengguna dengan pilihan multi-select.
- Modal bottom sheet untuk menambah kendaraan baru (Nama, Varian, Plat Nomor, Tipe).

### 3. 📅 Penjadwalan & Bengkel AHASS
- Pilihan Bengkel AHASS terdekat lengkap dengan jarak (km) dan rating ulasan.
- Horizontal Date Picker 7 hari ke depan.
- Time slot kedatangan (08:00 - 16:00) dengan indikator ketersediaan slot.

### 4. 🧾 Ringkasan Booking & E-Tiket Digital
- Breakdown lengkap detail setiap unit motor sebelum konfirmasi.
- E-Tiket Digital resmi dengan Kode Booking unik (misal: `SRV-20260928-8839`).
- Status chip per unit motor (*Menunggu Konfirmasi*, *Dijadwalkan*, *Dalam Pengerjaan*, *Selesai*).

### 5. 🎯 Bonus Features
- **Lacak Status Servis (Tracking Timeline)**: Timeline progres pengerjaan per unit motor + info Mekanik AHASS penanggung jawab.
- **Faktur & Invoice PDF Detail**: Rincian harga jasa, sparepart, dan PPN 11% berformat resmi.
- **Beri Ulasan & Rating**: Penilaian bintang (1-5) dan ulasan pengalaman bengkel.
- **Riwayat Booking (History Tab)**: Daftar riwayat seluruh transaksi servis aktif maupun selesai.

---

## 🎨 Design System Tokens

Seluruh antarmuka dibangun menggunakan design system konsisten di `lib/app/core/theme/`:

### Colors (`AppColors`)
- **Primary (Orange)**: `#F2661B` (Primary), `#D2551A` (Primary Dark), `#FF8A3D` (Primary Light), `#FFF3EB` (Primary Tint)
- **Neutrals**: `#171A1F` (Text Primary), `#565D6D` (Text Secondary), `#9095A0` (Text Muted), `#E5E7EB` (Border), `#F6F7F9` (Surface), `#FFFFFF` (Card)
- **Status Chips**:
  - `Menunggu Konfirmasi` -> Warning (`#F59E0B` / Tint `#FEF3C7`)
  - `Dijadwalkan` / `Dalam Pengerjaan` -> Info (`#2563EB` / Tint `#DBEAFE`)
  - `Selesai` -> Success (`#16A34A` / Tint `#DCFCE7`)

### Typography (`AppTypography`)
- Menggunakan font **Plus Jakarta Sans** via `google_fonts`.
- Display Large (28px Bold), Heading Large (22px Bold), Heading Medium (18px SemiBold), Title Medium (16px SemiBold), Body Large (15px Regular), Body Medium (14px Regular), Label (13px Medium), Caption (12px Regular).

### Layout & Spacing (`AppSpacing`)
- Spacing scale: 4, 8, 12, 16, 20, 24, 32.
- Card Radius: `16px`, Button Radius: `12px`, Input Radius: `12px`, Chip Radius: `999px`.
- Button Height: `52px`, Input Height: `52px`.

---

## 🏗️ Structure Architecture (GetX Feature-First)

```
lib/
  main.dart
  app/
    routes/            (app_pages.dart, app_routes.dart)
    bindings/          (initial_binding.dart)
    core/
      theme/           (app_colors.dart, app_typography.dart, app_theme.dart, app_spacing.dart)
      widgets/         (primary_button.dart, secondary_button.dart, service_card.dart, vehicle_card.dart, section_header.dart, quantity_stepper.dart, status_chip.dart, empty_state.dart)
      utils/           (formatters.dart — Rupiah & Duration formatters)
      constants/       (assets.dart, strings.dart)
    data/
      models/          (vehicle.dart, service_type.dart, spare_part.dart, workshop.dart, booking.dart, booking_item.dart, time_slot.dart)
      providers/       (mock_data_provider.dart — JSON asset loader)
      repositories/    (vehicle_repository.dart, service_repository.dart, workshop_repository.dart, booking_repository.dart)
    modules/
      home/            (home_binding.dart, home_controller.dart, home_view.dart)
      main/            (controller, binding, view)
      vehicle_select/  (controller, binding, view)
      service_config/  (controller, binding, view — Core Multi-Vehicle Config)
      schedule/        (controller, binding, view)
      booking_summary/ (controller, binding, view)
      booking_success/ (controller, binding, view)
      tracking/        (controller, binding, view)
      workshop_rating/ (controller, binding, view)
      invoice_detail/  (controller, binding, view)
      booking_history/ (controller, binding, view)
```

---

## ⚙️ Prerequisites & Setup

- **Flutter SDK**: `>= 3.12.0`
- **Dart SDK**: `>= 3.0.0` (Null Safety Enabled)

### Install Dependencies
```bash
flutter pub get
```

### Run Project Locally
```bash
flutter run
```

### Analyze Code
```bash
flutter analyze
```

### Build Release APK
```bash
flutter build apk --release
```
*(Hasil APK berada di `build/app/outputs/flutter-apk/app-release.apk`)*
# sahabat_honda
