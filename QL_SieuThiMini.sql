create database QL_shopsalesale
USE [QL_shopsalesale]
GO
select * from[dbo].[View_PhieuSanPham]
ALTER TABLE [dbo].[tblHDBan] DROP CONSTRAINT [FK_MaNhanVien]
GO
ALTER TABLE [dbo].[tblHDBan] DROP CONSTRAINT [FK_MaKhach]
GO
ALTER TABLE [dbo].[tblHang] DROP CONSTRAINT [fk_ml_hang]
GO
ALTER TABLE [dbo].[tblHang] DROP CONSTRAINT [FK_Manc]
GO
ALTER TABLE [dbo].[tblChiTietHDBan] DROP CONSTRAINT [FK_MaHang]
GO
ALTER TABLE [dbo].[tblChiTietHDBan] DROP CONSTRAINT [fk_ct_hd]
GO
/****** Object:  Table [dbo].[tblNhanVien]    Script Date: 11/12/2023 11:00:45 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblNhanVien]') AND type in (N'U'))
DROP TABLE [dbo].[tblNhanVien]
GO
/****** Object:  Table [dbo].[tblKhach]    Script Date: 11/12/2023 11:00:45 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblKhach]') AND type in (N'U'))
DROP TABLE [dbo].[tblKhach]
GO
/****** Object:  Table [dbo].[tblHDBan]    Script Date: 11/12/2023 11:00:45 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblHDBan]') AND type in (N'U'))
DROP TABLE [dbo].[tblHDBan]
GO
/****** Object:  Table [dbo].[tblChiTietHDBan]    Script Date: 11/12/2023 11:00:45 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblChiTietHDBan]') AND type in (N'U'))
DROP TABLE [dbo].[tblChiTietHDBan]
GO
/****** Object:  View [dbo].[View_PhieuSanPham]    Script Date: 11/12/2023 11:00:45 AM ******/
DROP VIEW [dbo].[View_PhieuSanPham]
GO
/****** Object:  Table [dbo].[tblNhaCungcap]    Script Date: 11/12/2023 11:00:45 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblNhaCungcap]') AND type in (N'U'))
DROP TABLE [dbo].[tblNhaCungcap]
GO
/****** Object:  Table [dbo].[tblLoaiSanPham]    Script Date: 11/12/2023 11:00:45 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblLoaiSanPham]') AND type in (N'U'))
DROP TABLE [dbo].[tblLoaiSanPham]
GO
/****** Object:  Table [dbo].[tblHang]    Script Date: 11/12/2023 11:00:45 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblHang]') AND type in (N'U'))
DROP TABLE [dbo].[tblHang]
GO
/****** Object:  Table [dbo].[tblHang]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHang](
	[MaHang] [nvarchar](50) NOT NULL,
	[TenHang] [nvarchar](50) NOT NULL,
	[Manc] [nvarchar](50) NOT NULL,
	[SoLuong] [float] NOT NULL,
	[DonGiaNhap] [float] NOT NULL,
	[DonGiaBan] [float] NOT NULL,
	[GhiChu] [nvarchar](200) NULL,
	[MaLoai] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLoaiSanPham]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLoaiSanPham](
	[MaLoai] [varchar](20) NOT NULL,
	[TenLoai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNhaCungcap]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhaCungcap](
	[Manc] [nvarchar](50) NOT NULL,
	[Tennc] [nvarchar](100) NOT NULL,
	[Diachi] [nvarchar](100) NULL,
	[Dienthoai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Manc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_PhieuSanPham]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_PhieuSanPham]
as
select h.MaHang, h.TenHang,n.Manc, h.SoLuong, h.DonGiaNhap, h.DonGiaBan, l.MaLoai,sum(h.DonGiaNhap*h.SoLuong) "TongTienNhaphang"
from [dbo].[tblHang] h, [dbo].[tblNhaCungcap] n, [dbo].[tblLoaiSanPham] l
where h.Manc = n.Manc and h.MaLoai= l.MaLoai
group by h.MaHang, h.TenHang,n.Manc, h.SoLuong, h.DonGiaNhap, h.DonGiaBan, l.MaLoai
GO
/****** Object:  Table [dbo].[tblChiTietHDBan]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChiTietHDBan](
	[MaHDBan] [nvarchar](30) NOT NULL,
	[MaHang] [nvarchar](50) NOT NULL,
	[SoLuong] [float] NOT NULL,
	[DonGia] [float] NOT NULL,
	[GiamGia] [float] NULL,
	[ThanhTien] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHDBan] ASC,
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblHDBan]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHDBan](
	[MaHDBan] [nvarchar](30) NOT NULL,
	[MaNhanVien] [nvarchar](50) NOT NULL,
	[NgayBan] [datetime] NOT NULL,
	[MaKhach] [nvarchar](10) NULL,
	[TongTien] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHDBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblKhach]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKhach](
	[MaKhach] [nvarchar](10) NOT NULL,
	[TenKhach] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[DienThoai] [nvarchar](50) NOT NULL,
	[Diem] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNhanVien]    Script Date: 11/12/2023 11:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNhanVien](
	[MaNhanVien] [nvarchar](50) NOT NULL,
	[TenNhanVien] [nvarchar](50) NOT NULL,
	[GioiTinh] [nvarchar](10) NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[DienThoai] [nvarchar](15) NOT NULL,
	[NgaySinh] [datetime] NOT NULL,
	[TenDangNhap] [varchar](50) NULL,
	[Quyen] [varchar](20) NULL,
	[MatKhau] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblChiTietHDBan] ([MaHDBan], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HD001', N'HH001', 3, 90000, 10, 243000)
INSERT [dbo].[tblChiTietHDBan] ([MaHDBan], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HD001', N'HH002', 2, 24000, 5, 45600)
INSERT [dbo].[tblChiTietHDBan] ([MaHDBan], [MaHang], [SoLuong], [DonGia], [GiamGia], [ThanhTien]) VALUES (N'HD003', N'HH005', 10, 150000, 10, 1350000)
GO
INSERT [dbo].[tblHang] ([MaHang], [TenHang], [Manc], [SoLuong], [DonGiaNhap], [DonGiaBan], [GhiChu], [MaLoai]) VALUES (N'HH001', N'Nước khoáng đóng chai tinh khiết', N'NCC005', 2, 10000, 12000, N'Sản phẩm chất lượng quá á nha', N'L0003')
INSERT [dbo].[tblHang] ([MaHang], [TenHang], [Manc], [SoLuong], [DonGiaNhap], [DonGiaBan], [GhiChu], [MaLoai]) VALUES (N'HH002', N'Nước rửa chén chanh xả', N'NCC001', 8, 25000, 27000, N'Quá là  tuyệt với, chén bao sáng luôn nha quá đã', N'L0002')
INSERT [dbo].[tblHang] ([MaHang], [TenHang], [Manc], [SoLuong], [DonGiaNhap], [DonGiaBan], [GhiChu], [MaLoai]) VALUES (N'HH003', N'Tăng lực Reb bull', N'NCC004', 10, 10000, 12000, N'Qúa đã nha', N'L0003')
INSERT [dbo].[tblHang] ([MaHang], [TenHang], [Manc], [SoLuong], [DonGiaNhap], [DonGiaBan], [GhiChu], [MaLoai]) VALUES (N'HH004', N'Gạo ST12', N'NCC006', 10, 120000, 140000, N'Sản phẩm chất lượng', N'L0005')
INSERT [dbo].[tblHang] ([MaHang], [TenHang], [Manc], [SoLuong], [DonGiaNhap], [DonGiaBan], [GhiChu], [MaLoai]) VALUES (N'HH005', N'Gạo ST24', N'NCC006', 10, 130000, 150000, N'gạo ngon', N'L0005')
GO
INSERT [dbo].[tblHDBan] ([MaHDBan], [MaNhanVien], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HD001', N'NV002', CAST(N'2023-07-11T00:00:00.000' AS DateTime), N'KH01', 288600)
INSERT [dbo].[tblHDBan] ([MaHDBan], [MaNhanVien], [NgayBan], [MaKhach], [TongTien]) VALUES (N'HD003', N'NV002', CAST(N'2023-11-12T00:00:00.000' AS DateTime), N'KH02', 1350000)
GO
INSERT [dbo].[tblKhach] ([MaKhach], [TenKhach], [DiaChi], [DienThoai], [Diem]) VALUES (N'KH01', N'Trần Trân', N'Hồng Kong', N'(345) 343-4534', 12)
INSERT [dbo].[tblKhach] ([MaKhach], [TenKhach], [DiaChi], [DienThoai], [Diem]) VALUES (N'KH02', N'Trần Thi Nam', N'Tân Thới Nhất', N'(223) 424-5234', 5)
INSERT [dbo].[tblKhach] ([MaKhach], [TenKhach], [DiaChi], [DienThoai], [Diem]) VALUES (N'KH03', N'Bùi Bang Cái', N'Tân Thới Hiệp', N'(234) 234-3243', 5)
GO
INSERT [dbo].[tblLoaiSanPham] ([MaLoai], [TenLoai]) VALUES (N'L0002', N'Nước rửa chén')
INSERT [dbo].[tblLoaiSanPham] ([MaLoai], [TenLoai]) VALUES (N'L0003', N'Nước')
INSERT [dbo].[tblLoaiSanPham] ([MaLoai], [TenLoai]) VALUES (N'L0004', N'Bột giặt đồ')
INSERT [dbo].[tblLoaiSanPham] ([MaLoai], [TenLoai]) VALUES (N'L0005', N'Gạo')
INSERT [dbo].[tblLoaiSanPham] ([MaLoai], [TenLoai]) VALUES (N'L0006', N'Snack')
GO
INSERT [dbo].[tblNhaCungcap] ([Manc], [Tennc], [Diachi], [Dienthoai]) VALUES (N'NCC001', N'ChinSu', N'140/78 Lê Trọng Tấn', N'(023) 892-1883')
INSERT [dbo].[tblNhaCungcap] ([Manc], [Tennc], [Diachi], [Dienthoai]) VALUES (N'NCC002', N'Vinamilk', N'85/1 Nguyễn Hữu Dật', N'(090) 909-0909')
INSERT [dbo].[tblNhaCungcap] ([Manc], [Tennc], [Diachi], [Dienthoai]) VALUES (N'NCC003', N'TH True Milk', N'Tân Thới Nhất 18', N'(086) 657-3341')
INSERT [dbo].[tblNhaCungcap] ([Manc], [Tennc], [Diachi], [Dienthoai]) VALUES (N'NCC004', N'Red Bull', N'129/21 Nguyễn Hữu Dật', N'(938) 301-9841')
INSERT [dbo].[tblNhaCungcap] ([Manc], [Tennc], [Diachi], [Dienthoai]) VALUES (N'NCC005', N'Tan Hiep Phat Group nha', N'Thủ Dầu 1, Bình Dương', N'(234) 234-4343')
INSERT [dbo].[tblNhaCungcap] ([Manc], [Tennc], [Diachi], [Dienthoai]) VALUES (N'NCC006', N'Gạo  Nước Nhà', N'Tân Thới Nhất 18/ Hồ Chí MInh', N'(324) 234-2342')
GO
INSERT [dbo].[tblNhanVien] ([MaNhanVien], [TenNhanVien], [GioiTinh], [DiaChi], [DienThoai], [NgaySinh], [TenDangNhap], [Quyen], [MatKhau]) VALUES (N'NV001', N'Trần Văn Nam', N'Nam', N'140 Lê Trọng Tấn', N'03242342', CAST(N'2003-05-12T00:00:00.000' AS DateTime), N'nam', N'user', N'nam123')
INSERT [dbo].[tblNhanVien] ([MaNhanVien], [TenNhanVien], [GioiTinh], [DiaChi], [DienThoai], [NgaySinh], [TenDangNhap], [Quyen], [MatKhau]) VALUES (N'NV002', N'Minh Thuận', N'Nam', N'Bình Thuận', N'(023) 423-434', CAST(N'2003-03-12T00:00:00.000' AS DateTime), N'thuan', N'admin', N'thuan123')
INSERT [dbo].[tblNhanVien] ([MaNhanVien], [TenNhanVien], [GioiTinh], [DiaChi], [DienThoai], [NgaySinh], [TenDangNhap], [Quyen], [MatKhau]) VALUES (N'NV003', N'Báng Thái Anh Nguyệt', N'Nữ', N'Quận 1', N'(234) 234-2334', CAST(N'2023-11-06T00:00:00.000' AS DateTime), N'nguyet', N'user', N'123')
INSERT [dbo].[tblNhanVien] ([MaNhanVien], [TenNhanVien], [GioiTinh], [DiaChi], [DienThoai], [NgaySinh], [TenDangNhap], [Quyen], [MatKhau]) VALUES (N'NV004', N'Bùi Thị Mùi', N'Nữ', N'Ninh Thuận', N'(234) 234-2342', CAST(N'2023-06-05T00:00:00.000' AS DateTime), N'bui', N'user', N'bui123')
GO
ALTER TABLE [dbo].[tblChiTietHDBan]  WITH CHECK ADD  CONSTRAINT [fk_ct_hd] FOREIGN KEY([MaHDBan])
REFERENCES [dbo].[tblHDBan] ([MaHDBan])
GO
ALTER TABLE [dbo].[tblChiTietHDBan] CHECK CONSTRAINT [fk_ct_hd]
GO
ALTER TABLE [dbo].[tblChiTietHDBan]  WITH CHECK ADD  CONSTRAINT [FK_MaHang] FOREIGN KEY([MaHang])
REFERENCES [dbo].[tblHang] ([MaHang])
GO
ALTER TABLE [dbo].[tblChiTietHDBan] CHECK CONSTRAINT [FK_MaHang]
GO
ALTER TABLE [dbo].[tblHang]  WITH CHECK ADD  CONSTRAINT [FK_Manc] FOREIGN KEY([Manc])
REFERENCES [dbo].[tblNhaCungcap] ([Manc])
GO
ALTER TABLE [dbo].[tblHang] CHECK CONSTRAINT [FK_Manc]
GO
ALTER TABLE [dbo].[tblHang]  WITH CHECK ADD  CONSTRAINT [fk_ml_hang] FOREIGN KEY([MaLoai])
REFERENCES [dbo].[tblLoaiSanPham] ([MaLoai])
GO
ALTER TABLE [dbo].[tblHang] CHECK CONSTRAINT [fk_ml_hang]
GO
ALTER TABLE [dbo].[tblHDBan]  WITH CHECK ADD  CONSTRAINT [FK_MaKhach] FOREIGN KEY([MaKhach])
REFERENCES [dbo].[tblKhach] ([MaKhach])
GO
ALTER TABLE [dbo].[tblHDBan] CHECK CONSTRAINT [FK_MaKhach]
GO
ALTER TABLE [dbo].[tblHDBan]  WITH CHECK ADD  CONSTRAINT [FK_MaNhanVien] FOREIGN KEY([MaNhanVien])
REFERENCES [dbo].[tblNhanVien] ([MaNhanVien])
GO
ALTER TABLE [dbo].[tblHDBan] CHECK CONSTRAINT [FK_MaNhanVien]
GO
