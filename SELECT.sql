USE HowKteam
GO

SELECT * FROM dbo.BOMON -- Lấy hết các dữ liệu trong bảng bộ môn

SELECT MABM, TENBM FROM dbo.BOMON

SELECT MABM as N'Mã bộ môn', TENBM as N'Tên bộ môn' FROM dbo.BOMON

SELECT * FROM dbo.GIAOVIEN
SELECT * FROM dbo.KHOA

-- Xuất ra mã giáo viên + tên + tên bộ môn giáo viên đó dạy
SELECT GV.MAGV, GV.HOTEN, BM.TENBM
FROM dbo.GIAOVIEN AS GV, dbo.BOMON AS BM

-- 1.	Truy xuất thông tin của Table Tham gia đề tài
SELECT * FROM dbo.DETAI

-- 2.	Lấy ra Mã khoa và Tên khoa tương ứng
SELECT TENKHOA, MAKHOA
FROM dbo.KHOA

-- 3.	Lấy ra Mã GV, tên GV và họ tên người thân tương ứng
SELECT GV.MAGV, GV.HOTEN, NTGV.TEN
FROM dbo.GIAOVIEN AS GV, dbo.NGUOITHAN AS NTGV
WHERE GV.MAGV = NTGV.MAGV

-- 4.	Lấy ra Mã GV, tên GV và tên khoa tương ứng mà giáo viên đó làm việc. (Gợi ý: Bộ môn nằm trong khoa)
SELECT GV.HOTEN, GV.MAGV, K.TENKHOA
FROM dbo.GIAOVIEN AS GV, dbo.KHOA AS K

-- Lấy ra GV lương >2000
SELECT * FROM dbo.GIAOVIEN
WHERE LUONG > 2000

-- Lấy ra GV là nữ và lương > 2000
SELECT * FROM dbo.GIAOVIEN
WHERE LUONG > 2000 AND PHAI = N'Nữ'

-- Lấy ra GV lớn hơn 50 tuổi
SELECT * FROM dbo.GIAOVIEN
WHERE YEAR (GETDATE()) - YEAR(NGSINH) > 50

-- Lấy ra Họ tên giáo viên, năm sinh và tuổi của giáo viên nhỏ hơn 50 tuổi
SELECT HOTEN, NGSINH, YEAR(GETDATE()) - YEAR(NGSINH) FROM dbo.GIAOVIEN
WHERE YEAR(GETDATE()) - YEAR(NGSINH) < 50

-- Lấy ra Mã GV, tên GV và tên khoa tương ứng mà giáo viên đó làm việc. (Gợi ý: Bộ môn nằm trong khoa)
SELECT GV.HOTEN, GV.MAGV, K.TENKHOA
FROM dbo.GIAOVIEN AS GV, dbo.KHOA AS K, dbo.BOMON AS BM
WHERE GV.MABM = BM.MABM AND BM.MAKHOA = K.MAKHOA

-- Lấy ra giáo viên là trưởng bộ môn
SELECT GV.*
FROM dbo.GIAOVIEN AS GV, dbo.BOMON AS BM
WHERE GV.MAGV = BM.TRUONGBM

-- Đếm số lượng giáo viên
SELECT COUNT (*) AS N'Số lượng giáo viên' FROM dbo.GIAOVIEN 

-- Đếm số lượng người thân của giáo viên có mã giáo viên là 007
SELECT COUNT (*) AS N'Số lượng người thân của giáo viên có mã giáo viên là 007'
SELECT *
FROM dbo.GIAOVIEN AS GV, dbo.NGUOITHAN AS NT
WHERE GV.MAGV = '007' AND GV.MAGV = NT.MAGV

-- 
