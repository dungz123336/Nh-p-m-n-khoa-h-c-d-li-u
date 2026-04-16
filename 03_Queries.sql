-- Yêu Cầu 4: Truy vấn Báo cáo Bán hàng Cơ bản
-- Lấy 10 giao dịch gần đây nhất
SELECT 
    dh.MaDH, 
    kh.TenKH, 
    nv.TenNV AS NhanVienBanHang, 
    dh.NgayMua,
    SUM(ct.SoLuong * ct.GiaTaiThoiDiemMua) AS TongTien
FROM DON_HANG dh
JOIN KHACH_HANG kh ON dh.MaKH = kh.MaKH
JOIN NHAN_VIEN nv ON dh.MaNV = nv.MaNV
JOIN CHI_TIET_DON_HANG ct ON dh.MaDH = ct.MaDH
GROUP BY 
    dh.MaDH, 
    kh.TenKH, 
    nv.TenNV, 
    dh.NgayMua
ORDER BY 
    dh.NgayMua DESC
LIMIT 10;

-- Yêu Cầu 5: Thống kê Doanh thu theo Danh mục
-- Lọc các danh mục có doanh thu > 1,000,000đ và sắp xếp giảm dần
SELECT 
    dm.TenDM, 
    SUM(ct.SoLuong * ct.GiaTaiThoiDiemMua) AS TongDoanhThu
FROM DANH_MUC dm
JOIN SAN_PHAM sp ON dm.MaDM = sp.MaDM
JOIN CHI_TIET_DON_HANG ct ON sp.MaSP = ct.MaSP
GROUP BY 
    dm.MaDM, 
    dm.TenDM
HAVING 
    SUM(ct.SoLuong * ct.GiaTaiThoiDiemMua) > 1000000
ORDER BY 
    TongDoanhThu DESC;

-- Yêu Cầu 6: Truy vấn con để Lọc Sản phẩm
-- Tìm tên và giá sản phẩm của 'Công ty Thực phẩm Hảo Hạng'
SELECT 
    TenSP, 
    GiaHienTai
FROM SAN_PHAM
WHERE MaNCC = (
    SELECT MaNCC 
    FROM NHA_CUNG_CAP 
    WHERE TenNCC = N'Công ty Thực phẩm Hảo Hạng'
);

-- Yêu Cầu 7: Phân tích Xếp hạng Nhân viên
-- Xếp hạng nhân viên theo tổng doanh thu trong tháng 10/2025
SELECT 
    nv.TenNV,
    SUM(ct.SoLuong * ct.GiaTaiThoiDiemMua) AS TongDoanhThu,
    DENSE_RANK() OVER (ORDER BY SUM(ct.SoLuong * ct.GiaTaiThoiDiemMua) DESC) AS ThuHang
FROM NHAN_VIEN nv
JOIN DON_HANG dh ON nv.MaNV = dh.MaNV
JOIN CHI_TIET_DON_HANG ct ON dh.MaDH = ct.MaDH
WHERE 
    dh.NgayMua >= '2025-10-01' AND dh.NgayMua <= '2025-10-31'
GROUP BY 
    nv.MaNV, 
    nv.TenNV
ORDER BY 
    ThuHang;

-- Yêu Cầu 8: Phân tích Hiệu năng Truy vấn (Chưa có Index)

-- Bước 1: Chèn thêm 50,000 khách hàng ảo để mô phỏng dữ liệu lớn
-- Bắt đầu từ ID 100 đến 50099 để không trùng với 50 khách hàng đã tạo ở Y3
INSERT INTO KHACH_HANG (MaKH, TenKH, SoDienThoai, Email, DiaChi)
SELECT 
    i, 
    'Khach hang Test ' || i, 
    '03' || lpad(i::text, 8, '0'), 
    'testemail' || i || '@example.com', 
    'Dia chi Test ' || i
FROM generate_series(100, 50099) AS i;

-- Bước 2: Chạy lệnh tìm kiếm có đo lường hiệu năng
EXPLAIN ANALYZE 
SELECT * FROM KHACH_HANG WHERE Email = 'testemail25000@example.com';

-- Y9: Tối ưu hóa Hiệu năng (Tạo Index)
-- Bước 1: Tạo Index trên cột Email của bảng KHACH_HANG
CREATE INDEX idx_khachhang_email ON KHACH_HANG(Email);

-- Bước 2: Chạy lại chính xác câu lệnh EXPLAIN ANALYZE ở Y8
EXPLAIN ANALYZE 
SELECT * FROM KHACH_HANG WHERE Email = 'testemail25000@example.com';

