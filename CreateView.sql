-- 1. Thống kê mặt hàng thiết yếu
drop view V_ThongKe_MatHangThietYeu
CREATE VIEW V_ThongKe_MatHangThietYeu
AS
SELECT L.MaLoaiSP, L.TenLoaiSP, SP.MaSP, SP.TenSP, NCC.MaNCC, NCC.TenNCC, 
		SP.DonViTinh, SP_NCC.NSX, format(SP_NCC.Gia,'N','vi-VN') AS 'Gia', SUM(CT.SoLuong) AS 'SLBanRa'
FROM SanPham SP
LEFT JOIN LoaiSanPham L ON L.MaLoaiSP = SP.LoaiSP
LEFT JOIN SanPham_NCC SP_NCC ON SP_NCC.MaSP = SP.MaSP
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = SP_NCC.MaNCC
LEFT JOIN ChiTietDonHang CT ON CT.MaNCC = NCC.MaNCC AND CT.MaSP = SP.MaSP
WHERE NCC.TenNCC IS NOT NULL
GROUP BY L.MaLoaiSP, L.TenLoaiSP, SP.MaSP, SP.TenSP, NCC.MaNCC, NCC.TenNCC, 
		SP.DonViTinh, SP_NCC.NSX, SP_NCC.Gia


-- 2. Thống kê nhu cầu thực phẩm cùng kỳ
DROP VIEW V_ThongKe_NhuCau_CungKy
CREATE VIEW V_ThongKe_NhuCau_CungKy
AS
SELECT DISTINCT YEAR(DH.NgayLap) AS 'Nam', DATEPART(QQ, DH.NgayLap) AS 'Quy',
MONTH(DH.NgayLap) AS 'Thang', 
SP.MaSP, SP.TenSP, NCC.MaNCC, NCC.TenNCC , SP.DonViTinh, format(SP_NCC.Gia,'N','vi-VN') AS 'Gia',
SUM(CT.SoLuong) AS 'SLBanRa'
FROM ChiTietDonHang CT 
LEFT JOIN SanPham_NCC SP_NCC ON SP_NCC.MaNCC = CT.MaNCC AND SP_NCC.MaSP = CT.MaSP
LEFT JOIN SanPham SP ON SP.MaSP = CT.MaSP
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = CT.MaNCC
LEFT JOIN DonHang DH ON DH.MaDH = CT.MaDH
GROUP BY DH.NgayLap, NCC.MaNCC, NCC.TenNCC, SP.MaSP, SP.TenSP, SP.DonViTinh, SP_NCC.Gia


-- 3. Thống kê thu nhập cho các NCC
DROP VIEW V_ThongKe_ThuNhap_NCC
CREATE VIEW V_ThongKe_ThuNhap_NCC
AS
SELECT DISTINCT YEAR(DH.NgayLap) AS 'Nam', DATEPART(QQ, DH.NgayLap) AS 'Quy', 
MONTH(DH.NgayLap) AS 'Thang', NCC.MaNCC, NCC.TenNCC,
SUM(DH.TongTien) AS 'DoanhThu'
FROM DonHang DH 
LEFT JOIN ChiTietDonHang CT ON CT.MaDH = DH.MaDH
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = CT.MaNCC
WHERE DH.TrangThai = N'Đã giao'
GROUP BY YEAR(DH.NgayLap), DATEPART(QQ, DH.NgayLap), Month(DH.NgayLap), 
NCC.MaNCC, NCC.TenNCC


-- 4. Thống kê thu nhập cho các ĐVVC
DROP VIEW V_ThongKe_ThuNhap_DVVC
CREATE VIEW V_ThongKe_ThuNhap_DVVC
AS
SELECT DISTINCT YEAR(DH.NgayLap) AS 'Nam', DATEPART(QQ, DH.NgayLap) AS 'Quy', 
MONTH(DH.NgayLap) AS 'Thang', DVVC.MaDVVC, DVVC.TenDVVC,
SUM(DH.PhiVanChuyen) AS 'DoanhThu'
FROM DonHang DH 
LEFT JOIN ChiTietDonHang CT ON CT.MaDH = DH.MaDH
LEFT JOIN Shipper S ON S.MaShipper = DH.Shipper
LEFT JOIN DonViVanChuyen DVVC ON DVVC.MaDVVC = S.MaDVVC
WHERE DH.TrangThai = N'Đã giao'
GROUP BY YEAR(DH.NgayLap), DATEPART(QQ, DH.NgayLap), Month(DH.NgayLap), 
DVVC.MaDVVC, DVVC.TenDVVC


--DROP VIEW V_DonHang
CREATE VIEW V_DonHang
AS
SELECT DH.[MaDH]
      ,DH.[NgayLap]
      ,DH.[TongTien]
      ,DH.[TrangThai]
      ,DH.[HinhThucThanhToan]
	  ,DH.[PhiVanChuyen]
      ,KH.[MaKH]
	  ,KH.[TenKH]
      ,S.[MaShipper]
	  ,S.[TenShipper]
  FROM [DonHang] DH
  JOIN [Shipper] S ON S.MaShipper = DH.Shipper
  JOIN [KhachHang] KH ON KH.MaKH = DH.MaKH
