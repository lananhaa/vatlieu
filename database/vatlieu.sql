CREATE DATABASE IF NOT EXISTS vatlieu
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;

USE vatlieu;

SET FOREIGN_KEY_CHECKS = 0;


CREATE TABLE IF NOT EXISTS Nguoidung (
    Manv VARCHAR(50) PRIMARY KEY,
    Tendangnhap VARCHAR(100) NOT NULL UNIQUE,
    Matkhau VARCHAR(255) NOT NULL,
    Hovaten VARCHAR(255),
    Email VARCHAR(100),
    Vaitro VARCHAR(50) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Nhacungcap (
    Mancc VARCHAR(50) PRIMARY KEY,
    Tenncc VARCHAR(255) NOT NULL,
    Sdtncc VARCHAR(15),
    Diachincc VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Danhmucsp (
    Madm INT PRIMARY KEY AUTO_INCREMENT,
    Tendm VARCHAR(100) NOT NULL UNIQUE,
    Mota VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Nguyenvatlieu (
    Manvl VARCHAR(50) PRIMARY KEY,
    Tennvl VARCHAR(255) NOT NULL,
    Dvt VARCHAR(50) NOT NULL,
    Giavon DECIMAL(18, 2) DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Sanpham (
    Masp VARCHAR(50) PRIMARY KEY,
    Tensp VARCHAR(255) NOT NULL,
    Madm INT,
    Dvt VARCHAR(50) NOT NULL,
    Giaban DECIMAL(18, 2) DEFAULT 0,
    FOREIGN KEY (Madm) REFERENCES Danhmucsp(Madm) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Congthucsanpham (
    Masp VARCHAR(50),
    Manvl VARCHAR(50),
    Soluong DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Masp, Manvl),
    FOREIGN KEY (Masp) REFERENCES Sanpham(Masp) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Manvl) REFERENCES Nguyenvatlieu(Manvl) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Loaikhachhang (
    Maloaikh INT PRIMARY KEY AUTO_INCREMENT,
    Tenloaikh VARCHAR(100) NOT NULL,
    Motaloaikh TEXT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Khachhang (
    Makh VARCHAR(50) PRIMARY KEY,
    Tenkh VARCHAR(255) NOT NULL,
    Sdtkh VARCHAR(15),
    Diachikh VARCHAR(255),
    Maloaikh INT,
    FOREIGN KEY (Maloaikh) REFERENCES Loaikhachhang(Maloaikh) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Kho (
    Makho VARCHAR(50) PRIMARY KEY,
    Tenkho VARCHAR(100) NOT NULL,
    Diachi TEXT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Tonkho_nvl (
    Makho VARCHAR(50),
    Manvl VARCHAR(50),
    Soluongton DECIMAL(18, 2) DEFAULT 0,
    PRIMARY KEY (Makho, Manvl),
    FOREIGN KEY (Makho) REFERENCES Kho(Makho) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Manvl) REFERENCES Nguyenvatlieu(Manvl) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Tonkho_sp (
    Makho VARCHAR(50),
    Masp VARCHAR(50),
    Soluongton DECIMAL(18, 2) DEFAULT 0,
    PRIMARY KEY (Makho, Masp),
    FOREIGN KEY (Makho) REFERENCES Kho(Makho) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Masp) REFERENCES Sanpham(Masp) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Phieunhap (
    Manhaphang VARCHAR(50) PRIMARY KEY,
    Mancc VARCHAR(50),
    Makho VARCHAR(50),
    Ngaynhaphang DATE NOT NULL,
    Tongtiennhap DECIMAL(18, 2) DEFAULT 0,
    Ghichu TEXT,
    FOREIGN KEY (Mancc) REFERENCES Nhacungcap(Mancc) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (Makho) REFERENCES Kho(Makho) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Chitiet_Phieunhap (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Manhaphang VARCHAR(50),
    Manvl VARCHAR(50),
    Soluong DECIMAL(18, 2) NOT NULL,
    Dongianhap DECIMAL(18, 2) NOT NULL,
    Thanhtien DECIMAL(18, 2) AS (Soluong * Dongianhap) STORED,
    FOREIGN KEY (Manhaphang) REFERENCES Phieunhap(Manhaphang) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Manvl) REFERENCES Nguyenvatlieu(Manvl) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Phieudieuchuyen (
    Madieuchuyen VARCHAR(50) PRIMARY KEY,
    Khoxuat VARCHAR(50) NOT NULL,
    Khonhap VARCHAR(50) NOT NULL,
    Ngaydieuchuyen DATE NOT NULL,
    Ghichu TEXT,
    Trangthai VARCHAR(50) DEFAULT 'dang_xu_ly',
    FOREIGN KEY (Khoxuat) REFERENCES Kho(Makho) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Khonhap) REFERENCES Kho(Makho) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Chitiet_Phieudieuchuyen (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Madieuchuyen VARCHAR(50),
    Masp VARCHAR(50),
    Soluong DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (Madieuchuyen) REFERENCES Phieudieuchuyen(Madieuchuyen) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Masp) REFERENCES Sanpham(Masp) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Phieuxuat (
    Maxuathang VARCHAR(50) PRIMARY KEY,
    Makh VARCHAR(50),
    Makho VARCHAR(50),
    Ngayxuat DATE NOT NULL,
    Tongtienxuat DECIMAL(18, 2) DEFAULT 0,
    Ghichu TEXT,
    FOREIGN KEY (Makh) REFERENCES Khachhang(Makh) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (Makho) REFERENCES Kho(Makho) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Chitiet_Phieuxuat (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Maxuathang VARCHAR(50),
    Masp VARCHAR(50),
    Soluong DECIMAL(18, 2) NOT NULL,
    Dongiaxuat DECIMAL(18, 2) NOT NULL,
    Thanhtien DECIMAL(18, 2) AS (Soluong * Dongiaxuat) STORED,
    FOREIGN KEY (Maxuathang) REFERENCES Phieuxuat(Maxuathang) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Masp) REFERENCES Sanpham(Masp) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Lenhsanxuat (
    Malenh VARCHAR(50) PRIMARY KEY,
    Masp VARCHAR(50) NOT NULL,
    Ngaysanxuat DATE NOT NULL,
    Soluongsanxuat DECIMAL(18, 2) NOT NULL,
    Trangthai VARCHAR(50) DEFAULT 'dang_xu_ly',
    Ngaybatdau DATE NULL,
    Ngayketthuc DATE NULL,
    Ghichu TEXT NULL,
    FOREIGN KEY (Masp) REFERENCES Sanpham(Masp) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Chitiet_XuatNVL_Sanxuat (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Malenh VARCHAR(50),
    Manvl VARCHAR(50),
    Soluong DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (Malenh) REFERENCES Lenhsanxuat(Malenh) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Manvl) REFERENCES Nguyenvatlieu(Manvl) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Chitiet_Nhapsanpham_Sanxuat (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Malenh VARCHAR(50),
    Makho VARCHAR(50),
    Masp VARCHAR(50),
    Soluong DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (Malenh) REFERENCES Lenhsanxuat(Malenh) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Makho) REFERENCES Kho(Makho) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Masp) REFERENCES Sanpham(Masp) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;



INSERT INTO Nguoidung (Manv, Tendangnhap, Matkhau, Hovaten, Email, Vaitro) VALUES

('NV001', 'admin', '123456', 'Quan Tri Vien', 'admin@vlxd.com', 'Admin'),
('NV002', 'lananh', 'lananh', 'Lan Anh', 'lananh@vlxd.com', 'Admin'),
('NV003', 'ketoan2', '123456', 'Ke Toan 2', 'ketoan2@vlxd.com', 'KeToan'),
('NV004', 'thukho1', '123456', 'Thu Kho 1', 'thukho1@vlxd.com', 'ThuKho'),
('NV005', 'thukho2', '123456', 'Thu Kho 2', 'thukho2@vlxd.com', 'ThuKho'),
('NV006', 'nvbanhang1', '123456', 'Nhan Vien Ban Hang 1', 'nv1@vlxd.com', 'NhanVien'),
('NV007', 'nvbanhang2', '123456', 'Nhan Vien Ban Hang 2', 'nv2@vlxd.com', 'NhanVien'),
('NV008', 'qldathang', '123456', 'Quan Ly Dat Hang', 'qldh@vlxd.com', 'QuanLy'),
('NV009', 'giamdoc', '123456', 'Giam Doc', 'gd@vlxd.com', 'Admin'),
('NV010', 'khohang', '123456', 'Bo Phan Kho Hang', 'khohang@vlxd.com', 'NhanVien');


-- Nhacungcap

INSERT INTO Nhacungcap (Mancc, Tenncc, Sdtncc, Diachincc) VALUES

('NCC001', 'Hoa Phat', '0901000001', 'Ha Noi'),
('NCC002', 'Viglacera', '0901000002', 'Bac Ninh'),
('NCC003', 'Vicem', '0901000003', 'Hai Phong'),
('NCC004', 'Dong Tam', '0901000004', 'TP HCM'),
('NCC005', 'Prime', '0901000005', 'Vinh Phuc'),
('NCC006', 'SCG', '0901000006', 'Da Nang'),
('NCC007', 'An Cuong', '0901000007', 'Binh Duong'),
('NCC008', 'Eurowindow', '0901000008', 'Ha Noi'),
('NCC009', 'Viet Duc', '0901000009', 'Hung Yen'),
('NCC010', 'Tasa', '0901000010', 'Thai Binh');


-- Danhmucsp

INSERT INTO Danhmucsp (Tendm, Mota) VALUES

('Gach Xay', 'Vat lieu gach xay dung'),
('Xi Mang', 'Xi mang cac loai'),
('Cat Xay', 'Cat xay dung'),
('Da Xay', 'Da xay dung'),
('Thep', 'Thep xay dung'),
('Ong Nhua', 'Ong va phu kien nhua'),
('Son', 'Son noi va ngoai that'),
('Ngoi Lop', 'Ngoi lop va phu kien'),
('Keo Dan', 'Keo dan, bo tro'),
('Vat Tu Khac', 'Vat tu phu tro khac');


-- Nguyenvatlieu

INSERT INTO Nguyenvatlieu (Manvl, Tennvl, Dvt, Giavon) VALUES

('NVL001', 'Xi Mang PCB40', 'Bao', 92000),
('NVL002', 'Xi Mang PCB30', 'Bao', 88000),
('NVL003', 'Cat Vang', 'm3', 320000),
('NVL004', 'Cat Den', 'm3', 300000),
('NVL005', 'Da 1x2', 'm3', 430000),
('NVL006', 'Da Mi', 'm3', 410000),
('NVL007', 'Thep D6', 'Kg', 17500),
('NVL008', 'Thep D8', 'Kg', 18200),
('NVL009', 'Thep D10', 'Kg', 18800),
('NVL010', 'Thep D12', 'Kg', 19600),
('NVL011', 'Ong PVC 21', 'Cay', 44000),
('NVL012', 'Ong PVC 34', 'Cay', 61000),
('NVL013', 'Son Lot', 'Thung', 590000),
('NVL014', 'Son Phu', 'Thung', 840000),
('NVL015', 'Ngoi Mau Do', 'Vien', 11500),
('NVL016', 'Ngoi Mau Xanh', 'Vien', 11800),
('NVL017', 'Keo Dan Gach', 'Bao', 135000),
('NVL018', 'Keo Cha Ron', 'Bao', 145000),
('NVL019', 'Tam Tran Thach Cao', 'Tam', 98000),
('NVL020', 'Kinh Cuong Luc', 'm2', 690000);


-- Sanpham

INSERT INTO Sanpham (Masp, Tensp, Madm, Dvt, Giaban) VALUES

('SP001', 'Gach Ong 4 Lo', 1, 'Vien', 1800),
('SP002', 'Gach Ong 6 Lo', 1, 'Vien', 2200),
('SP003', 'Xi Mang PCB40', 2, 'Bao', 98000),
('SP004', 'Xi Mang PCB30', 2, 'Bao', 93000),
('SP005', 'Cat Xay Loai 1', 3, 'm3', 450000),
('SP006', 'Cat Xay Loai 2', 3, 'm3', 395000),
('SP007', 'Da 1x2', 4, 'm3', 560000),
('SP008', 'Da Mi', 4, 'm3', 610000),
('SP009', 'Thep D6', 5, 'Kg', 22000),
('SP010', 'Thep D10', 5, 'Kg', 24000),
('SP011', 'Ong PVC 21', 6, 'Cay', 60000),
('SP012', 'Ong PVC 34', 6, 'Cay', 84000),
('SP013', 'Son Noi That', 7, 'Thung', 930000),
('SP014', 'Son Ngoai That', 7, 'Thung', 1180000),
('SP015', 'Ngoi Mau Do', 8, 'Vien', 18500),
('SP016', 'Ngoi Mau Xanh', 8, 'Vien', 18800),
('SP017', 'Keo Dan Gach', 9, 'Bao', 155000),
('SP018', 'Keo Cha Ron', 9, 'Bao', 162000),
('SP019', 'Tam Tran Thach Cao', 10, 'Tam', 125000),
('SP020', 'Kinh Cuong Luc', 10, 'm2', 740000);


-- Congthucsanpham

INSERT INTO Congthucsanpham (Masp, Manvl, Soluong) VALUES

('SP001', 'NVL001', 1.5),
('SP001', 'NVL006', 0.75),
('SP002', 'NVL002', 2),
('SP002', 'NVL007', 0.5),
('SP003', 'NVL003', 1),
('SP003', 'NVL008', 0.75),
('SP004', 'NVL004', 1.5),
('SP004', 'NVL009', 0.5),
('SP005', 'NVL005', 2),
('SP005', 'NVL010', 0.75),
('SP006', 'NVL006', 1),
('SP006', 'NVL011', 0.5),
('SP007', 'NVL007', 1.5),
('SP007', 'NVL012', 0.75),
('SP008', 'NVL008', 2),
('SP008', 'NVL013', 0.5),
('SP009', 'NVL009', 1),
('SP009', 'NVL014', 0.75),
('SP010', 'NVL010', 1.5),
('SP010', 'NVL015', 0.5),
('SP011', 'NVL011', 2),
('SP011', 'NVL016', 0.75),
('SP012', 'NVL012', 1),
('SP012', 'NVL017', 0.5),
('SP013', 'NVL013', 1.5),
('SP013', 'NVL018', 0.75),
('SP014', 'NVL014', 2),
('SP014', 'NVL019', 0.5),
('SP015', 'NVL015', 1),
('SP015', 'NVL020', 0.75),
('SP016', 'NVL016', 1.5),
('SP016', 'NVL001', 0.5),
('SP017', 'NVL017', 2),
('SP017', 'NVL002', 0.75),
('SP018', 'NVL018', 1),
('SP018', 'NVL003', 0.5),
('SP019', 'NVL019', 1.5),
('SP019', 'NVL004', 0.75),
('SP020', 'NVL020', 2),
('SP020', 'NVL005', 0.5);


-- Loaikhachhang

INSERT INTO Loaikhachhang (Tenloaikh, Motaloaikh) VALUES

('Khach le', 'Khach hang mua le'),
('Dai ly cap 1', 'Dai ly lon'),
('Dai ly cap 2', 'Dai ly trung gian'),
('Cong trinh dan dung', 'Khach cong trinh nho'),
('Cong trinh thuong mai', 'Khach du an thuong mai'),
('Nha thau', 'Nha thau xay dung'),
('Khach than thiet', 'Co lich su mua hang tot'),
('Khach moi', 'Khach moi'),
('Doanh nghiep', 'Khach doanh nghiep'),
('Khach VIP', 'Khach hang uu tien');


-- Khachhang

INSERT INTO Khachhang (Makh, Tenkh, Sdtkh, Diachikh, Maloaikh) VALUES

('KH001', 'Khach Hang 01', '0910000001', 'So 1, Duong 1, Quan 1, TP HCM', 1),
('KH002', 'Khach Hang 02', '0910000002', 'So 2, Duong 2, Quan 2, TP HCM', 2),
('KH003', 'Khach Hang 03', '0910000003', 'So 3, Duong 3, Quan 3, TP HCM', 3),
('KH004', 'Khach Hang 04', '0910000004', 'So 4, Duong 4, Quan 4, TP HCM', 4),
('KH005', 'Khach Hang 05', '0910000005', 'So 5, Duong 5, Quan 5, TP HCM', 5),
('KH006', 'Khach Hang 06', '0910000006', 'So 6, Duong 6, Quan 1, TP HCM', 6),
('KH007', 'Khach Hang 07', '0910000007', 'So 7, Duong 7, Quan 2, TP HCM', 7),
('KH008', 'Khach Hang 08', '0910000008', 'So 8, Duong 8, Quan 3, TP HCM', 8),
('KH009', 'Khach Hang 09', '0910000009', 'So 9, Duong 9, Quan 4, TP HCM', 9),
('KH010', 'Khach Hang 10', '0910000010', 'So 10, Duong 10, Quan 5, TP HCM', 10),
('KH011', 'Khach Hang 11', '0910000011', 'So 11, Duong 11, Quan 1, TP HCM', 1),
('KH012', 'Khach Hang 12', '0910000012', 'So 12, Duong 12, Quan 2, TP HCM', 2),
('KH013', 'Khach Hang 13', '0910000013', 'So 13, Duong 13, Quan 3, TP HCM', 3),
('KH014', 'Khach Hang 14', '0910000014', 'So 14, Duong 14, Quan 4, TP HCM', 4),
('KH015', 'Khach Hang 15', '0910000015', 'So 15, Duong 15, Quan 5, TP HCM', 5),
('KH016', 'Khach Hang 16', '0910000016', 'So 16, Duong 16, Quan 1, TP HCM', 6),
('KH017', 'Khach Hang 17', '0910000017', 'So 17, Duong 17, Quan 2, TP HCM', 7),
('KH018', 'Khach Hang 18', '0910000018', 'So 18, Duong 18, Quan 3, TP HCM', 8),
('KH019', 'Khach Hang 19', '0910000019', 'So 19, Duong 19, Quan 4, TP HCM', 9),
('KH020', 'Khach Hang 20', '0910000020', 'So 20, Duong 20, Quan 5, TP HCM', 10);


-- Kho

INSERT INTO Kho (Makho, Tenkho, Diachi) VALUES

('K001', 'Kho Ha Noi', 'Ha Noi'),
('K002', 'Kho Hai Phong', 'Hai Phong'),
('K003', 'Kho Bac Ninh', 'Bac Ninh'),
('K004', 'Kho Hung Yen', 'Hung Yen'),
('K005', 'Kho Nam Dinh', 'Nam Dinh'),
('K006', 'Kho Thanh Hoa', 'Thanh Hoa'),
('K007', 'Kho Nghe An', 'Nghe An'),
('K008', 'Kho Da Nang', 'Da Nang'),
('K009', 'Kho Binh Duong', 'Binh Duong'),
('K010', 'Kho TP HCM', 'TP HCM');


-- Tonkho_nvl

INSERT INTO Tonkho_nvl (Makho, Manvl, Soluongton) VALUES

('K001', 'NVL001', 50),
('K001', 'NVL002', 61),
('K001', 'NVL003', 72),
('K001', 'NVL004', 83),
('K002', 'NVL003', 57),
('K002', 'NVL004', 68),
('K002', 'NVL005', 79),
('K002', 'NVL006', 90),
('K003', 'NVL005', 64),
('K003', 'NVL006', 75),
('K003', 'NVL007', 86),
('K003', 'NVL008', 97),
('K004', 'NVL007', 71),
('K004', 'NVL008', 82),
('K004', 'NVL009', 93),
('K004', 'NVL010', 104),
('K005', 'NVL009', 78),
('K005', 'NVL010', 89),
('K005', 'NVL011', 100),
('K005', 'NVL012', 111),
('K006', 'NVL011', 85),
('K006', 'NVL012', 96),
('K006', 'NVL013', 107),
('K006', 'NVL014', 118),
('K007', 'NVL013', 92),
('K007', 'NVL014', 103),
('K007', 'NVL015', 114),
('K007', 'NVL016', 125),
('K008', 'NVL015', 99),
('K008', 'NVL016', 110),
('K008', 'NVL017', 121),
('K008', 'NVL018', 132),
('K009', 'NVL017', 106),
('K009', 'NVL018', 117),
('K009', 'NVL019', 128),
('K009', 'NVL020', 139),
('K010', 'NVL019', 113),
('K010', 'NVL020', 124),
('K010', 'NVL001', 135),
('K010', 'NVL002', 146);


-- Tonkho_sp

INSERT INTO Tonkho_sp (Makho, Masp, Soluongton) VALUES

('K001', 'SP001', 80),
('K001', 'SP002', 93),
('K001', 'SP003', 106),
('K001', 'SP004', 119),
('K002', 'SP003', 85),
('K002', 'SP004', 98),
('K002', 'SP005', 111),
('K002', 'SP006', 124),
('K003', 'SP005', 90),
('K003', 'SP006', 103),
('K003', 'SP007', 116),
('K003', 'SP008', 129),
('K004', 'SP007', 95),
('K004', 'SP008', 108),
('K004', 'SP009', 121),
('K004', 'SP010', 134),
('K005', 'SP009', 100),
('K005', 'SP010', 113),
('K005', 'SP011', 126),
('K005', 'SP012', 139),
('K006', 'SP011', 105),
('K006', 'SP012', 118),
('K006', 'SP013', 131),
('K006', 'SP014', 144),
('K007', 'SP013', 110),
('K007', 'SP014', 123),
('K007', 'SP015', 136),
('K007', 'SP016', 149),
('K008', 'SP015', 115),
('K008', 'SP016', 128),
('K008', 'SP017', 141),
('K008', 'SP018', 154),
('K009', 'SP017', 120),
('K009', 'SP018', 133),
('K009', 'SP019', 146),
('K009', 'SP020', 159),
('K010', 'SP019', 125),
('K010', 'SP020', 138),
('K010', 'SP001', 151),
('K010', 'SP002', 164);


-- Phieunhap

INSERT INTO Phieunhap (Manhaphang, Mancc, Makho, Ngaynhaphang, Tongtiennhap, Ghichu) VALUES

('PN001', 'NCC001', 'K001', '2026-01-05', 7435250, 'Nhap hang dot 1'),
('PN002', 'NCC002', 'K002', '2026-01-08', 10929500, 'Nhap hang dot 2'),
('PN003', 'NCC003', 'K003', '2026-01-11', 546250, 'Nhap hang dot 3'),
('PN004', 'NCC004', 'K004', '2026-01-14', 1477800, 'Nhap hang dot 4'),
('PN005', 'NCC005', 'K005', '2026-01-17', 1781250, 'Nhap hang dot 5'),
('PN006', 'NCC006', 'K006', '2026-01-20', 24666500, 'Nhap hang dot 6'),
('PN007', 'NCC007', 'K007', '2026-01-23', 550450, 'Nhap hang dot 7'),
('PN008', 'NCC008', 'K008', '2026-01-26', 7742000, 'Nhap hang dot 8'),
('PN009', 'NCC009', 'K009', '2026-01-29', 16537250, 'Nhap hang dot 9'),
('PN010', 'NCC010', 'K010', '2026-02-01', 3991500, 'Nhap hang dot 10'),
('PN011', 'NCC001', 'K001', '2026-02-04', 13867750, 'Nhap hang dot 11'),
('PN012', 'NCC002', 'K002', '2026-02-07', 20206000, 'Nhap hang dot 12'),
('PN013', 'NCC003', 'K003', '2026-02-10', 1175750, 'Nhap hang dot 13'),
('PN014', 'NCC004', 'K004', '2026-02-13', 1317300, 'Nhap hang dot 14'),
('PN015', 'NCC005', 'K005', '2026-02-16', 3143750, 'Nhap hang dot 15');


-- Chitiet_Phieunhap

INSERT INTO Chitiet_Phieunhap (Manhaphang, Manvl, Soluong, Dongianhap) VALUES

('PN001', 'NVL003', 11, 320500),
('PN001', 'NVL004', 13, 300750),
('PN002', 'NVL005', 12, 431000),
('PN002', 'NVL006', 14, 411250),
('PN003', 'NVL007', 13, 19000),
('PN003', 'NVL008', 15, 19950),
('PN004', 'NVL009', 14, 20800),
('PN004', 'NVL010', 16, 21850),
('PN004', 'NVL011', 18, 46500),
('PN005', 'NVL011', 15, 46500),
('PN005', 'NVL012', 17, 63750),
('PN006', 'NVL013', 16, 593000),
('PN006', 'NVL014', 18, 843250),
('PN007', 'NVL015', 17, 15000),
('PN007', 'NVL016', 19, 15550),
('PN008', 'NVL017', 18, 139000),
('PN008', 'NVL018', 20, 149250),
('PN008', 'NVL019', 22, 102500),
('PN009', 'NVL019', 19, 102500),
('PN009', 'NVL020', 21, 694750),
('PN010', 'NVL001', 20, 97000),
('PN010', 'NVL002', 22, 93250),
('PN011', 'NVL003', 21, 325500),
('PN011', 'NVL004', 23, 305750),
('PN012', 'NVL005', 22, 436000),
('PN012', 'NVL006', 24, 416250),
('PN012', 'NVL007', 26, 24000),
('PN013', 'NVL007', 23, 24000),
('PN013', 'NVL008', 25, 24950),
('PN014', 'NVL009', 24, 25800),
('PN014', 'NVL010', 26, 26850),
('PN015', 'NVL011', 25, 51500),
('PN015', 'NVL012', 27, 68750);


-- Phieudieuchuyen

INSERT INTO Phieudieuchuyen (Madieuchuyen, Khoxuat, Khonhap, Ngaydieuchuyen, Ghichu, Trangthai) VALUES

('DC001', 'K001', 'K002', '2026-02-16', 'Dieu chuyen dot 1', 'dang_xu_ly'),
('DC002', 'K002', 'K003', '2026-02-18', 'Dieu chuyen dot 2', 'dang_xu_ly'),
('DC003', 'K003', 'K004', '2026-02-20', 'Dieu chuyen dot 3', 'hoan_thanh'),
('DC004', 'K004', 'K005', '2026-02-22', 'Dieu chuyen dot 4', 'dang_xu_ly'),
('DC005', 'K005', 'K006', '2026-02-24', 'Dieu chuyen dot 5', 'dang_xu_ly'),
('DC006', 'K006', 'K007', '2026-02-26', 'Dieu chuyen dot 6', 'hoan_thanh'),
('DC007', 'K007', 'K008', '2026-02-28', 'Dieu chuyen dot 7', 'dang_xu_ly'),
('DC008', 'K008', 'K009', '2026-03-02', 'Dieu chuyen dot 8', 'dang_xu_ly'),
('DC009', 'K009', 'K010', '2026-03-04', 'Dieu chuyen dot 9', 'hoan_thanh'),
('DC010', 'K010', 'K001', '2026-03-06', 'Dieu chuyen dot 10', 'dang_xu_ly');


-- Chitiet_Phieudieuchuyen

INSERT INTO Chitiet_Phieudieuchuyen (Madieuchuyen, Masp, Soluong) VALUES

('DC001', 'SP003', 17),
('DC001', 'SP004', 20),
('DC002', 'SP005', 19),
('DC002', 'SP006', 22),
('DC003', 'SP007', 21),
('DC003', 'SP008', 24),
('DC004', 'SP009', 23),
('DC004', 'SP010', 26),
('DC005', 'SP011', 25),
('DC005', 'SP012', 28),
('DC006', 'SP013', 27),
('DC006', 'SP014', 30),
('DC007', 'SP015', 29),
('DC007', 'SP016', 32),
('DC008', 'SP017', 31),
('DC008', 'SP018', 34),
('DC009', 'SP019', 33),
('DC009', 'SP020', 36),
('DC010', 'SP001', 35),
('DC010', 'SP002', 38);


-- Phieuxuat

INSERT INTO Phieuxuat (Maxuathang, Makh, Makho, Ngayxuat, Tongtienxuat, Ghichu) VALUES

('PX001', 'KH001', 'K004', '2026-02-01', 3727100, 'Xuat ban dot 1'),
('PX002', 'KH002', 'K005', '2026-02-03', 8840000, 'Xuat ban dot 2'),
('PX003', 'KH003', 'K006', '2026-02-05', 1683700, 'Xuat ban dot 3'),
('PX004', 'KH004', 'K007', '2026-02-07', 20266200, 'Xuat ban dot 4'),
('PX005', 'KH005', 'K008', '2026-02-09', 2024500, 'Xuat ban dot 5'),
('PX006', 'KH006', 'K009', '2026-02-11', 10556600, 'Xuat ban dot 6'),
('PX007', 'KH007', 'K010', '2026-02-13', 1516900, 'Xuat ban dot 7'),
('PX008', 'KH008', 'K001', '2026-02-15', 11646200, 'Xuat ban dot 8'),
('PX009', 'KH009', 'K002', '2026-02-17', 9763500, 'Xuat ban dot 9'),
('PX010', 'KH010', 'K003', '2026-02-19', 2624000, 'Xuat ban dot 10'),
('PX011', 'KH011', 'K004', '2026-02-21', 19638600, 'Xuat ban dot 11'),
('PX012', 'KH012', 'K005', '2026-02-23', 8731600, 'Xuat ban dot 12'),
('PX013', 'KH013', 'K006', '2026-02-25', 13940900, 'Xuat ban dot 13'),
('PX014', 'KH014', 'K007', '2026-02-27', 4387200, 'Xuat ban dot 14'),
('PX015', 'KH015', 'K008', '2026-03-01', 34246500, 'Xuat ban dot 15');


-- Chitiet_Phieuxuat

INSERT INTO Chitiet_Phieuxuat (Maxuathang, Masp, Soluong, Dongiaxuat) VALUES

('PX001', 'SP004', 6, 94200),
('PX001', 'SP005', 7, 451700),
('PX002', 'SP007', 7, 562400),
('PX002', 'SP008', 8, 612900),
('PX003', 'SP010', 8, 27600),
('PX003', 'SP011', 9, 64100),
('PX003', 'SP012', 10, 88600),
('PX004', 'SP013', 9, 934800),
('PX004', 'SP014', 10, 1185300),
('PX005', 'SP016', 10, 24800),
('PX005', 'SP017', 11, 161500),
('PX006', 'SP019', 11, 132200),
('PX006', 'SP020', 12, 747700),
('PX006', 'SP001', 13, 10000),
('PX007', 'SP002', 12, 10600),
('PX007', 'SP003', 13, 106900),
('PX008', 'SP005', 13, 459600),
('PX008', 'SP006', 14, 405100),
('PX009', 'SP008', 14, 620800),
('PX009', 'SP009', 15, 33300),
('PX009', 'SP010', 16, 35800),
('PX010', 'SP011', 15, 72000),
('PX010', 'SP012', 16, 96500),
('PX011', 'SP014', 16, 1193200),
('PX011', 'SP015', 17, 32200),
('PX012', 'SP017', 17, 169400),
('PX012', 'SP018', 18, 176900),
('PX012', 'SP019', 19, 140400),
('PX013', 'SP020', 18, 755600),
('PX013', 'SP001', 19, 17900),
('PX014', 'SP003', 19, 114800),
('PX014', 'SP004', 20, 110300),
('PX015', 'SP006', 20, 413000),
('PX015', 'SP007', 21, 578500),
('PX015', 'SP008', 22, 629000);


-- Lenhsanxuat

INSERT INTO Lenhsanxuat (Malenh, Masp, Ngaysanxuat, Soluongsanxuat, Trangthai, Ngaybatdau, Ngayketthuc, Ghichu) VALUES

('LSX001', 'SP003', '2026-03-08', 125, 'da_lap_ke_hoach', NULL, NULL, 'Lenh san xuat dot 1'),
('LSX002', 'SP005', '2026-03-10', 150, 'hoan_thanh', '2026-03-07', NULL, 'Lenh san xuat dot 2'),
('LSX003', 'SP007', '2026-03-12', 175, 'dang_xu_ly', NULL, '2026-03-14', 'Lenh san xuat dot 3'),
('LSX004', 'SP009', '2026-03-14', 200, 'da_lap_ke_hoach', '2026-03-11', NULL, 'Lenh san xuat dot 4'),
('LSX005', 'SP011', '2026-03-16', 225, 'hoan_thanh', NULL, NULL, 'Lenh san xuat dot 5'),
('LSX006', 'SP013', '2026-03-18', 250, 'dang_xu_ly', '2026-03-15', '2026-03-20', 'Lenh san xuat dot 6'),
('LSX007', 'SP015', '2026-03-20', 275, 'da_lap_ke_hoach', NULL, NULL, 'Lenh san xuat dot 7'),
('LSX008', 'SP017', '2026-03-22', 300, 'hoan_thanh', '2026-03-19', NULL, 'Lenh san xuat dot 8'),
('LSX009', 'SP019', '2026-03-24', 325, 'dang_xu_ly', NULL, '2026-03-26', 'Lenh san xuat dot 9'),
('LSX010', 'SP001', '2026-03-26', 350, 'da_lap_ke_hoach', '2026-03-23', NULL, 'Lenh san xuat dot 10'),
('LSX011', 'SP003', '2026-03-28', 375, 'hoan_thanh', NULL, NULL, 'Lenh san xuat dot 11'),
('LSX012', 'SP005', '2026-03-30', 400, 'dang_xu_ly', '2026-03-27', '2026-04-01', 'Lenh san xuat dot 12');


-- Chitiet_XuatNVL_Sanxuat

INSERT INTO Chitiet_XuatNVL_Sanxuat (Malenh, Manvl, Soluong) VALUES

('LSX001', 'NVL003', 33),
('LSX001', 'NVL004', 38),
('LSX002', 'NVL005', 36),
('LSX002', 'NVL006', 41),
('LSX003', 'NVL007', 39),
('LSX003', 'NVL008', 44),
('LSX004', 'NVL009', 42),
('LSX004', 'NVL010', 47),
('LSX005', 'NVL011', 45),
('LSX005', 'NVL012', 50),
('LSX006', 'NVL013', 48),
('LSX006', 'NVL014', 53),
('LSX007', 'NVL015', 51),
('LSX007', 'NVL016', 56),
('LSX008', 'NVL017', 54),
('LSX008', 'NVL018', 59),
('LSX009', 'NVL019', 57),
('LSX009', 'NVL020', 62),
('LSX010', 'NVL001', 60),
('LSX010', 'NVL002', 65),
('LSX011', 'NVL003', 63),
('LSX011', 'NVL004', 68),
('LSX012', 'NVL005', 66),
('LSX012', 'NVL006', 71);


-- Chitiet_Nhapsanpham_Sanxuat

INSERT INTO Chitiet_Nhapsanpham_Sanxuat (Malenh, Makho, Masp, Soluong) VALUES

('LSX001', 'K001', 'SP003', 110),
('LSX002', 'K002', 'SP005', 130),
('LSX003', 'K003', 'SP007', 150),
('LSX004', 'K004', 'SP009', 170),
('LSX005', 'K005', 'SP011', 190),
('LSX006', 'K006', 'SP013', 210),
('LSX007', 'K007', 'SP015', 230),
('LSX008', 'K008', 'SP017', 250),
('LSX009', 'K009', 'SP019', 270),
('LSX010', 'K010', 'SP001', 290),
('LSX011', 'K001', 'SP003', 310),
('LSX012', 'K002', 'SP005', 330);

