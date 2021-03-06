CREATE DATABASE [QL_DiChoThue]
GO

USE [QL_DiChoThue]
GO
/****** Object:  UserDefinedFunction [dbo].[F_TongTienHoaDon]    Script Date: 23/12/2021 9:26:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_TongTienHoaDon] (@HD INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @KQ FLOAT = 0
	DECLARE @I FLOAT

	DECLARE C CURSOR FOR
	SELECT SP.Gia
	FROM ChiTietDonHang CT, SanPham_NCC SP
	WHERE CT.MaSP = SP.MaSP
	AND CT.MaDH = @HD

	OPEN C

	FETCH NEXT FROM C INTO @I
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @KQ = @KQ + @I
		FETCH NEXT FROM C INTO @I
	END

	CLOSE C
	DEALLOCATE C

	RETURN @KQ
END
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 23/12/2021 9:26:36 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [int] IDENTITY(1,1) NOT NULL,
	[TenNCC] [nvarchar](50) NOT NULL,
	[GiayPhepKinhDoanh] [varchar](50) NOT NULL,
	[SDT] [varchar](10) NOT NULL,
	[Email] [varchar](50) NULL,
	[SoTaiKhoanNganHang] [varchar](50) NULL,
	[TaiKhoan] [int] NULL,
	[VanChuyen] [int] NULL,
	[XaPhuong] [nvarchar](50) NULL,
	[QuanHuyen] [nvarchar](50) NULL,
	[TinhTP] [nvarchar](50) NULL,
	[LoaiVungDich] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham_NCC]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham_NCC](
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[NSX] [nvarchar](50) NULL,
	[Gia] [float] NULL,
	[HSD] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC,
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[MaLoaiSP] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSP] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](50) NOT NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[LoaiSP] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ThongKe_MatHangThietYeu]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ThongKe_MatHangThietYeu]
AS
SELECT L.MaLoaiSP, L.TenLoaiSP, SP.MaSP, SP.TenSP, NCC.MaNCC, NCC.TenNCC, 
		SP.DonViTinh, SP_NCC.NSX, SP_NCC.Gia
FROM SanPham SP
LEFT JOIN LoaiSanPham L ON L.MaLoaiSP = SP.LoaiSP
LEFT JOIN SanPham_NCC SP_NCC ON SP_NCC.MaSP = SP.MaSP
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = SP_NCC.MaNCC
WHERE NCC.TenNCC IS NOT NULL
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[TenKH] [nvarchar](50) NOT NULL,
	[NgaySinh] [datetime] NULL,
	[SDT] [varchar](10) NOT NULL,
	[Email] [varchar](50) NULL,
	[CMND] [varchar](20) NULL,
	[MaLoaiKH] [int] NULL,
	[TaiKhoan] [int] NULL,
	[SoNha] [nvarchar](50) NULL,
	[XaPhuong] [nvarchar](50) NULL,
	[QuanHuyen] [nvarchar](50) NULL,
	[TinhTP] [nvarchar](50) NULL,
	[LoaiVungDich] [nvarchar](50) NULL,
	[GioiTinh] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDH] [int] IDENTITY(1,1) NOT NULL,
	[NgayLap] [datetime] NULL,
	[TongTien] [float] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[MaKH] [int] NOT NULL,
	[HinhThucThanhToan] [nvarchar](50) NULL,
	[PhiVanChuyen] [float] NULL,
	[Shipper] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipper]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipper](
	[MaShipper] [int] IDENTITY(1,1) NOT NULL,
	[TenShipper] [nvarchar](100) NULL,
	[SDT] [varchar](10) NOT NULL,
	[Email] [varchar](50) NULL,
	[CMND] [varchar](20) NULL,
	[NgaySinh] [datetime] NULL,
	[MaDVVC] [int] NULL,
	[TaiKhoan] [int] NULL,
	[XaPhuong] [nvarchar](50) NULL,
	[QuanHuyen] [nvarchar](50) NULL,
	[TinhTP] [nvarchar](50) NULL,
	[GioiTinh] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaShipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DonHang]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DonHang]
AS
SELECT DH.MaDH, DH.NgayLap, DH.TongTien, DH.TrangThai, DH.HinhThucThanhToan, DH.PhiVanChuyen,
KH.MaKH, KH.TenKH, S.MaShipper, S.TenShipper
FROM DonHang DH
JOIN KhachHang KH ON DH.MaKH = KH.MaKH
JOIN Shipper S ON DH.Shipper = S.MaShipper
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaDH] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[SoLuong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC,
	[MaSP] ASC,
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ChiTietDonHang]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ChiTietDonHang]
AS
SELECT ROW_NUMBER() OVER( ORDER BY CT.MaDH, SP.MaSP, NCC.MaNCC ) AS ID,                           
CT.MaDH, SP.MaSP, SP.TenSP, NCC.MaNCC, NCC.TenNCC, SPNCC.NSX, SPNCC.Gia, CT.SoLuong
FROM ChiTietDonHang CT
JOIN SanPham_NCC SPNCC ON CT.MaSP = SPNCC.MaSP AND CT.MaNCC = SPNCC.MaNCC
LEFT JOIN SanPham SP ON CT.MaSP = SP.MaSP
LEFT JOIN NhaCungCap NCC ON CT.MaNCC = NCC.MaNCC
GO
/****** Object:  Table [dbo].[DonViVanChuyen]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonViVanChuyen](
	[MaDVVC] [int] IDENTITY(1,1) NOT NULL,
	[TenDVVC] [nvarchar](50) NOT NULL,
	[GiayPhepKinhDoanh] [varchar](50) NOT NULL,
	[SoTaiKhoanNganHang] [varchar](50) NULL,
	[SDT] [varchar](10) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[PhiVanChuyen_KM] [float] NULL,
	[TaiKhoan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDVVC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ThongKe_ThuNhap_DVVC]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ThongKe_ThuNhap_DVVC]
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
GO
/****** Object:  View [dbo].[V_ThongKe_ThuNhap_NCC]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_ThongKe_ThuNhap_NCC]
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
GO
/****** Object:  View [dbo].[V_ThongKe_NhuCau_CungKy]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ThongKe_NhuCau_CungKy]
AS
SELECT DISTINCT YEAR(DH.NgayLap) AS 'Nam', DATEPART(QQ, DH.NgayLap) AS 'Quy',
MONTH(DH.NgayLap) AS 'Thang', 
SP.MaSP, SP.TenSP, NCC.MaNCC, NCC.TenNCC , SP.DonViTinh, SP_NCC.Gia,
SUM(CT.SoLuong) AS 'SLBanRa'
FROM ChiTietDonHang CT 
LEFT JOIN SanPham_NCC SP_NCC ON SP_NCC.MaNCC = CT.MaNCC AND SP_NCC.MaSP = CT.MaSP
LEFT JOIN SanPham SP ON SP.MaSP = CT.MaSP
LEFT JOIN NhaCungCap NCC ON NCC.MaNCC = CT.MaNCC
LEFT JOIN DonHang DH ON DH.MaDH = CT.MaDH
GROUP BY DH.NgayLap, NCC.MaNCC, NCC.TenNCC, SP.MaSP, SP.TenSP, SP.DonViTinh, SP_NCC.Gia
GO
/****** Object:  Table [dbo].[BlackList]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlackList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NOT NULL,
	[LyDo] [varchar](50) NULL,
	[MucDo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTiet_PYC]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTiet_PYC](
	[MaPYC] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[SoLuong] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoSo_DVVC]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoSo_DVVC](
	[MaHS_DVVC] [int] IDENTITY(1,1) NOT NULL,
	[MaDVVC] [int] NULL,
	[AnhHS] [nvarchar](200) NULL,
	[NgayNhan] [datetime] NULL,
	[NgayKiemTra] [datetime] NULL,
	[TrangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHS_DVVC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoSo_NCC]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoSo_NCC](
	[MaHS_NCC] [int] IDENTITY(1,1) NOT NULL,
	[MaNCC] [int] NULL,
	[AnhHS] [nvarchar](200) NULL,
	[NgayNhan] [datetime] NULL,
	[NgayKiemTra] [datetime] NULL,
	[TrangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHS_NCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoSo_Shipper]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoSo_Shipper](
	[MaHS_Shipper] [int] IDENTITY(1,1) NOT NULL,
	[MaShipper] [int] NULL,
	[AnhHS] [nvarchar](200) NULL,
	[NgayNhan] [datetime] NULL,
	[NgayKiemTra] [datetime] NULL,
	[TrangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHS_Shipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiKhachHang]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiKhachHang](
	[MaLoaiKH] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiKH] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanHoi_KH]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanHoi_KH](
	[MaPhanHoi_KH] [int] IDENTITY(1,1) NOT NULL,
	[ThoiGian] [datetime] NULL,
	[MaKH] [int] NULL,
	[NoiDung] [nvarchar](100) NULL,
	[TrangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhanHoi_KH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanHoi_NCC]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanHoi_NCC](
	[MaPhanHoi_NCC] [int] IDENTITY(1,1) NOT NULL,
	[ThoiGian] [datetime] NULL,
	[MaNCC] [int] NULL,
	[NoiDung] [nvarchar](100) NULL,
	[TrangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhanHoi_NCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanHoi_Shipper]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanHoi_Shipper](
	[MaPhanHoi_Shipper] [int] IDENTITY(1,1) NOT NULL,
	[ThoiGian] [datetime] NULL,
	[MaShipper] [int] NULL,
	[NoiDung] [nvarchar](100) NULL,
	[TrangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhanHoi_Shipper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDangKy_CungUng]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKy_CungUng](
	[MaPhieuDKCU] [int] IDENTITY(1,1) NOT NULL,
	[MaNCC] [int] NOT NULL,
	[NgayDK] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuDKCU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDangKy_VanChuyen]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKy_VanChuyen](
	[MaPhieuDKVC] [int] IDENTITY(1,1) NOT NULL,
	[MaDVVC] [int] NOT NULL,
	[NgayDK] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuDKVC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDangKyDiCho]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKyDiCho](
	[MaPhieuDKDC] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NOT NULL,
	[NgayDK] [datetime] NULL,
	[SoThanhVienGD] [int] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuDKDC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuYeuCauMuaHang]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuYeuCauMuaHang](
	[MaPYC] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NOT NULL,
	[NgayLapPhieu] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPYC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham_Chon]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham_Chon](
	[MaKH] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[MaNCC] [int] NOT NULL,
	[ThoiGianChon] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC,
	[MaSP] ASC,
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
	[VaiTro] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BlackList] ON 

INSERT [dbo].[BlackList] ([ID], [MaKH], [LyDo], [MucDo]) VALUES (1, 3, N'Ð?t cho vui', 1)
SET IDENTITY_INSERT [dbo].[BlackList] OFF
GO
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 4, 1, 2)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 4, 2, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 2, 2, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 1, 3, 1)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 2, 3)
INSERT [dbo].[ChiTiet_PYC] ([MaPYC], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 3, 1)
GO
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 1, 3, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (1, 4, 2, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 1, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (2, 4, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 2, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (3, 4, 3, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 4, 2, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (4, 4, 3, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 1, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 1, 3, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 2, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (7, 4, 3, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (8, 1, 3, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (8, 4, 2, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (9, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (9, 2, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (9, 4, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (10, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (10, 4, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (10, 4, 2, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (11, 1, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (11, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (12, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (12, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (12, 4, 3, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (13, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (13, 2, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (13, 4, 3, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (14, 1, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (14, 4, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (14, 4, 2, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (15, 2, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (15, 4, 3, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (16, 1, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (16, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (16, 4, 2, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (19, 1, 3, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (19, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (19, 4, 2, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (20, 2, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (20, 4, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (20, 4, 2, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (22, 1, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (22, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (22, 4, 2, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (23, 1, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (23, 2, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (24, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (24, 4, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (24, 4, 3, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (25, 1, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (25, 4, 2, 6)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (26, 1, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (26, 4, 3, 6)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (27, 1, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (27, 2, 1, 7)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (27, 4, 2, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (28, 1, 1, 8)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (28, 2, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (29, 4, 2, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (29, 4, 3, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (30, 1, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (30, 2, 1, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (31, 1, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (32, 2, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (32, 4, 2, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (33, 2, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (33, 4, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (34, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (34, 4, 3, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (35, 1, 1, 7)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (36, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (36, 4, 3, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (37, 1, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (37, 4, 2, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (38, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (38, 4, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (39, 4, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (40, 1, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (41, 2, 1, 6)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (42, 4, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (42, 4, 2, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (43, 4, 3, 4)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (44, 1, 1, 5)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (45, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (46, 1, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (46, 4, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (46, 4, 2, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (47, 1, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (47, 4, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (48, 1, 1, 3)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (48, 2, 1, 1)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (48, 3, 1, 2)
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaSP], [MaNCC], [SoLuong]) VALUES (48, 5, 15, 2)
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (1, CAST(N'2021-09-12T00:00:00.000' AS DateTime), 289500, N'Đang giao', 1, N'Tiền mặt', 20000, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (2, CAST(N'2021-09-12T00:00:00.000' AS DateTime), 127500, N'Đang giao', 2, N'Chuyển khoản', 12000, 3)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (3, CAST(N'2021-09-12T00:00:00.000' AS DateTime), 217500, N'Đang giao', 4, N'Tiền mặt', 15000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (4, CAST(N'2021-10-21T00:00:00.000' AS DateTime), 362000, N'Đã giao', 1, N'Tiền mặt', 25000, 5)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (7, CAST(N'2021-11-01T00:00:00.000' AS DateTime), 344500, N'Đổi trả', 2, N'Chuyển khoản', 32000, 6)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (8, CAST(N'2021-11-02T00:00:00.000' AS DateTime), 127500, N'Đã giao', 3, N'Chuyển khoản', 9000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (9, CAST(N'2021-08-02T00:00:00.000' AS DateTime), 289500, N'Đã giao', 4, N'Tiền mặt', 19000, 5)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (10, CAST(N'2021-07-19T00:00:00.000' AS DateTime), 200000, N'Đã giao', 4, N'Chuyển khoản', 31000, 6)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (11, CAST(N'2021-08-01T00:00:00.000' AS DateTime), 217000, N'Đổi trả', 1, N'Tiền mặt', 50000, 3)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (12, CAST(N'2021-11-21T00:00:00.000' AS DateTime), 289500, N'Đã giao', 2, N'Chuyển khoản', 38000, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (13, CAST(N'2020-11-01T00:00:00.000' AS DateTime), 289500, N'Đã giao', 3, N'Tiền mặt', 12500, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (14, CAST(N'2020-04-12T00:00:00.000' AS DateTime), 200000, N'Đã giao', 1, N'Chuyển khoản', 5000, 3)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (15, CAST(N'2020-06-30T00:00:00.000' AS DateTime), 234500, N'Đã giao', 4, N'Tiền mặt', 13000, 6)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (16, CAST(N'2020-12-12T00:00:00.000' AS DateTime), 289500, N'Đã giao', 2, N'Tiền mặt', 33000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (19, CAST(N'2019-10-01T00:00:00.000' AS DateTime), 289500, N'Đã giao', 1, N'Tiền mặt', 10000, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (20, CAST(N'2019-02-02T00:00:00.000' AS DateTime), 307000, N'Đã giao', 2, N'Tiền mặt', 12000, 3)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (22, CAST(N'2019-04-12T00:00:00.000' AS DateTime), 289500, N'Đã giao', 4, N'Tiền mặt', 2000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (23, CAST(N'2019-06-02T00:00:00.000' AS DateTime), 217000, N'Đã giao', 2, N'Tiền mặt', 23000, 5)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (24, CAST(N'2020-02-21T00:00:00.000' AS DateTime), 307000, N'Đã giao', 3, N'Chuyển khoản', 29000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (25, CAST(N'2019-12-20T00:00:00.000' AS DateTime), 127500, N'Đã giao', 1, N'Chuyển khoản', 50000, 1)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (26, CAST(N'2020-01-11T00:00:00.000' AS DateTime), 127500, N'Đã giao', 2, N'Tiền mặt', 92000, 1)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (27, CAST(N'2019-11-30T00:00:00.000' AS DateTime), 289500, N'Đã giao', 3, N'Chuyển khoản', 43000, 3)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (28, CAST(N'2020-04-21T00:00:00.000' AS DateTime), 217000, N'Đã giao', 4, N'Tiền mặt', 31000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (29, CAST(N'2018-12-02T00:00:00.000' AS DateTime), 145000, N'Đã giao', 1, N'Tiền mặt', 20999, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (30, CAST(N'2018-02-01T00:00:00.000' AS DateTime), 217000, N'Đã giao', 4, N'Chuyển khoản', 92000, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (31, CAST(N'2018-05-01T00:00:00.000' AS DateTime), 55000, N'Đã giao', 2, N'Chuyển khoản', 19000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (32, CAST(N'2017-12-01T00:00:00.000' AS DateTime), 234500, N'Đã giao', 3, N'Tiền mặt', 32900, 6)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (33, CAST(N'2017-03-01T00:00:00.000' AS DateTime), 234500, N'Đã giao', 1, N'Tiền mặt', 54900, 5)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (34, CAST(N'2017-07-30T00:00:00.000' AS DateTime), 234500, N'Đã giao', 2, N'Chuyển khoản', 96900, 6)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (35, CAST(N'2016-12-01T00:00:00.000' AS DateTime), 55000, N'Đã giao', 3, N'Tiền mặt', 34000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (36, CAST(N'2016-05-01T00:00:00.000' AS DateTime), 234500, N'Đã giao', 4, N'Chuyển khoản', 90300, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (37, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 127500, N'Đã giao', 2, N'Tiền mặt', 23000, 1)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (38, CAST(N'2021-02-01T00:00:00.000' AS DateTime), 234500, N'Đã giao', 1, N'Chuyển khoản', 27000, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (39, CAST(N'2021-03-01T00:00:00.000' AS DateTime), 72500, N'Đã giao', 4, N'Tiền mặt', 99000, 3)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (40, CAST(N'2021-04-01T00:00:00.000' AS DateTime), 55000, N'Đã giao', 3, N'Tiền mặt', 54000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (41, CAST(N'2021-05-01T00:00:00.000' AS DateTime), 162000, N'Đã giao', 1, N'Chuyển khoản', 23000, 1)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (42, CAST(N'2021-06-01T00:00:00.000' AS DateTime), 145000, N'Đã giao', 3, N'Chuyển khoản', 21000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (43, CAST(N'2021-07-01T00:00:00.000' AS DateTime), 72500, N'Đã giao', 1, N'Chuyển khoản', 74000, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (44, CAST(N'2021-08-01T00:00:00.000' AS DateTime), 55000, N'Đã giao', 2, N'Tiền mặt', 90000, 4)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (45, CAST(N'2021-09-01T00:00:00.000' AS DateTime), 55000, N'Đã giao', 4, N'Tiền mặt', 12000, 1)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (46, CAST(N'2021-10-01T00:00:00.000' AS DateTime), 200000, N'Đã giao', 1, N'Chuyển khoản', 32000, 3)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (47, CAST(N'2021-11-11T00:00:00.000' AS DateTime), 127500, N'Đã giao', 2, N'Chuyển khoản', 43000, 2)
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [TrangThai], [MaKH], [HinhThucThanhToan], [PhiVanChuyen], [Shipper]) VALUES (48, CAST(N'2021-12-12T00:00:00.000' AS DateTime), 287000, N'Đã giao', 4, N'Tiền mặt', 77000, 2)
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[DonViVanChuyen] ON 

INSERT [dbo].[DonViVanChuyen] ([MaDVVC], [TenDVVC], [GiayPhepKinhDoanh], [SoTaiKhoanNganHang], [SDT], [DiaChi], [Email], [PhiVanChuyen_KM], [TaiKhoan]) VALUES (1, N'Viettel Post', N'GPKD091283-VN012021', N'0112983012', N'0192837465', N'TPHCM', N'vp@gmail.com', 200, 9)
INSERT [dbo].[DonViVanChuyen] ([MaDVVC], [TenDVVC], [GiayPhepKinhDoanh], [SoTaiKhoanNganHang], [SDT], [DiaChi], [Email], [PhiVanChuyen_KM], [TaiKhoan]) VALUES (2, N'Giao hàng nhanh', N'GPKD04642-VN032021', N'0111234012', N'0199003465', N'TPHCM', N'ghn@gmail.com', 130, 10)
SET IDENTITY_INSERT [dbo].[DonViVanChuyen] OFF
GO
SET IDENTITY_INSERT [dbo].[HoSo_DVVC] ON 

INSERT [dbo].[HoSo_DVVC] ([MaHS_DVVC], [MaDVVC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (1, 1, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_DVVC] ([MaHS_DVVC], [MaDVVC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (2, 2, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-01-02T00:00:00.000' AS DateTime), CAST(N'2019-01-04T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_DVVC] ([MaHS_DVVC], [MaDVVC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (3, 1, N'D:\ImageDatabase\hoso.jpg', CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[HoSo_DVVC] OFF
GO
SET IDENTITY_INSERT [dbo].[HoSo_NCC] ON 

INSERT [dbo].[HoSo_NCC] ([MaHS_NCC], [MaNCC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (1, 1, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-02T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_NCC] ([MaHS_NCC], [MaNCC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (2, 1, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-02T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_NCC] ([MaHS_NCC], [MaNCC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (3, 2, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-02-02T00:00:00.000' AS DateTime), CAST(N'2019-02-02T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_NCC] ([MaHS_NCC], [MaNCC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (4, 3, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-03-03T00:00:00.000' AS DateTime), CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_NCC] ([MaHS_NCC], [MaNCC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (5, 2, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-02-04T00:00:00.000' AS DateTime), CAST(N'2019-02-05T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_NCC] ([MaHS_NCC], [MaNCC], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (6, 3, N'D:\ImageDatabase\hoso.jpg', CAST(N'2019-03-04T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[HoSo_NCC] OFF
GO
SET IDENTITY_INSERT [dbo].[HoSo_Shipper] ON 

INSERT [dbo].[HoSo_Shipper] ([MaHS_Shipper], [MaShipper], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (1, 2, N'D:\ImageDatabase\hosoShipper.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_Shipper] ([MaHS_Shipper], [MaShipper], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (2, 3, N'D:\ImageDatabase\hosoShipper.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_Shipper] ([MaHS_Shipper], [MaShipper], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (3, 4, N'D:\ImageDatabase\hosoShipper.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_Shipper] ([MaHS_Shipper], [MaShipper], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (4, 5, N'D:\ImageDatabase\hosoShipper.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'Hợp lệ')
INSERT [dbo].[HoSo_Shipper] ([MaHS_Shipper], [MaShipper], [AnhHS], [NgayNhan], [NgayKiemTra], [TrangThai]) VALUES (5, 6, N'D:\ImageDatabase\hosoShipper.jpg', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'Hợp lệ')
SET IDENTITY_INSERT [dbo].[HoSo_Shipper] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [Email], [CMND], [MaLoaiKH], [TaiKhoan], [SoNha], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich], [GioiTinh]) VALUES (1, N'Nguyễn Văn An', CAST(N'2000-12-02T00:00:00.000' AS DateTime), N'0987654321', N'an@gmail.com', N'1234567890', 1, 1, N'209', N'Linh Trung', N'Thủ Đức', N'TPHCM', N'Vùng đỏ', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [Email], [CMND], [MaLoaiKH], [TaiKhoan], [SoNha], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich], [GioiTinh]) VALUES (2, N'Nguyễn Thị Tuyết', CAST(N'2000-01-21T00:00:00.000' AS DateTime), N'0987654322', N'tuyet@gmail.com', N'1234567891', 1, 2, N'107 Võ Văn Ngân', N'Linh Trung', N'Thủ Đức', N'TPHCM', N'Vùng đỏ', N'Nữ')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [Email], [CMND], [MaLoaiKH], [TaiKhoan], [SoNha], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich], [GioiTinh]) VALUES (3, N'Trần Tuấn', CAST(N'2000-01-10T00:00:00.000' AS DateTime), N'0987654321', N'tuan@gmail.com', N'1234567892', 1, 3, N'222  Nguyễn Văn Cừ', N'4', N'5', N'TPHCM', N'Vùng đỏ', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [Email], [CMND], [MaLoaiKH], [TaiKhoan], [SoNha], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich], [GioiTinh]) VALUES (4, N'Lê Đức', CAST(N'2000-12-29T00:00:00.000' AS DateTime), N'0987654321', N'duc@gmail.com', N'1234567893', 2, 4, N'107', N'Tân Lập', N'Dĩ An', N'Bình Dương', N'Vùng vàng', N'Nam')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [NgaySinh], [SDT], [Email], [CMND], [MaLoaiKH], [TaiKhoan], [SoNha], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich], [GioiTinh]) VALUES (5, N'Lê Anh Thư', CAST(N'2000-07-30T00:00:00.000' AS DateTime), N'0987654321', N'thu@gmail.com', N'1234567894', 2, 5, N'97', N'Hiệp Hòa', N'Biên Hòa', N'Đồng Nai', N'Vùng xanh', N'Nữ')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiKhachHang] ON 

INSERT [dbo].[LoaiKhachHang] ([MaLoaiKH], [TenLoaiKH]) VALUES (1, N'Thông thường')
INSERT [dbo].[LoaiKhachHang] ([MaLoaiKH], [TenLoaiKH]) VALUES (2, N'VIP')
SET IDENTITY_INSERT [dbo].[LoaiKhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiSanPham] ON 

INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (1, N'Lương thực')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (2, N'Y tế')
SET IDENTITY_INSERT [dbo].[LoaiSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[NhaCungCap] ON 

INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [GiayPhepKinhDoanh], [SDT], [Email], [SoTaiKhoanNganHang], [TaiKhoan], [VanChuyen], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich]) VALUES (1, N'Bách hóa xanh TĐ', N'GP10112020', N'0129837461', N'bhx@yahoo.com', N'0987651423', 6, NULL, N'Linh Trung', N'Thủ Đức', N'TPHCM', N'Vùng đỏ')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [GiayPhepKinhDoanh], [SDT], [Email], [SoTaiKhoanNganHang], [TaiKhoan], [VanChuyen], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich]) VALUES (2, N'Siêu thị BigC', N'GP10112020', N'0129837222', N'bigc@yahoo.com', N'0987651666', 7, NULL, N'Tân Lập', N'Dĩ An', N'Bình Dương', N'Vùng vàng')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [GiayPhepKinhDoanh], [SDT], [Email], [SoTaiKhoanNganHang], [TaiKhoan], [VanChuyen], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich]) VALUES (3, N'Bách hóa xanh ĐN', N'GP10112020', N'0129837333', N'bhxtd@yahoo.com', N'0987651888', 8, NULL, N'Hiệp Hòa', N'Biên Hòa', N'Đồng Nai', N'Vùng xanh')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [GiayPhepKinhDoanh], [SDT], [Email], [SoTaiKhoanNganHang], [TaiKhoan], [VanChuyen], [XaPhuong], [QuanHuyen], [TinhTP], [LoaiVungDich]) VALUES (15, N'Thiết bị Y tế Phương Hoa', N'GP10112020', N'0192831842', N'ph@gmail.com', N'1283932838', 18, 0, N'Nguyễn Văn Cừ', N'Q5', N'TPHCM', N'Vùng đỏ')
SET IDENTITY_INSERT [dbo].[NhaCungCap] OFF
GO
SET IDENTITY_INSERT [dbo].[PhanHoi_KH] ON 

INSERT [dbo].[PhanHoi_KH] ([MaPhanHoi_KH], [ThoiGian], [MaKH], [NoiDung], [TrangThai]) VALUES (1, CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, N'Ứng dụng hữu ích, giúp tôi mua sắm mùa dịch', N'Đã ghi nhận')
INSERT [dbo].[PhanHoi_KH] ([MaPhanHoi_KH], [ThoiGian], [MaKH], [NoiDung], [TrangThai]) VALUES (2, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 2, N'Sản phẩm tôi mua không đạt chất lượng', N'Đã ghi nhận')
INSERT [dbo].[PhanHoi_KH] ([MaPhanHoi_KH], [ThoiGian], [MaKH], [NoiDung], [TrangThai]) VALUES (3, CAST(N'2021-03-01T00:00:00.000' AS DateTime), 3, N'Giao hàng chậm', NULL)
INSERT [dbo].[PhanHoi_KH] ([MaPhanHoi_KH], [ThoiGian], [MaKH], [NoiDung], [TrangThai]) VALUES (4, CAST(N'2021-04-21T00:00:00.000' AS DateTime), 4, N'Hài lòng', N'Đã ghi nhận')
INSERT [dbo].[PhanHoi_KH] ([MaPhanHoi_KH], [ThoiGian], [MaKH], [NoiDung], [TrangThai]) VALUES (5, CAST(N'2021-05-24T00:00:00.000' AS DateTime), 5, N'Hài lòng', NULL)
INSERT [dbo].[PhanHoi_KH] ([MaPhanHoi_KH], [ThoiGian], [MaKH], [NoiDung], [TrangThai]) VALUES (6, CAST(N'2021-04-26T00:00:00.000' AS DateTime), 2, N'Hai lòng', N'Đã ghi nhận')
SET IDENTITY_INSERT [dbo].[PhanHoi_KH] OFF
GO
SET IDENTITY_INSERT [dbo].[PhanHoi_NCC] ON 

INSERT [dbo].[PhanHoi_NCC] ([MaPhanHoi_NCC], [ThoiGian], [MaNCC], [NoiDung], [TrangThai]) VALUES (1, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 1, N'Cảm ơn kênh phân phối này', N'Đã ghi nhận')
INSERT [dbo].[PhanHoi_NCC] ([MaPhanHoi_NCC], [ThoiGian], [MaNCC], [NoiDung], [TrangThai]) VALUES (2, CAST(N'2020-12-29T00:00:00.000' AS DateTime), 2, N'Đề nghị xét duyệt thống kê báo cáo của NCC', NULL)
INSERT [dbo].[PhanHoi_NCC] ([MaPhanHoi_NCC], [ThoiGian], [MaNCC], [NoiDung], [TrangThai]) VALUES (3, CAST(N'2021-02-02T00:00:00.000' AS DateTime), 1, N'Xin trả hoa hồng trễ 2 ngày', N'Đã ghi nhận')
INSERT [dbo].[PhanHoi_NCC] ([MaPhanHoi_NCC], [ThoiGian], [MaNCC], [NoiDung], [TrangThai]) VALUES (4, CAST(N'2021-03-21T00:00:00.000' AS DateTime), 2, N'Chưa nhận được thông báo giảm giá', N'Đã ghi nhận')
SET IDENTITY_INSERT [dbo].[PhanHoi_NCC] OFF
GO
SET IDENTITY_INSERT [dbo].[PhanHoi_Shipper] ON 

INSERT [dbo].[PhanHoi_Shipper] ([MaPhanHoi_Shipper], [ThoiGian], [MaShipper], [NoiDung], [TrangThai]) VALUES (1, CAST(N'2020-12-29T00:00:00.000' AS DateTime), 2, N'Khách hàng bận nhiều lần', N'Đã ghi nhận')
INSERT [dbo].[PhanHoi_Shipper] ([MaPhanHoi_Shipper], [ThoiGian], [MaShipper], [NoiDung], [TrangThai]) VALUES (2, CAST(N'2021-01-23T00:00:00.000' AS DateTime), 4, N'Gặp sự cố, giao hàng chậm 1 ngày', N'Đã ghi nhận')
INSERT [dbo].[PhanHoi_Shipper] ([MaPhanHoi_Shipper], [ThoiGian], [MaShipper], [NoiDung], [TrangThai]) VALUES (3, CAST(N'2021-02-02T00:00:00.000' AS DateTime), 5, N'Khách hàng rất tử tế, gọi 1 cái nghe liền :))', N'Đã ghi nhận')
SET IDENTITY_INSERT [dbo].[PhanHoi_Shipper] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuDangKy_CungUng] ON 

INSERT [dbo].[PhieuDangKy_CungUng] ([MaPhieuDKCU], [MaNCC], [NgayDK], [TrangThai]) VALUES (1, 1, CAST(N'2021-02-02T00:00:00.000' AS DateTime), N'Thành công')
INSERT [dbo].[PhieuDangKy_CungUng] ([MaPhieuDKCU], [MaNCC], [NgayDK], [TrangThai]) VALUES (2, 2, CAST(N'2021-02-19T00:00:00.000' AS DateTime), N'Thành công')
INSERT [dbo].[PhieuDangKy_CungUng] ([MaPhieuDKCU], [MaNCC], [NgayDK], [TrangThai]) VALUES (3, 3, CAST(N'2021-02-23T00:00:00.000' AS DateTime), N'Thành công')
SET IDENTITY_INSERT [dbo].[PhieuDangKy_CungUng] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuDangKy_VanChuyen] ON 

INSERT [dbo].[PhieuDangKy_VanChuyen] ([MaPhieuDKVC], [MaDVVC], [NgayDK], [TrangThai]) VALUES (1, 1, CAST(N'2021-01-05T00:00:00.000' AS DateTime), N'Thành công')
INSERT [dbo].[PhieuDangKy_VanChuyen] ([MaPhieuDKVC], [MaDVVC], [NgayDK], [TrangThai]) VALUES (2, 2, CAST(N'2021-01-12T00:00:00.000' AS DateTime), N'Thành công')
SET IDENTITY_INSERT [dbo].[PhieuDangKy_VanChuyen] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuDangKyDiCho] ON 

INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (1, 1, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 2, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (2, 2, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 3, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (3, 3, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 5, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (4, 4, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 1, N'Thành công')
INSERT [dbo].[PhieuDangKyDiCho] ([MaPhieuDKDC], [MaKH], [NgayDK], [SoThanhVienGD], [TrangThai]) VALUES (5, 5, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 2, N'Thành công')
SET IDENTITY_INSERT [dbo].[PhieuDangKyDiCho] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuYeuCauMuaHang] ON 

INSERT [dbo].[PhieuYeuCauMuaHang] ([MaPYC], [MaKH], [NgayLapPhieu], [TrangThai]) VALUES (1, 1, CAST(N'2021-05-05T00:00:00.000' AS DateTime), N'Đã xử lý')
INSERT [dbo].[PhieuYeuCauMuaHang] ([MaPYC], [MaKH], [NgayLapPhieu], [TrangThai]) VALUES (2, 2, CAST(N'2021-06-05T00:00:00.000' AS DateTime), N'Đang xử lý')
INSERT [dbo].[PhieuYeuCauMuaHang] ([MaPYC], [MaKH], [NgayLapPhieu], [TrangThai]) VALUES (3, 4, CAST(N'2021-07-05T00:00:00.000' AS DateTime), N'Đã xử lý')
SET IDENTITY_INSERT [dbo].[PhieuYeuCauMuaHang] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (1, N'Gạo thơm', N'Bao 10kg', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (2, N'Thịt heo', N'Kg', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (3, N'Cá thu', N'Kg', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (4, N'Nước mắm Nam ngư', N'Chai', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DonViTinh], [LoaiSP]) VALUES (5, N'Khẩu trang y tế', N'Hộp', 2)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (1, 1, 1, CAST(N'2021-11-24T22:37:04.673' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (1, 2, 2, CAST(N'2021-11-24T22:37:04.673' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (1, 4, 1, CAST(N'2021-11-24T22:37:04.677' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (2, 4, 2, CAST(N'2021-11-24T22:37:04.677' AS DateTime), N'Đang chọn')
INSERT [dbo].[SanPham_Chon] ([MaKH], [MaSP], [MaNCC], [ThoiGianChon], [TrangThai]) VALUES (3, 4, 1, CAST(N'2021-11-24T22:37:04.677' AS DateTime), N'Đang chọn')
GO
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (1, 1, N'Gạo Việt Thương', 27000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (1, 3, N'Gạo Việt Thương', 28000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (2, 1, N'H2T-Food', 80000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (2, 2, N'H2T-Food', 82000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (3, 1, N'SeaFood', 55000, CAST(N'2021-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (4, 1, N'Chinsu', 24000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (4, 2, N'Chinsu', 23500, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (4, 3, N'Chinsu', 25000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
INSERT [dbo].[SanPham_NCC] ([MaSP], [MaNCC], [NSX], [Gia], [HSD]) VALUES (5, 15, N'Phương Hoa', 15000, CAST(N'2022-12-31T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Shipper] ON 

INSERT [dbo].[Shipper] ([MaShipper], [TenShipper], [SDT], [Email], [CMND], [NgaySinh], [MaDVVC], [TaiKhoan], [XaPhuong], [QuanHuyen], [TinhTP], [GioiTinh]) VALUES (2, N'Nguyễn Thanh', N'0987612345', N'thang@gmai.com', N'12987354343', CAST(N'2000-01-01T00:00:00.000' AS DateTime), 1, 13, N'Linh Xuân', N'Thủ Đức', N'TPHCM', N'Nam')
INSERT [dbo].[Shipper] ([MaShipper], [TenShipper], [SDT], [Email], [CMND], [NgaySinh], [MaDVVC], [TaiKhoan], [XaPhuong], [QuanHuyen], [TinhTP], [GioiTinh]) VALUES (3, N'Lê Thị Hoa', N'0918276346', N'hoa@gmail.com', N'32455654565', CAST(N'1998-12-12T00:00:00.000' AS DateTime), 2, 14, N'Tân Hiệp', N'Hóc Môn', N'TPHCM', N'Nữ')
INSERT [dbo].[Shipper] ([MaShipper], [TenShipper], [SDT], [Email], [CMND], [NgaySinh], [MaDVVC], [TaiKhoan], [XaPhuong], [QuanHuyen], [TinhTP], [GioiTinh]) VALUES (4, N'Trần Tuấn Anh', N'0987123456', N'anh@gmail.com', N'09172633843', CAST(N'1999-09-12T00:00:00.000' AS DateTime), 1, 15, N'4', N'5', N'TPHCM', N'Nam')
INSERT [dbo].[Shipper] ([MaShipper], [TenShipper], [SDT], [Email], [CMND], [NgaySinh], [MaDVVC], [TaiKhoan], [XaPhuong], [QuanHuyen], [TinhTP], [GioiTinh]) VALUES (5, N'Nguyễn Thị Tuyết', N'0912837465', N'tuyet@gmail.com', N'98712232456', CAST(N'2000-05-01T00:00:00.000' AS DateTime), 2, 16, NULL, N'Biên Hòa', N'Đồng Nai', N'Nữ')
INSERT [dbo].[Shipper] ([MaShipper], [TenShipper], [SDT], [Email], [CMND], [NgaySinh], [MaDVVC], [TaiKhoan], [XaPhuong], [QuanHuyen], [TinhTP], [GioiTinh]) VALUES (6, N'Lê Anh Khoa', N'0223456677', N'khoa@gmail.com', N'91218745457', CAST(N'1999-12-21T00:00:00.000' AS DateTime), 1, 17, NULL, N'Dĩ An', N'Bình Dương', N'Nam')
SET IDENTITY_INSERT [dbo].[Shipper] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (1, N'1', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (2, N'2', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (3, N'3', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (4, N'4', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (5, N'5', N'12345', N'Đang hoạt động', N'KH')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (6, N'1', N'12345', N'Đang hoạt động', N'NCC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (7, N'2', N'12345', N'Đang hoạt động', N'NCC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (8, N'3', N'12345', N'Đang hoạt động', N'NCC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (9, N'1', N'12345', N'Đang hoạt động', N'DVVC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (10, N'2', N'12345', N'Đang hoạt động', N'DVVC')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (11, N'1', N'12345', N'Đang hoạt động', N'QL')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (12, N'1', N'12345', N'Đang hoạt động', N'ADMIN')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (13, N'2', N'12345', N'Đang hoạt động', N'Shipper')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (14, N'3', N'12345', N'Đang hoạt động', N'Shipper')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (15, N'4', N'12345', N'Đang hoạt động', N'Shipper')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (16, N'5', N'12345', N'Đang hoạt động', N'Shipper')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (17, N'6', N'12345', N'Đang hoạt động', N'Shipper')
INSERT [dbo].[TaiKhoan] ([ID], [Username], [Password], [TrangThai], [VaiTro]) VALUES (18, N'4', N'12345', N'Đang hoạt động', N'NCC')
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
ALTER TABLE [dbo].[BlackList] ADD  DEFAULT ((1)) FOR [MucDo]
GO
ALTER TABLE [dbo].[ChiTiet_PYC] ADD  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[ChiTietDonHang] ADD  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (N'Tiền mặt') FOR [HinhThucThanhToan]
GO
ALTER TABLE [dbo].[DonViVanChuyen] ADD  DEFAULT ((0)) FOR [PhiVanChuyen_KM]
GO
ALTER TABLE [dbo].[NhaCungCap] ADD  DEFAULT ((0)) FOR [VanChuyen]
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng] ADD  DEFAULT (getdate()) FOR [NgayDK]
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen] ADD  DEFAULT (getdate()) FOR [NgayDK]
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho] ADD  DEFAULT (getdate()) FOR [NgayDK]
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho] ADD  DEFAULT ((1)) FOR [SoThanhVienGD]
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang] ADD  DEFAULT (getdate()) FOR [NgayLapPhieu]
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang] ADD  DEFAULT (N'Đang xử lý') FOR [TrangThai]
GO
ALTER TABLE [dbo].[SanPham_Chon] ADD  DEFAULT (getdate()) FOR [ThoiGianChon]
GO
ALTER TABLE [dbo].[SanPham_Chon] ADD  DEFAULT (N'Đang chọn') FOR [TrangThai]
GO
ALTER TABLE [dbo].[SanPham_NCC] ADD  DEFAULT ((0)) FOR [Gia]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ('12345') FOR [Password]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT (N'Đang hoạt động') FOR [TrangThai]
GO
ALTER TABLE [dbo].[BlackList]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[ChiTiet_PYC]  WITH CHECK ADD FOREIGN KEY([MaPYC])
REFERENCES [dbo].[PhieuYeuCauMuaHang] ([MaPYC])
GO
ALTER TABLE [dbo].[ChiTiet_PYC]  WITH CHECK ADD FOREIGN KEY([MaSP], [MaNCC])
REFERENCES [dbo].[SanPham_NCC] ([MaSP], [MaNCC])
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD FOREIGN KEY([MaDH])
REFERENCES [dbo].[DonHang] ([MaDH])
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD FOREIGN KEY([MaSP], [MaNCC])
REFERENCES [dbo].[SanPham_NCC] ([MaSP], [MaNCC])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID])
GO
ALTER TABLE [dbo].[HoSo_DVVC]  WITH CHECK ADD  CONSTRAINT [FK_HoSoDVVC] FOREIGN KEY([MaDVVC])
REFERENCES [dbo].[DonViVanChuyen] ([MaDVVC])
GO
ALTER TABLE [dbo].[HoSo_DVVC] CHECK CONSTRAINT [FK_HoSoDVVC]
GO
ALTER TABLE [dbo].[HoSo_NCC]  WITH CHECK ADD  CONSTRAINT [FK_HoSoNCC] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[HoSo_NCC] CHECK CONSTRAINT [FK_HoSoNCC]
GO
ALTER TABLE [dbo].[HoSo_Shipper]  WITH CHECK ADD  CONSTRAINT [FK_HoSoShipper] FOREIGN KEY([MaShipper])
REFERENCES [dbo].[Shipper] ([MaShipper])
GO
ALTER TABLE [dbo].[HoSo_Shipper] CHECK CONSTRAINT [FK_HoSoShipper]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD FOREIGN KEY([MaLoaiKH])
REFERENCES [dbo].[LoaiKhachHang] ([MaLoaiKH])
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID])
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID])
GO
ALTER TABLE [dbo].[PhanHoi_KH]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[PhanHoi_KH] CHECK CONSTRAINT [FK_KhachHang]
GO
ALTER TABLE [dbo].[PhanHoi_NCC]  WITH CHECK ADD  CONSTRAINT [FK_NhaCungCap] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[PhanHoi_NCC] CHECK CONSTRAINT [FK_NhaCungCap]
GO
ALTER TABLE [dbo].[PhanHoi_Shipper]  WITH CHECK ADD  CONSTRAINT [FK_Shipper] FOREIGN KEY([MaShipper])
REFERENCES [dbo].[Shipper] ([MaShipper])
GO
ALTER TABLE [dbo].[PhanHoi_Shipper] CHECK CONSTRAINT [FK_Shipper]
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen]  WITH CHECK ADD FOREIGN KEY([MaDVVC])
REFERENCES [dbo].[DonViVanChuyen] ([MaDVVC])
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([LoaiSP])
REFERENCES [dbo].[LoaiSanPham] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[SanPham_NCC]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[SanPham_NCC]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[Shipper]  WITH CHECK ADD FOREIGN KEY([MaDVVC])
REFERENCES [dbo].[DonViVanChuyen] ([MaDVVC])
GO
ALTER TABLE [dbo].[Shipper]  WITH CHECK ADD FOREIGN KEY([TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID])
GO
ALTER TABLE [dbo].[BlackList]  WITH CHECK ADD CHECK  (([MucDo]>(0)))
GO
ALTER TABLE [dbo].[ChiTiet_PYC]  WITH CHECK ADD CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  (([HinhThucThanhToan] like N'Tiền mặt' OR [HinhThucThanhToan] like N'Chuyển khoản'))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  (([TongTien]>=(0)))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  (([TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đang giao' OR [TrangThai] like N'Đã hủy' OR [TrangThai] like N'Đã giao' OR [TrangThai] like N'Đổi trả'))
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD CHECK  (([PhiVanChuyen_KM]>(0)))
GO
ALTER TABLE [dbo].[DonViVanChuyen]  WITH CHECK ADD CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  (((getdate()-[NgaySinh])>=(5)))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[PhieuDangKy_CungUng]  WITH CHECK ADD CHECK  (([TrangThai] like N'Thành công' OR [TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đã hủy'))
GO
ALTER TABLE [dbo].[PhieuDangKy_VanChuyen]  WITH CHECK ADD CHECK  (([TrangThai] like N'Thành công' OR [TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đã hủy'))
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho]  WITH CHECK ADD CHECK  (([SoThanhVienGD]>(0)))
GO
ALTER TABLE [dbo].[PhieuDangKyDiCho]  WITH CHECK ADD CHECK  (([TrangThai] like N'Thành công' OR [TrangThai] like N'Chờ duyệt' OR [TrangThai] like N'Đã hủy'))
GO
ALTER TABLE [dbo].[PhieuYeuCauMuaHang]  WITH CHECK ADD CHECK  (([TrangThai] like N'Đang xử lý' OR [TrangThai] like N'Đã xử lý'))
GO
ALTER TABLE [dbo].[SanPham_Chon]  WITH CHECK ADD CHECK  (([TrangThai] like N'Đang chọn' OR [TrangThai] like N'Đã bỏ chọn'))
GO
ALTER TABLE [dbo].[SanPham_NCC]  WITH CHECK ADD CHECK  (([Gia]>=(0)))
GO
ALTER TABLE [dbo].[Shipper]  WITH CHECK ADD CHECK  (([Email] like '%@%'))
GO
ALTER TABLE [dbo].[Shipper]  WITH CHECK ADD CHECK  (((getdate()-[NgaySinh])>=(5)))
GO
ALTER TABLE [dbo].[Shipper]  WITH CHECK ADD CHECK  ((len([SDT])=(10)))
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD CHECK  (([TrangThai] like N'Đang hoạt động' OR [TrangThai] like N'Đã dừng'))
GO
/****** Object:  StoredProcedure [dbo].[P_Demo]    Script Date: 23/12/2021 9:26:37 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[P_Demo]
AS
BEGIN
	SELECT * FROM SanPham
END
GO
