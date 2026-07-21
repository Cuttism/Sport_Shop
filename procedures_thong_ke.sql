-- ==========================================================
-- FILE CHỨA CÁC STORED PROCEDURE THỐNG KÊ (Dành cho Kế toán)
-- ==========================================================

USE sport_DB;
GO

-- 1. Procedure thống kê Sản phẩm Bán Chạy (Best-selling products)
-- Mục đích: Tìm các sản phẩm có số lượng tiêu thụ cao nhất từ những đơn hàng đã thanh toán.
IF OBJECT_ID('sp_ThongKeSanPhamBanChay', 'P') IS NOT NULL
    DROP PROCEDURE sp_ThongKeSanPhamBanChay;
GO

CREATE PROCEDURE sp_ThongKeSanPhamBanChay
    @TopN INT = 10 -- Số lượng sản phẩm muốn hiển thị (mặc định Top 10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@TopN)
        sp.Id AS MaSanPham,
        sp.TenSanPham,
        SUM(ct.SoLuong) AS TongSoLuongBan,
        SUM(ct.SoLuong * ct.DongGia) AS TongDoanhThu
    FROM SAN_PHAM sp
    JOIN CHI_TIET_DON_HANG ct ON sp.Id = ct.ProductId
    JOIN DON_HANG dh ON ct.OrderId = dh.Id
    WHERE dh.TrangThai = N'Đã thanh toán'
    GROUP BY sp.Id, sp.TenSanPham
    ORDER BY TongSoLuongBan DESC, TongDoanhThu DESC;
END;
GO


-- 2. Procedure thống kê Sản phẩm Bán Chậm hoặc Ế (Least-selling products)
-- Mục đích: Tìm các sản phẩm có số lượng tiêu thụ thấp nhất (hoặc chưa bán được) để lên kế hoạch sale xả kho.
IF OBJECT_ID('sp_ThongKeSanPhamBanCham', 'P') IS NOT NULL
    DROP PROCEDURE sp_ThongKeSanPhamBanCham;
GO

CREATE PROCEDURE sp_ThongKeSanPhamBanCham
    @TopN INT = 10 -- Số lượng sản phẩm muốn hiển thị (mặc định Top 10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@TopN)
        sp.Id AS MaSanPham,
        sp.TenSanPham,
        sp.SoLuongTon,
        ISNULL(SUM(ct.SoLuong), 0) AS TongSoLuongBan
    FROM SAN_PHAM sp
    LEFT JOIN CHI_TIET_DON_HANG ct ON sp.Id = ct.ProductId
    LEFT JOIN DON_HANG dh ON ct.OrderId = dh.Id AND dh.TrangThai = N'Đã thanh toán'
    GROUP BY sp.Id, sp.TenSanPham, sp.SoLuongTon
    ORDER BY TongSoLuongBan ASC, sp.SoLuongTon DESC;
END;
GO
