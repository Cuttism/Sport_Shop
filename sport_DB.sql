IF EXISTS (SELECT name FROM sys.databases WHERE name = N'sport_DB')
BEGIN
    ALTER DATABASE sport_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE sport_DB;
END
GO

CREATE DATABASE sport_DB;
GO
USE sport_DB;
GO

DROP TABLE IF EXISTS HOA_DON;
DROP TABLE IF EXISTS CHI_TIET_DON_HANG;
DROP TABLE IF EXISTS DON_HANG;
DROP TABLE IF EXISTS SAN_PHAM;
DROP TABLE IF EXISTS NHAN_VIEN_BAN_HANG;
DROP TABLE IF EXISTS NHAN_VIEN_KHO;
DROP TABLE IF EXISTS KHACH_HANG;
DROP TABLE IF EXISTS NHAN_VIEN_IT;
GO

CREATE TABLE NHAN_VIEN_IT (
    Id VARCHAR(50) PRIMARY KEY,          
    HoTen NVARCHAR(100) NOT NULL,        
    QuyenHan NVARCHAR(100) NOT NULL       
);

CREATE TABLE KHACH_HANG (
    Id VARCHAR(50) PRIMARY KEY,         
    HoTen NVARCHAR(100) NOT NULL,       
    DienThoai VARCHAR(20),                
    DiaChi NVARCHAR(255)                  
);

CREATE TABLE NHAN_VIEN_KHO (
    Id VARCHAR(50) PRIMARY KEY,          
    HoTen NVARCHAR(100) NOT NULL,         
    ViTriKho NVARCHAR(100)               
);

CREATE TABLE NHAN_VIEN_BAN_HANG (
    Id VARCHAR(50) PRIMARY KEY,         
    HoTen NVARCHAR(100) NOT NULL,         
    BoPhan NVARCHAR(100)                 
);

CREATE TABLE SAN_PHAM (
    Id VARCHAR(50) PRIMARY KEY,          
    TenSanPham NVARCHAR(150) NOT NULL,   
    SoLuongTon INT NOT NULL DEFAULT 0,   
    Gia DECIMAL(18, 2) NOT NULL           
);

CREATE TABLE DON_HANG (
    Id VARCHAR(50) PRIMARY KEY,         
    CustomerId VARCHAR(50) NOT NULL,     
    SalesStaffId VARCHAR(50) NOT NULL,    
    WarehouseStaffId VARCHAR(50) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,      
    TongTien DECIMAL(18, 2) NOT NULL,     
    FOREIGN KEY (CustomerId) REFERENCES KHACH_HANG(Id),
    FOREIGN KEY (SalesStaffId) REFERENCES NHAN_VIEN_BAN_HANG(Id),
    FOREIGN KEY (WarehouseStaffId) REFERENCES NHAN_VIEN_KHO(Id)
);

CREATE TABLE CHI_TIET_DON_HANG (
    Id VARCHAR(50) PRIMARY KEY,          
    OrderId VARCHAR(50) NOT NULL,        
    ProductId VARCHAR(50) NOT NULL,       
    SoLuong INT NOT NULL CHECK (SoLuong > 0), 
    DongGia DECIMAL(18, 2) NOT NULL,      
    FOREIGN KEY (OrderId) REFERENCES DON_HANG(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES SAN_PHAM(Id)
);

CREATE TABLE HOA_DON (
    Id VARCHAR(50) PRIMARY KEY,
    OrderId VARCHAR(50) NOT NULL,
    NgayLap DATE NOT NULL,
    PhuongThucThanhToan NVARCHAR(50) NOT NULL,
    TongTien DECIMAL(18, 2) NOT NULL,
    GhiChu NVARCHAR(255),
    FOREIGN KEY (OrderId) REFERENCES DON_HANG(Id)
);
GO

-- =============================================
-- DỮ LIỆU MẪU MỞ RỘNG CHO ANALYTICS
-- =============================================

INSERT INTO NHAN_VIEN_IT (Id, HoTen, QuyenHan) VALUES 
('NVIT01', N'Nguyễn Hoàng Long', N'Quản trị hệ thống tối cao'),
('NVIT02', N'Trần Minh Quân', N'Hỗ trợ kỹ thuật phần mềm');

INSERT INTO KHACH_HANG (Id, HoTen, DienThoai, DiaChi) VALUES 
('KH01', N'Phạm Minh Hoàng', '0934567890', N'Quận 7, TP. HCM'),
('KH02', N'Nguyễn Thị Bình', '0945678901', N'Đống Đa, Hà Nội'),
('KH03', N'Trần Văn An', '0956789012', N'Bình Thạnh, TP. HCM'),
('KH04', N'Lê Thị Hằng', '0967890123', N'Cầu Giấy, Hà Nội'),
('KH05', N'Võ Minh Tuấn', '0978901234', N'Hải Châu, Đà Nẵng'),
('KH06', N'Đặng Thị Lan', '0989012345', N'Ninh Kiều, Cần Thơ'),
('KH07', N'Bùi Quốc Huy', '0990123456', N'Thanh Xuân, Hà Nội');

INSERT INTO NHAN_VIEN_KHO (Id, HoTen, ViTriKho) VALUES 
('NVK01', N'Trần Văn Khoa', N'Kho hàng thể thao miền Nam'),
('NVK02', N'Lê Hồng Phong', N'Kho dụng cụ miền Bắc');

INSERT INTO NHAN_VIEN_BAN_HANG (Id, HoTen, BoPhan) VALUES 
('NVBH01', N'Nguyễn Thị Mai', N'Bộ phận Đồ thể thao nam'),
('NVBH02', N'Vũ Hoàng Nam', N'Bộ phận Giày & Phụ kiện');

INSERT INTO SAN_PHAM (Id, TenSanPham, SoLuongTon, Gia) VALUES 
('SP01', N'Giày Chạy Bộ Nike Air Max 2026', 50, 3500000.00),
('SP02', N'Áo Đấu CLB Manchester United', 100, 850000.00),
('SP03', N'Vợt Cầu Lông Yonex Astrox', 15, 4200000.00),
('SP04', N'Bóng Đá Adidas Champions League', 200, 950000.00),
('SP05', N'Quần Short Thể Thao Under Armour', 80, 650000.00),
('SP06', N'Găng Tay Tập Gym Nike Pro', 60, 450000.00),
('SP07', N'Giày Bóng Rổ Jordan Retro', 30, 5200000.00),
('SP08', N'Áo Khoác Gió Chạy Bộ Puma', 45, 1200000.00),
('SP09', N'Bình Nước Thể Thao CamelBak', 150, 380000.00),
('SP10', N'Dây Nhảy Speed Rope Pro', 120, 250000.00);

INSERT INTO DON_HANG (Id, CustomerId, SalesStaffId, WarehouseStaffId, TrangThai, TongTien) VALUES 
('DH01', 'KH01', 'NVBH01', 'NVK01', N'Đã thanh toán', 4350000.00),
('DH02', 'KH02', 'NVBH02', 'NVK02', N'Chờ xử lý', 4200000.00),
('DH03', 'KH03', 'NVBH01', 'NVK01', N'Đã thanh toán', 1600000.00),
('DH04', 'KH04', 'NVBH02', 'NVK02', N'Đang giao', 5200000.00),
('DH05', 'KH05', 'NVBH01', 'NVK01', N'Đã thanh toán', 2150000.00),
('DH06', 'KH01', 'NVBH02', 'NVK01', N'Đã thanh toán', 6150000.00),
('DH07', 'KH06', 'NVBH01', 'NVK02', N'Đã hủy', 950000.00),
('DH08', 'KH03', 'NVBH02', 'NVK01', N'Đã thanh toán', 3850000.00),
('DH09', 'KH07', 'NVBH01', 'NVK02', N'Chờ xử lý', 1500000.00),
('DH10', 'KH02', 'NVBH01', 'NVK01', N'Đã thanh toán', 4550000.00),
('DH11', 'KH05', 'NVBH02', 'NVK02', N'Đang giao', 850000.00),
('DH12', 'KH04', 'NVBH01', 'NVK01', N'Đã thanh toán', 7700000.00);

INSERT INTO CHI_TIET_DON_HANG (Id, OrderId, ProductId, SoLuong, DongGia) VALUES 
('CT01', 'DH01', 'SP01', 1, 3500000.00),
('CT02', 'DH01', 'SP02', 1, 850000.00),
('CT03', 'DH02', 'SP03', 1, 4200000.00),
('CT04', 'DH03', 'SP02', 1, 850000.00),
('CT05', 'DH03', 'SP09', 1, 380000.00),
('CT06', 'DH03', 'SP10', 1, 250000.00),
('CT07', 'DH04', 'SP07', 1, 5200000.00),
('CT08', 'DH05', 'SP05', 2, 650000.00),
('CT09', 'DH05', 'SP06', 1, 450000.00),
('CT10', 'DH06', 'SP01', 1, 3500000.00),
('CT11', 'DH06', 'SP04', 2, 950000.00),
('CT12', 'DH06', 'SP09', 2, 380000.00),
('CT13', 'DH07', 'SP04', 1, 950000.00),
('CT14', 'DH08', 'SP08', 1, 1200000.00),
('CT15', 'DH08', 'SP05', 1, 650000.00),
('CT16', 'DH08', 'SP01', 1, 3500000.00),
('CT17', 'DH09', 'SP02', 1, 850000.00),
('CT18', 'DH09', 'SP05', 1, 650000.00),
('CT19', 'DH10', 'SP03', 1, 4200000.00),
('CT20', 'DH10', 'SP10', 1, 250000.00),
('CT21', 'DH11', 'SP02', 1, 850000.00),
('CT22', 'DH12', 'SP07', 1, 5200000.00),
('CT23', 'DH12', 'SP01', 1, 3500000.00);

-- =============================================
-- HÓA ĐƠN (BILLS) - Chỉ tạo cho đơn hàng đã thanh toán
-- =============================================
INSERT INTO HOA_DON (Id, OrderId, NgayLap, PhuongThucThanhToan, TongTien, GhiChu) VALUES 
('HD01', 'DH01', '2026-06-15', N'Tiền mặt', 4350000.00, N'Khách thanh toán tại cửa hàng'),
('HD02', 'DH03', '2026-06-18', N'Chuyển khoản', 1600000.00, N'CK qua Vietcombank'),
('HD03', 'DH05', '2026-06-22', N'Tiền mặt', 2150000.00, NULL),
('HD04', 'DH06', '2026-06-25', N'Thẻ tín dụng', 6150000.00, N'Visa **** 4521'),
('HD05', 'DH08', '2026-07-01', N'Chuyển khoản', 3850000.00, N'CK qua MoMo'),
('HD06', 'DH10', '2026-07-05', N'Tiền mặt', 4550000.00, N'Khách VIP - giảm 5%'),
('HD07', 'DH12', '2026-07-10', N'Thẻ tín dụng', 7700000.00, N'Mastercard **** 8832');
GO

-- =============================================
-- ĐÁNH GIÁ SẢN PHẨM (REVIEWS)
-- =============================================
CREATE TABLE DANH_GIA_SAN_PHAM (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProductId VARCHAR(50) NOT NULL,
    CustomerId VARCHAR(50) NOT NULL,
    SoSao INT NOT NULL CHECK (SoSao BETWEEN 1 AND 5),
    NoiDung NVARCHAR(500),
    NgayDanhGia DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductId) REFERENCES SAN_PHAM(Id),
    FOREIGN KEY (CustomerId) REFERENCES KHACH_HANG(Id)
);
GO
