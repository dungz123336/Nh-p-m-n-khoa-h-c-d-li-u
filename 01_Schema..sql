
CREATE TABLE Danh_Muc (
    Ma_Danh_Muc VARCHAR(10) PRIMARY KEY,
    Ten_Danh_Muc VARCHAR(100) NOT NULL
);

CREATE TABLE Nha_Cung_Cap (
    Ma_Nha_Cung_Cap VARCHAR(10) PRIMARY KEY,
    Ten_Nha_Cung_Cap VARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(50),
    Dia_Chi VARCHAR(200)
);

CREATE TABLE San_Pham (
    Ma_San_Pham VARCHAR(10) PRIMARY KEY,
    Ten_San_Pham VARCHAR(100) NOT NULL,
    Gia DECIMAL(18, 2) DEFAULT 0,
    Ma_Danh_Muc VARCHAR(10),
    Ma_Nha_Cung_Cap VARCHAR(10),
    FOREIGN KEY (Ma_Danh_Muc) REFERENCES Danh_Muc(Ma_Danh_Muc),
    FOREIGN KEY (Ma_Nha_Cung_Cap) REFERENCES Nha_Cung_Cap(Ma_Nha_Cung_Cap)
);

CREATE TABLE Khuyen_Mai (
    Ma_Khuyen_Mai VARCHAR(10) PRIMARY KEY,
    Ten_Chuong_Trinh VARCHAR(100),
    Phan_Tram_Giam INT CHECK (Phan_Tram_Giam BETWEEN 0 AND 100),
    Ngay_Bat_Dau DATE,
    Ngay_Ket_Thuc DATE
);


CREATE TABLE Nhan_Vien (
    Ma_Nhan_Vien VARCHAR(10) PRIMARY KEY,
    Ho_Ten VARCHAR(100) NOT NULL,
    Vi_Tri VARCHAR(50),
    Ngay_Vao_Lam DATE,
    SDT VARCHAR(15)
);


CREATE TABLE Khach_Hang (
    Ma_Khach_Hang VARCHAR(10) PRIMARY KEY,
    Ho_Ten VARCHAR(100) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(50),
    Dia_Chi VARCHAR(200)
);


CREATE TABLE Don_Hang (
    Ma_Don_Hang VARCHAR(10) PRIMARY KEY,
    Ngay_Mua DATE DEFAULT CURRENT_TIMESTAMP,
    Ma_Khach_Hang VARCHAR(10),
    Ma_Nhan_Vien VARCHAR(10),
    Ma_Khuyen_Mai VARCHAR(10),
    FOREIGN KEY (Ma_Khach_Hang) REFERENCES Khach_Hang(Ma_Khach_Hang),
    FOREIGN KEY (Ma_Nhan_Vien) REFERENCES Nhan_Vien(Ma_Nhan_Vien),
    FOREIGN KEY (Ma_Khuyen_Mai) REFERENCES Khuyen_Mai(Ma_Khuyen_Mai)
);

CREATE TABLE Chi_Tiet_Don_Hang (
    Ma_Chi_Tiet_Don_Hang SERIAL PRIMARY KEY,
    Ma_Don_Hang VARCHAR(10),
    Ma_San_Pham VARCHAR(10),
    So_Luong INT CHECK (So_Luong > 0),
    Gia_Ban DECIMAL(18, 2), -- Giá tại thời điểm chốt đơn
    FOREIGN KEY (Ma_Don_Hang) REFERENCES Don_Hang(Ma_Don_Hang),
    FOREIGN KEY (Ma_San_Pham) REFERENCES San_Pham(Ma_San_Pham)
);
	