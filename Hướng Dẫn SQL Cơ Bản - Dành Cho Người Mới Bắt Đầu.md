<img src="https://tse4.mm.bing.net/th/id/OIP.VUynULpLN1wScDHwQ9MSWAHaC1?w=1542&h=591&rs=1&pid=ImgDetMain&o=7&rm=3" style="height:64px;margin-right:32px" style="height:64px;margin-right:32px"/>

# Hướng Dẫn SQL Cơ Bản - Dành Cho Người Mới Bắt Đầu

*Chào bạn! Nếu bạn đã học ERD (Entity Relationship Diagram) thì tuyệt vời! Bây giờ chúng ta sẽ học cách biến những sơ đồ ERD đó thành thực tế bằng SQL - ngôn ngữ "nói chuyện" với cơ sở dữ liệu.*

## Khởi đầu: SQL là gì?

**SQL (Structured Query Language)** là ngôn ngữ để:

- **Tạo** bảng dữ liệu (như tạo file Excel)
- **Thêm, sửa, xóa** dữ liệu (như chỉnh sửa trong Excel)
- **Tìm kiếm** thông tin (như lọc dữ liệu trong Excel)

Hãy tưởng tượng bạn có một **công ty nhỏ** với:

- **Nhân viên** (Employee)
- **Phòng ban** (Department)
- **Dự án** (Project)


## Phần 1: Tạo "Ngôi Nhà" Cho Dữ Liệu (DDL - Data Definition Language)

### 1.1 Tạo Cơ Sở Dữ Liệu

Giống như tạo một thư mục lớn chứa tất cả dữ liệu:

```sql
CREATE DATABASE CongTyABC;
```

**Giải thích:** Tạo một "ngôi nhà" tên là CongTyABC để chứa tất cả bảng dữ liệu.[^1]

### 1.2 Tạo Bảng Đơn Giản

Bắt đầu với bảng **Phòng Ban**:

```sql
CREATE TABLE PhongBan (
    MaPhong INT PRIMARY KEY,        -- Mã số phòng (duy nhất)
    TenPhong NVARCHAR(100),         -- Tên phòng (tiếng Việt)
    DiaDiem NVARCHAR(50)            -- Địa điểm
);
```

**Giải thích từng dòng:**

- `CREATE TABLE`: Lệnh tạo bảng mới
- `MaPhong INT`: Cột số nguyên để lưu mã phòng
- `PRIMARY KEY`: Khóa chính - giống như CMND, mỗi phòng có 1 mã duy nhất
- `NVARCHAR(100)`: Chuỗi ký tự tối đa 100 ký tự, hỗ trợ tiếng Việt[^1]


### 1.3 Tạo Bảng Có Liên Kết

Bảng **Nhân Viên** liên kết với **Phòng Ban**:

```sql
CREATE TABLE NhanVien (
    MaNV VARCHAR(10) PRIMARY KEY,        -- Mã nhân viên
    HoTen NVARCHAR(50) NOT NULL,         -- Họ tên (bắt buộc)
    NgaySinh DATE,                       -- Ngày sinh
    Luong DECIMAL(10,2),                 -- Lương (10 chữ số, 2 số thập phân)
    MaPhong INT,                         -- Phòng ban làm việc
    
    -- Liên kết với bảng PhongBan
    FOREIGN KEY (MaPhong) REFERENCES PhongBan(MaPhong)
);
```

**Khái niệm mới:**

- `NOT NULL`: Bắt buộc phải có giá trị (như họ tên không được để trống)
- `FOREIGN KEY`: Khóa ngoại - tạo mối liên hệ giữa 2 bảng
- `DECIMAL(10,2)`: Số thập phân có tối đa 10 chữ số, 2 chữ số sau dấu phẩy[^1]


## Phần 2: Thêm Dữ Liệu Vào Bảng (INSERT)

### 2.1 Thêm Phòng Ban

```sql
-- Thêm 3 phòng ban
INSERT INTO PhongBan VALUES (1, N'Phòng Nhân Sự', N'Tầng 2');
INSERT INTO PhongBan VALUES (2, N'Phòng Kế Toán', N'Tầng 3');
INSERT INTO PhongBan VALUES (3, N'Phòng IT', N'Tầng 4');
```

**Lưu ý:** Chữ `N` trước dấu nháy để hỗ trợ tiếng Việt.[^1]

### 2.2 Thêm Nhân Viên

```sql
-- Thêm nhân viên với đầy đủ thông tin
INSERT INTO NhanVien VALUES 
('NV001', N'Nguyễn Văn An', '1990-05-15', 15000000, 1);

-- Thêm nhân viên chỉ một số thông tin
INSERT INTO NhanVien (MaNV, HoTen, MaPhong) 
VALUES ('NV002', N'Trần Thị Bình', 2);
```

**Giải thích:**

- Cách 1: Thêm theo thứ tự các cột trong bảng
- Cách 2: Chỉ định cột nào muốn thêm, các cột khác sẽ là NULL[^1]


## Phần 3: Xem Dữ Liệu (SELECT - Câu Lệnh Quan Trọng Nhất)

### 3.1 Xem Toàn Bộ Dữ Liệu

```sql
-- Xem tất cả nhân viên
SELECT * FROM NhanVien;

-- Xem tất cả phòng ban  
SELECT * FROM PhongBan;
```

**Giải thích:** Dấu `*` có nghĩa là "tất cả các cột".[^1]

### 3.2 Chọn Cột Cụ Thể

```sql
-- Chỉ xem họ tên và lương
SELECT HoTen, Luong FROM NhanVien;

-- Đặt tên khác cho cột (alias)
SELECT HoTen AS 'Họ và Tên', Luong AS 'Mức Lương' 
FROM NhanVien;
```


### 3.3 Lọc Dữ Liệu với WHERE

```sql
-- Tìm nhân viên lương trên 10 triệu
SELECT * FROM NhanVien 
WHERE Luong > 10000000;

-- Tìm nhân viên phòng IT (phòng số 3)
SELECT HoTen, Luong FROM NhanVien 
WHERE MaPhong = 3;

-- Tìm nhân viên tên có chữ "An"
SELECT * FROM NhanVien 
WHERE HoTen LIKE N'%An%';
```

**Ký tự đặc biệt trong LIKE:**

- `%`: Thay thế cho nhiều ký tự bất kỳ
- `_`: Thay thế cho đúng 1 ký tự[^1]


### 3.4 Kết Hợp Điều Kiện

```sql
-- Nhân viên phòng 1 HOẶC lương trên 15 triệu
SELECT * FROM NhanVien 
WHERE MaPhong = 1 OR Luong > 15000000;

-- Nhân viên phòng 2 VÀ lương dưới 20 triệu
SELECT * FROM NhanVien 
WHERE MaPhong = 2 AND Luong < 20000000;
```


## Phần 4: Kết Nối Dữ Liệu Từ Nhiều Bảng (JOIN)

### 4.1 JOIN Cơ Bản - Kết Hợp Thông Tin

Bạn muốn xem nhân viên làm ở phòng nào:

```sql
-- Cách 1: JOIN truyền thống
SELECT n.HoTen, p.TenPhong
FROM NhanVien n, PhongBan p
WHERE n.MaPhong = p.MaPhong;

-- Cách 2: JOIN hiện đại (dễ hiểu hơn)
SELECT n.HoTen, p.TenPhong
FROM NhanVien n 
JOIN PhongBan p ON n.MaPhong = p.MaPhong;
```

**Giải thích:**

- `n` và `p` là "tên ngắn" cho bảng (alias)
- `ON` chỉ điều kiện kết nối giữa 2 bảng
- Kết quả: Danh sách nhân viên kèm tên phòng làm việc[^1]


### 4.2 LEFT JOIN - Hiển Thị Tất Cả Bên Trái

```sql
-- Hiển thị TẤT CẢ nhân viên, kể cả những người chưa có phòng ban
SELECT n.HoTen, p.TenPhong
FROM NhanVien n 
LEFT JOIN PhongBan p ON n.MaPhong = p.MaPhong;
```

**Kết quả:** Nhân viên chưa có phòng ban sẽ hiển thị NULL ở cột TenPhong.[^1]

## Phần 5: Cập Nhật và Xóa Dữ Liệu

### 5.1 Cập Nhật Dữ Liệu (UPDATE)

```sql
-- Tăng lương cho tất cả nhân viên phòng IT
UPDATE NhanVien 
SET Luong = Luong * 1.1    -- Tăng 10%
WHERE MaPhong = 3;

-- Chuyển nhân viên 'NV001' sang phòng Kế Toán
UPDATE NhanVien 
SET MaPhong = 2
WHERE MaNV = 'NV001';
```


### 5.2 Xóa Dữ Liệu (DELETE)

```sql
-- Xóa nhân viên có mã 'NV002'
DELETE FROM NhanVien 
WHERE MaNV = 'NV002';

-- Xóa tất cả nhân viên lương dưới 5 triệu
DELETE FROM NhanVien 
WHERE Luong < 5000000;
```


## Phần 6: Tính Toán và Thống Kê (Aggregate Functions)

### 6.1 Các Hàm Tính Toán Cơ Bản

```sql
-- Đếm số nhân viên
SELECT COUNT(*) AS 'Tổng số nhân viên' FROM NhanVien;

-- Lương trung bình
SELECT AVG(Luong) AS 'Lương trung bình' FROM NhanVien;

-- Lương cao nhất và thấp nhất
SELECT MAX(Luong) AS 'Lương cao nhất', 
       MIN(Luong) AS 'Lương thấp nhất' 
FROM NhanVien;

-- Tổng quỹ lương công ty
SELECT SUM(Luong) AS 'Tổng quỹ lương' FROM NhanVien;
```


### 6.2 Nhóm Dữ Liệu (GROUP BY)

```sql
-- Đếm số nhân viên mỗi phòng ban
SELECT p.TenPhong, COUNT(*) AS 'Số nhân viên'
FROM NhanVien n
JOIN PhongBan p ON n.MaPhong = p.MaPhong
GROUP BY p.TenPhong, p.MaPhong;

-- Lương trung bình mỗi phòng
SELECT p.TenPhong, AVG(n.Luong) AS 'Lương TB'
FROM NhanVien n
JOIN PhongBan p ON n.MaPhong = p.MaPhong
GROUP BY p.TenPhong, p.MaPhong;
```

**Quy tắc GROUP BY:** Nếu có GROUP BY, thì trong SELECT chỉ được:

- Cột trong GROUP BY
- Hàm tính toán (COUNT, AVG, SUM...)[^1]


### 6.3 Lọc Nhóm với HAVING

```sql
-- Phòng ban có hơn 2 nhân viên
SELECT p.TenPhong, COUNT(*) AS 'Số NV'
FROM NhanVien n
JOIN PhongBan p ON n.MaPhong = p.MaPhong
GROUP BY p.TenPhong, p.MaPhong
HAVING COUNT(*) > 2;
```

**Khác biệt WHERE vs HAVING:**

- `WHERE`: Lọc **trước khi** nhóm
- `HAVING`: Lọc **sau khi** nhóm và tính toán[^1]


## Phần 7: Truy Vấn Lồng Nhau (Subquery)

### 7.1 Subquery Đơn Giản

```sql
-- Tìm nhân viên có lương cao hơn lương trung bình
SELECT HoTen, Luong
FROM NhanVien
WHERE Luong > (
    SELECT AVG(Luong) FROM NhanVien
);
```

**Giải thích:**

- Câu trong ngoặc chạy trước, tính lương trung bình
- Câu ngoài so sánh lương từng nhân viên với giá trị đó[^1]


### 7.2 Subquery với IN

```sql
-- Tìm nhân viên làm ở phòng có tên chứa "IT"
SELECT HoTen FROM NhanVien
WHERE MaPhong IN (
    SELECT MaPhong FROM PhongBan 
    WHERE TenPhong LIKE N'%IT%'
);
```


## Phần 8: Sắp Xếp Dữ Liệu (ORDER BY)

```sql
-- Sắp xếp nhân viên theo lương từ cao xuống thấp
SELECT HoTen, Luong FROM NhanVien
ORDER BY Luong DESC;

-- Sắp xếp theo phòng ban, trong phòng sắp theo tên
SELECT n.HoTen, p.TenPhong, n.Luong
FROM NhanVien n
JOIN PhongBan p ON n.MaPhong = p.MaPhong
ORDER BY p.TenPhong ASC, n.HoTen ASC;
```

**Lưu ý:**

- `ASC`: Tăng dần (mặc định)
- `DESC`: Giảm dần[^1]


## Phần 9: Xử Lý Giá Trị NULL

### 9.1 Kiểm Tra NULL

```sql
-- Tìm nhân viên chưa có lương (NULL)
SELECT HoTen FROM NhanVien 
WHERE Luong IS NULL;

-- Tìm nhân viên đã có lương
SELECT HoTen FROM NhanVien 
WHERE Luong IS NOT NULL;
```


### 9.2 Thay Thế NULL

```sql
-- Hiển thị "Chưa có" thay vì NULL
SELECT HoTen, 
       ISNULL(CAST(Luong AS NVARCHAR), N'Chưa có') AS 'Mức lương'
FROM NhanVien;
```


## Ví Dụ Tổng Hợp: Báo Cáo Thực Tế

Tạo báo cáo "Tình hình nhân sự từng phòng ban":

```sql
SELECT 
    p.TenPhong AS 'Phòng Ban',
    COUNT(n.MaNV) AS 'Số Nhân Viên',
    AVG(n.Luong) AS 'Lương Trung Bình',
    MAX(n.Luong) AS 'Lương Cao Nhất',
    MIN(n.Luong) AS 'Lương Thấp Nhất'
FROM PhongBan p
LEFT JOIN NhanVien n ON p.MaPhong = n.MaPhong
WHERE n.Luong IS NOT NULL
GROUP BY p.TenPhong, p.MaPhong
ORDER BY COUNT(n.MaNV) DESC;
```

**Giải thích từng bước:**

1. Kết nối bảng PhongBan và NhanVien
2. Loại bỏ nhân viên chưa có lương
3. Nhóm theo phòng ban
4. Tính các chỉ số thống kê
5. Sắp xếp theo số nhân viên từ nhiều đến ít[^1]

## Mẹo Quan Trọng Cho Người Mới

### ✅ Nên Làm:

- **Luôn backup** trước khi DELETE hoặc UPDATE
- **Sử dụng WHERE** trong UPDATE/DELETE để tránh thay đổi nhầm
- **Viết comment** bằng `--` để ghi chú
- **Test truy vấn nhỏ** trước khi làm phức tạp


### ❌ Tránh Làm:

- Chạy DELETE/UPDATE không có WHERE
- Quên dấu nháy đơn cho chuỗi
- Quên `N` trước chuỗi tiếng Việt
- Viết truy vấn quá dài một lần


### 🔧 Debug Khi Có Lỗi:

1. **Kiểm tra cú pháp**: Thiếu dấu phẩy, ngoặc?
2. **Kiểm tra tên**: Bảng, cột có đúng không?
3. **Chạy từng phần**: Test SELECT trước, sau đó mới UPDATE
4. **Đọc thông báo lỗi**: SQL thường báo rõ lỗi gì, dòng nào

Bây giờ bạn đã có nền tảng SQL cơ bản! Hãy thực hành với dữ liệu thật để làm quen với các câu lệnh này. Nhớ rằng SQL giống như học lái xe - cần thực hành nhiều mới thành thạo! 🚀

<div align="center">⁂</div>

[^1]: Chapter-6.pptx

