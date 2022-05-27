CREATE DATABASE TruongHoc
GO

USE TruongHoc
GO

CREATE TABLE BoMon
(
	MaBM CHAR(10) PRIMARY KEY,
	TenBM NVARCHAR(100) DEFAULT N'Ten bo mon'
)
GO

CREATE TABLE Lop
(
	MaLop CHAR(10) NOT NULL,
	TenLop NVARCHAR(100) DEFAULT N'Ten lop'
)

ALTER TABLE dbo.Lop ADD PRIMARY KEY (MaLop)
GO

CREATE TABLE GiaoVien
(
	MaGV CHAR(10) NOT NULL,
	TenGV NVARCHAR(100) DEFAULT N'Ten giao vien',
	DiaChi NVARCHAR(100) DEFAULT N'Dia chi giao vien',
	NgaySinhGV DATE,
	GioiTinh BIT,
	MaBM CHAR(10),

	FOREIGN KEY (MaBM) REFERENCES dbo.BoMon(MaBM)
)
GO

ALTER TABLE dbo.GiaoVien ADD PRIMARY KEY (MaGV)

CREATE TABLE HocSinh
(
	MaHS CHAR(10) PRIMARY KEY,
	TenHS NVARCHAR(100),
	MaLop CHAR(10)
)
GO

ALTER TABLE dbo.HocSinh ADD CONSTRAINT FK_HS FOREIGN KEY(MaLop) REFERENCES dbo.Lop(MaLop)
GO

-- Huy khoa ngoai constraint
-- ALTER TABLE dbo.HocSinh DROP CONSTRAINT FK_HS 

INSERT INTO dbo.BoMon
			(MaBM, TenBM)
VALUES		( 'BM01', --MaBM - CHAR(10)
			  N'Bo mon 1' --TenBM - NVARCHAR(100)
			)
INSERT INTO dbo.BoMon
			(MaBM, TenBM)
VALUES		( 'BM02', --MaBM - CHAR(10)
			  N'Bo mon 2' --TenBM - NVARCHAR(100)
			)
INSERT INTO dbo.BoMon
			(MaBM, TenBM)
VALUES		( 'BM03', --MaBM - CHAR(10)
			  N'Bo mon 3' --TenBM - NVARCHAR(100)
			)

INSERT INTO dbo.GiaoVien
			(MaGV, TenGV, DiaChi, NgaySinhGV, GioiTinh, MaBM)
VALUES		( 'GV01', -- MaGV - CHAR(10)
			  N'GV 1', -- TenGV - NVARCHAR(100)
			  N'DC 1', -- DiaChi - NVARCHAR(100)
			  GETDATE(), -- NgaySinhGV - DATE
			  1, -- GioiTinh - BIT
			  'BM03' -- MaBM - CHAR(10)
			)

INSERT INTO dbo.GiaoVien
			(MaGV, TenGV, DiaChi, NgaySinhGV, GioiTinh, MaBM)
VALUES		( 'GV02', -- MaGV - CHAR(10)
			  N'GV 1', -- TenGV - NVARCHAR(100)
			  N'DC 1', -- DiaChi - NVARCHAR(100)
			  GETDATE(), -- NgaySinhGV - DATE
			  1, -- GioiTinh - BIT
			  'BM01' -- MaBM - CHAR(10)
			)