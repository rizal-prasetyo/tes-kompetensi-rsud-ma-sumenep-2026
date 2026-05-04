-- ============================================================
--  DATA SETUP — Tes SQL Programmer
--  Rumah Sakit Sistem Informasi
--  Jalankan file ini terlebih dahulu sebelum mengerjakan soal
-- ============================================================

DROP DATABASE IF EXISTS rumahsakit_db;
CREATE DATABASE rumahsakit_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE rumahsakit_db;

-- ============================================================
-- 1. TABEL POLI
-- ============================================================
CREATE TABLE poli (
    id_poli     INT PRIMARY KEY AUTO_INCREMENT,
    nama_poli   VARCHAR(100) NOT NULL,
    lantai      INT NOT NULL
);

INSERT INTO poli (nama_poli, lantai) VALUES
('Poli Umum',          1),
('Poli Penyakit Dalam',2),
('Poli Jantung',       2),
('Poli Anak',          3),
('Poli Bedah',         3),
('Poli Mata',          1);

-- ============================================================
-- 2. TABEL DOKTER
-- ============================================================
CREATE TABLE dokter (
    id_dokter       INT PRIMARY KEY AUTO_INCREMENT,
    nama_dokter     VARCHAR(100) NOT NULL,
    spesialisasi    VARCHAR(100) NOT NULL,
    id_poli         INT NOT NULL,
    FOREIGN KEY (id_poli) REFERENCES poli(id_poli)
);

INSERT INTO dokter (nama_dokter, spesialisasi, id_poli) VALUES
('dr. Andi Santoso, Sp.PD',     'Penyakit Dalam', 2),
('dr. Budi Raharjo, Sp.JP',     'Jantung',        3),
('dr. Citra Dewi, Sp.A',        'Anak',           4),
('dr. Dian Permata, Sp.B',      'Bedah',          5),
('dr. Eko Nugroho',             'Umum',           1),
('dr. Faisal Hadi, Sp.M',       'Mata',           6),
('dr. Gita Sari, Sp.PD',        'Penyakit Dalam', 2),
('dr. Hendra Wijaya',           'Umum',           1);

-- ============================================================
-- 3. TABEL PASIEN
-- ============================================================
CREATE TABLE pasien (
    id_pasien       INT PRIMARY KEY AUTO_INCREMENT,
    nama_pasien     VARCHAR(100) NOT NULL,
    tgl_lahir       DATE NOT NULL,
    jenis_kelamin   ENUM('L','P') NOT NULL,
    no_bpjs         VARCHAR(20) UNIQUE,
    alamat          VARCHAR(255)
);

INSERT INTO pasien (nama_pasien, tgl_lahir, jenis_kelamin, no_bpjs, alamat) VALUES
('Agus Setiawan',      '1985-03-12', 'L', '0001234567890', 'Jl. Merdeka No.1, Surabaya'),
('Bintang Lestari',    '1990-07-25', 'P', '0009876543210', 'Jl. Pahlawan No.5, Surabaya'),
('Cahyo Purnomo',      '1978-11-05', 'L', '0001122334455', 'Jl. Kenari No.12, Sidoarjo'),
('Dewi Kartika',       '1995-01-30', 'P', '0005566778899', 'Jl. Mawar No.7, Surabaya'),
('Eko Prasetyo',       '1982-06-18', 'L', NULL,            'Jl. Melati No.3, Gresik'),
('Fatimah Azzahra',    '2000-09-09', 'P', '0004433221100', 'Jl. Dahlia No.21, Surabaya'),
('Gilang Ramadhan',    '1973-12-01', 'L', '0007788990011', 'Jl. Anggrek No.8, Malang'),
('Hani Rahayu',        '1999-04-14', 'P', NULL,            'Jl. Teratai No.15, Surabaya'),
('Irfan Maulana',      '1987-08-22', 'L', '0003344556677', 'Jl. Kenanga No.9, Surabaya'),
('Juwita Sari',        '2003-02-28', 'P', '0002211009988', 'Jl. Bougenville No.4, Sidoarjo'),
-- Pasien yang belum pernah mendaftar (untuk Soal 8)
('Kukuh Wicaksono',    '1991-05-16', 'L', '0008899001122', 'Jl. Cempaka No.17, Surabaya'),
('Laras Wulandari',    '1996-10-03', 'P', NULL,            'Jl. Flamboyan No.6, Surabaya');

-- ============================================================
-- 4. TABEL PENDAFTARAN
-- ============================================================
CREATE TABLE pendaftaran (
    id_daftar   INT PRIMARY KEY AUTO_INCREMENT,
    id_pasien   INT NOT NULL,
    id_dokter   INT NOT NULL,
    tgl_daftar  DATE NOT NULL,
    status      ENUM('Antri','Selesai','Batal') NOT NULL DEFAULT 'Antri',
    biaya       DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_dokter) REFERENCES dokter(id_dokter)
);

INSERT INTO pendaftaran (id_pasien, id_dokter, tgl_daftar, status, biaya) VALUES
(1,  1, '2025-01-05', 'Selesai', 150000),
(2,  2, '2025-01-05', 'Selesai', 200000),
(3,  1, '2025-01-06', 'Selesai', 150000),
(4,  3, '2025-01-07', 'Selesai', 120000),
(5,  5, '2025-01-07', 'Selesai',  75000),
(6,  4, '2025-01-08', 'Batal',   175000),
(7,  2, '2025-01-09', 'Selesai', 200000),
(8,  6, '2025-01-09', 'Antri',   130000),
(9,  7, '2025-01-10', 'Antri',   150000),
(10, 3, '2025-01-10', 'Antri',   120000),
(1,  5, '2025-01-11', 'Selesai',  75000),  -- Agus ke Poli Umum (total 225k)
(2,  1, '2025-01-12', 'Antri',   150000),  -- Bintang ke Poli PD
(3,  8, '2025-01-12', 'Selesai',  75000),  -- Cahyo ke Poli Umum (total 225k)
(4,  6, '2025-01-13', 'Antri',   130000),
(5,  2, '2025-01-14', 'Selesai', 200000);  -- Eko ke Poli Jantung

-- ============================================================
-- 5. TABEL REKAM MEDIS
-- ============================================================
CREATE TABLE rekam_medis (
    id_rekam    INT PRIMARY KEY AUTO_INCREMENT,
    id_daftar   INT NOT NULL,
    diagnosa    VARCHAR(200) NOT NULL,
    catatan     TEXT,
    tgl_periksa DATE NOT NULL,
    FOREIGN KEY (id_daftar) REFERENCES pendaftaran(id_daftar)
);

INSERT INTO rekam_medis (id_daftar, diagnosa, catatan, tgl_periksa) VALUES
(1, 'Hipertensi Grade 1',    'Tekanan darah 150/90. Diresepkan amlodipin.',       '2025-01-05'),
(2, 'Aritmia Ringan',        'EKG menunjukkan pola tidak teratur. Observasi.',    '2025-01-05'),
(3, 'Diabetes Tipe 2',       'Gula darah puasa 180. Mulai metformin.',            '2025-01-06'),
(4, 'ISPA',                  'Batuk pilek 3 hari. Antibiotik amoksisilin.',       '2025-01-07'),
(5, 'Common Cold',           'Istirahat cukup, minum air putih.',                '2025-01-07'),
(7, 'Hipertensi Grade 2',    'TD 170/100. Kombinasi obat diperlukan.',            '2025-01-09'),
(11,'Gastritis Kronik',      'Mual dan nyeri ulu hati. Omeprazol.',               '2025-01-11'),
(13,'Faringitis',            'Radang tenggorokan ringan. Antinyeri.',             '2025-01-12'),
(15,'Penyakit Jantung Koroner','Hasil cath lab positif. Rujuk kardiologi.',       '2025-01-14');

-- ============================================================
-- 6. TABEL OBAT
-- ============================================================
CREATE TABLE obat (
    id_obat         INT PRIMARY KEY AUTO_INCREMENT,
    nama_obat       VARCHAR(100) NOT NULL,
    satuan          VARCHAR(20) NOT NULL,
    harga_satuan    DECIMAL(10,2) NOT NULL,
    stok            INT NOT NULL DEFAULT 0
);

INSERT INTO obat (nama_obat, satuan, harga_satuan, stok) VALUES
('Amlodipin 5mg',       'Tablet', 2500,  200),
('Metformin 500mg',     'Tablet', 1500,  300),
('Amoksisilin 500mg',   'Kapsul', 3000,  150),  -- id_obat = 3 (untuk Soal 9)
('Omeprazol 20mg',      'Kapsul', 4000,  120),
('Paracetamol 500mg',   'Tablet',  800,  500),
('Antasida Sirup',      'Botol',  15000,  50),
('Ceftriaxone 1gr',     'Vial',   35000,  30),
('NaCl 0.9% 500ml',     'Kolf',   18000,  80);

-- ============================================================
-- 7. TABEL RESEP
-- ============================================================
CREATE TABLE resep (
    id_resep    INT PRIMARY KEY AUTO_INCREMENT,
    id_rekam    INT NOT NULL,
    id_obat     INT NOT NULL,
    jumlah      INT NOT NULL,
    keterangan  VARCHAR(200),
    FOREIGN KEY (id_rekam) REFERENCES rekam_medis(id_rekam),
    FOREIGN KEY (id_obat)  REFERENCES obat(id_obat)
);

INSERT INTO resep (id_rekam, id_obat, jumlah, keterangan) VALUES
(1, 1, 30, '1x1 malam hari'),
(2, 5, 20, '3x1 bila nyeri'),
(3, 2, 60, '2x1 sesudah makan'),
(4, 3, 15, '3x1 habiskan'),
(5, 5, 10, '3x1 bila perlu'),
(6, 4, 30, '1x1 sebelum makan'),
(7, 1, 60, '2x1 pagi malam'),
(8, 5, 15, '3x1 bila nyeri');

-- ============================================================
-- VERIFIKASI DATA
-- ============================================================
SELECT 'poli'         AS tabel, COUNT(*) AS jumlah_baris FROM poli         UNION ALL
SELECT 'dokter',               COUNT(*)                  FROM dokter        UNION ALL
SELECT 'pasien',               COUNT(*)                  FROM pasien        UNION ALL
SELECT 'pendaftaran',          COUNT(*)                  FROM pendaftaran   UNION ALL
SELECT 'rekam_medis',          COUNT(*)                  FROM rekam_medis   UNION ALL
SELECT 'obat',                 COUNT(*)                  FROM obat          UNION ALL
SELECT 'resep',                COUNT(*)                  FROM resep;

-- ============================================================
-- Jika verifikasi berhasil, output yang diharapkan:
--   poli         | 6
--   dokter       | 8
--   pasien       | 12
--   pendaftaran  | 15
--   rekam_medis  | 9
--   obat         | 8
--   resep        | 8
-- ============================================================
