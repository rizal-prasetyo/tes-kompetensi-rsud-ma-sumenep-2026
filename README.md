# 🏥 Tes Database MySQL
### Durasi: 30 Menit

---

## 📋 Petunjuk Umum

| Item | Keterangan |
|------|------------|
| **Durasi** | 30 menit |
| **Total Soal** | 10 soal |
| **Total Nilai** | 100 poin |
| **Tools** | MySQL / MariaDB / SQL Editor pilihan |
| **Diperbolehkan** | Browsing, Dokumentasi resmi MySQL (docs.mysql.com) |
| **Dilarang** | Diskusi, AI tools, copy-paste dari internet |

> ⚠️ **Wajib dieksekusi terlebih dahulu:** Jalankan file `data_setup.sql` sebelum mengerjakan soal.

---

## 📁 Struktur File

```
mysql-exam/
├── README.md           ← Soal
└── data_setup.sql      ← DDL + Data Dummy (jalankan dulu!)
```

---

## 🗄️ Skema Database

```
rumahsakit_db
│
├── poli          (id_poli, nama_poli, lantai)
├── dokter        (id_dokter, nama_dokter, spesialisasi, id_poli)
├── pasien        (id_pasien, nama_pasien, tgl_lahir, jenis_kelamin, no_bpjs, alamat)
├── pendaftaran   (id_daftar, id_pasien, id_dokter, tgl_daftar, status, biaya)
├── rekam_medis   (id_rekam, id_daftar, diagnosa, catatan, tgl_periksa)
└── obat          (id_obat, nama_obat, satuan, harga_satuan, stok)
    └── resep     (id_resep, id_rekam, id_obat, jumlah, keterangan)
```

---

## 📝 SOAL

---

### Soal 1 — SELECT Dasar (8 poin)

**Tampilkan semua data pasien** dengan kolom: `id_pasien`, `nama_pasien`, `jenis_kelamin`, dan `no_bpjs`. Urutkan berdasarkan `nama_pasien` secara **ascending**.

---

### Soal 2 — WHERE & Filtering (8 poin)

Tampilkan **nama dokter** dan **spesialisasi** dari semua dokter yang memiliki spesialisasi `'Penyakit Dalam'` atau `'Jantung'`.

---

### Soal 3 — AGGREGATE — COUNT (10 poin)

Hitung **jumlah total pendaftaran** yang memiliki status `'Selesai'`.

---

### Soal 4 — GROUP BY + COUNT (10 poin)

Tampilkan **jumlah pasien yang mendaftar per dokter**. Tampilkan kolom: `id_dokter` dan `jumlah_pendaftaran`. Urutkan dari jumlah terbanyak.

---

### Soal 5 — JOIN 2 Tabel (10 poin)

Tampilkan **nama pasien** dan **nama dokter** yang menangani dari tabel `pendaftaran`. Sertakan juga kolom `tgl_daftar` dan `status`.

---

### Soal 6 — JOIN 3 Tabel (12 poin)

Tampilkan **nama pasien**, **nama dokter**, dan **nama poli** untuk semua pendaftaran yang statusnya `'Antri'`. Gunakan JOIN pada tabel `pendaftaran`, `pasien`, `dokter`, dan `poli`.

---

### Soal 7 — GROUP BY + HAVING (12 poin)

Tampilkan **poli mana saja yang memiliki lebih dari 1 dokter**. Tampilkan `id_poli` dan `jumlah_dokter`.

---

### Soal 8 — Subquery (12 poin)

Tampilkan **nama pasien** yang **belum pernah mendaftar** ke poli manapun (tidak ada di tabel `pendaftaran`).

---

### Soal 9 — UPDATE (8 poin)

Kurangi stok obat dengan `id_obat = 3` sebanyak **5 unit**. Tulis query UPDATE-nya, kemudian tampilkan data obat tersebut untuk memverifikasi hasilnya.

---

### Soal 10 — Query Kompleks (10 poin)

Tampilkan **total biaya pendaftaran per pasien**, hanya untuk pasien yang **total biayanya di atas Rp 200.000**. Tampilkan kolom: `nama_pasien` dan `total_biaya`. Urutkan dari yang tertinggi.

---

## 📁 Struktur File yang Dikumpulkan

```
nama-peserta-tes/
├── soal1.sql
├── soal2.sql
├── soal3.sql
├── soal4.sql
├── soal5.sql
├── soal6.sql
├── soal7.sql
├── soal8.sql
├── soal9.sql
└── soal10.sql
```

> ⚠️ **Dikumpulkan dalam bentuk zip | rar | 7z di link ini https://form.jotform.com/261168078056057 **

---

*Dokumen ini dibuat untuk keperluan rekrutmen internal. Dilarang disebarkan tanpa izin.*
