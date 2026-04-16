-- 1. Bảng Danh mục sản phẩm
CREATE TABLE DANH_MUC (
    MaDM INT PRIMARY KEY,
    TenDM VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Bảng Nhà cung cấp
CREATE TABLE NHA_CUNG_CAP (
    MaNCC INT PRIMARY KEY,
    TenNCC VARCHAR(150) NOT NULL,
    ThongTinLienHe VARCHAR(255)
);

-- 3. Bảng Khách hàng
CREATE TABLE KHACH_HANG (
    MaKH INT PRIMARY KEY,
    TenKH VARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(15) UNIQUE, 
    Email VARCHAR(100) UNIQUE,
    DiaChi VARCHAR(255)
);

-- 4. Bảng Nhân viên
CREATE TABLE NHAN_VIEN (
    MaNV INT PRIMARY KEY,
    TenNV VARCHAR(100) NOT NULL,
    ViTri VARCHAR(50) DEFAULT N'Thu ngân', -- Ràng buộc DEFAULT
    NgayVaoLam DATE DEFAULT CURRENT_DATE
);

-- 5. Bảng Chương trình khuyến mãi
CREATE TABLE KHUYEN_MAI (
    MaKM INT PRIMARY KEY,
    TenKM VARCHAR(200) NOT NULL,
    MoTa VARCHAR(500),
    PhanTramGiam DECIMAL(5, 2) CHECK (PhanTramGiam >= 0 AND PhanTramGiam <= 100), -- Ràng buộc CHECK
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    CONSTRAINT CHK_NgayHopLe CHECK (NgayKetThuc >= NgayBatDau) -- Đảm bảo ngày kết thúc sau ngày bắt đầu
);

-- 6. Bảng Sản phẩm
CREATE TABLE SAN_PHAM (
    MaSP INT PRIMARY KEY,
    TenSP VARCHAR(200) NOT NULL,
    GiaHienTai DECIMAL(18, 2) NOT NULL CHECK (GiaHienTai >= 0),
    MaDM INT NOT NULL,
    MaNCC INT NOT NULL,
    FOREIGN KEY (MaDM) REFERENCES DANH_MUC(MaDM),
    FOREIGN KEY (MaNCC) REFERENCES NHA_CUNG_CAP(MaNCC)
);

-- 7. Bảng Đơn hàng
CREATE TABLE DON_HANG (
    MaDH INT PRIMARY KEY,
    NgayMua DATE DEFAULT CURRENT_TIMESTAMP,
    MaKH INT NOT NULL,
    MaNV INT NOT NULL,
    MaKM INT NULL, -- Cho phép NULL vì có thể đơn hàng không áp dụng khuyến mãi
    FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH),
    FOREIGN KEY (MaNV) REFERENCES NHAN_VIEN(MaNV),
    FOREIGN KEY (MaKM) REFERENCES KHUYEN_MAI(MaKM)
);

-- 8. Bảng Chi tiết đơn hàng
CREATE TABLE CHI_TIET_DON_HANG (
    MaDH INT,
    MaSP INT,
    SoLuong INT NOT NULL DEFAULT 1 CHECK (SoLuong > 0),
    GiaTaiThoiDiemMua DECIMAL(18, 2) NOT NULL CHECK (GiaTaiThoiDiemMua >= 0),
    PRIMARY KEY (MaDH, MaSP), -- Khóa chính kết hợp từ 2 cột
    FOREIGN KEY (MaDH) REFERENCES DON_HANG(MaDH),
    FOREIGN KEY (MaSP) REFERENCES SAN_PHAM(MaSP)
);
