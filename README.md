# 🎓 Kampusku — Mobile & Backend App

**Kampusku** adalah aplikasi sistem informasi kampus berbasis mobile dan web.  
Frontend dibuat dengan **Flutter**, sedangkan backend menggunakan **Laravel REST API**.  
Proyek ini ditujukan untuk mengelola data mahasiswa.

---

## 🗂️ Struktur Proyek

Kampusku/<br>
├── frontend/ # Aplikasi mobile (Flutter)<br>
└── backend/ # REST API (Laravel)

---

## 🚀 Fitur Utama

### 📱 Aplikasi Mobile (Flutter)
- Login Mahasiswa
- Dashboard Informasi Kampus
- Lihat dan Kelola Data Mahasiswa
- Tampilan Responsif & Modern

### ⚙️ Backend API (Laravel)
- Autentikasi JWT
- Manajemen Mahasiswa
- Endpoint RESTful JSON
- Middleware dan Validasi Input
- Laravel

---

## 💻 Cara Instalasi & Menjalankan

### 🔧 Backend (Laravel)

```bash
cd backend
cp .env.example .env
composer install
php artisan key:generate
php artisan migrate
php artisan serve
```


Pastikan koneksi database MySQL diatur di file .env.

### 📱 Frontend (Flutter)
```
cd frontend
flutter pub get
flutter run
Pastikan Flutter SDK terpasang dan emulator aktif.
```

Pastikan Flutter SDK terpasang dan emulator/device dalam kondisi aktif.


---

## 🧰 Teknologi yang Digunakan

🔹 **Frontend** : Flutter 3.x  
🔹 **Backend** : Laravel 10.x  
🔹 **Database** : MySQL / MariaDB  
🔹 **API Format** : RESTful JSON

## 👨‍💻 Developer
```
Kristian Dimas Adiwicaksono
GitHub: @kristiandimasadiwicaksono
```