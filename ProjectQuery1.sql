CREATE DATABASE ECommerceDb;
GO

USE ECommerceDb;
GO

CREATE TABLE Users (
    Id INT IDENTITY PRIMARY KEY,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Categories (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    ParentId INT NULL,
    CONSTRAINT FK_Categories_Parent FOREIGN KEY (ParentId) REFERENCES Categories(Id)
);

CREATE TABLE Products (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18,2) NOT NULL,
    Stock INT NOT NULL,
    CategoryId INT NOT NULL,
    CONSTRAINT FK_Products_Category FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

CREATE TABLE Favorites (
    Id INT IDENTITY PRIMARY KEY,
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Favorites_User FOREIGN KEY (UserId) REFERENCES Users(Id),
    CONSTRAINT FK_Favorites_Product FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

CREATE TABLE CartItems (
    Id INT IDENTITY PRIMARY KEY,
    UserId INT NULL,
    SessionId NVARCHAR(100) NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_CartItems_Product FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

CREATE TABLE Orders (
    Id INT IDENTITY PRIMARY KEY,
    UserId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) NOT NULL,
    TotalAmount DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_Orders_User FOREIGN KEY (UserId) REFERENCES Users(Id)
);

CREATE TABLE OrderItems (
    Id INT IDENTITY PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderItems_Order FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    CONSTRAINT FK_OrderItems_Product FOREIGN KEY (ProductId) REFERENCES Products(Id)
);



-- Ana kategoriler
INSERT INTO Categories (Name, ParentId) VALUES ('Erkek', NULL);
INSERT INTO Categories (Name, ParentId) VALUES ('Kadýn', NULL);
INSERT INTO Categories (Name, ParentId) VALUES ('Bebek', NULL);

INSERT INTO Categories (Name, ParentId)
VALUES ('Aksesuar', 178);

INSERT INTO Categories (Name, ParentId)
VALUES
('Parfüm', 181),
('Þapka', 181);

INSERT INTO Categories (Name, ParentId)
VALUES ('Aksesuar', 179);

INSERT INTO Categories (Name, ParentId)
VALUES
('Kýz Bebek', 180),
('Erkek Bebek', 180);

-- 2. Aksesuar'ý Kadýn'ýn alt kategorisi olarak ekle

INSERT INTO Categories (Name, ParentId)
VALUES 
('Küpe', 182),
('Kemer', 182),
('Kolye', 182);

INSERT INTO Categories (Name, ParentId) VALUES ('Giyim', 178);
INSERT INTO Categories (Name, ParentId) VALUES ('Ayakkabý', 178);
INSERT INTO Categories (Name, ParentId) VALUES ('Çanta', 178);

-- Kadýn alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Giyim', 179);
INSERT INTO Categories (Name, ParentId) VALUES ('Ayakkabý', 179);
INSERT INTO Categories (Name, ParentId) VALUES ('Çanta', 179);



-- Erkek Giyim alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Gömlek',188);
INSERT INTO Categories (Name, ParentId) VALUES ('Pantolon', 188);

-- Erkek Ayakkabý alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 189);
INSERT INTO Categories (Name, ParentId) VALUES ('Süvet', 189);

-- Erkek Çanta alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 190);
INSERT INTO Categories (Name, ParentId) VALUES ('Süvet', 190);

-- Kadýn Giyim alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Gömlek', 191);
INSERT INTO Categories (Name, ParentId) VALUES ('Pantolon', 191);

-- Kadýn Ayakkabý alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 192);
INSERT INTO Categories (Name, ParentId) VALUES ('Süvet', 192);

-- Kadýn Çanta alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 193);
INSERT INTO Categories (Name, ParentId) VALUES ('Süvet', 193);

-- Kadýn > Giyim kategorisinin Id'si 6 (önceki tablodan)
INSERT INTO Categories (Name, ParentId)
VALUES 
('Tiþört', 191),
('Þort', 191),
('Kazak', 191),
('Ceket', 191);

-- Erkek > Giyim kategorisinin Id'si 3
INSERT INTO Categories (Name, ParentId)
VALUES 
('Tiþört', 188),
('Þort', 188),
('Kazak', 188),
('Ceket', 188);

-- 1. Kadýn kategorisinin Id'si 2
-- 2. Aksesuar'ý Kadýn'ýn alt kategorisi olarak ekle

INSERT INTO Categories (Name, ParentId)
VALUES 
('Küpe', 182),
('Kemer', 182),
('Kolye', 182);


INSERT INTO Categories (Name, ParentId)
VALUES
('Parfüm', 181),
('Þapka', 181);



INSERT INTO Categories (Name, ParentId)
VALUES
('Toka', 194),
('Tiþört', 194),
('Þort', 194),
('Elbise', 194);

INSERT INTO Categories (Name, ParentId)
VALUES
('Þort', 195),
('Gömlek', 195),
('Tiþört', 195),
('Þapka', 195);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Siyah Þort', 'Þýk ve rahat erkek þort', 178.00, 50, 222),
('Erkek Resmi Ceket ', 'Þýk erkek ceket', 480.00, 25, 224),
('Erkek Gömlek Slim Fit', 'Þýk ve rahat erkek gömlek', 180.00, 50, 205),
('Erkek Pantolon Klasik', 'Konforlu ve dayanýklý klasik pantolon', 210.00, 40, 206),
('Erkek Tiþört Casual', 'Günlük kullaným için tiþört', 90.00, 70, 221),
('Erkek Kazak', 'Sýcak tutan lacivert kazak', 220.00, 30, 223);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Deri Çanta', 'Kaliteli siyah deri çanta', 320.00, 20, 209),
('Erkek Süvet Çanta', 'Rahat süet çanta', 250.00, 15, 210)
('Erkek Deri Ayakkabý', 'Kaliteli siyah deri ayakkabý', 320.00, 20, 207),
('Erkek Süvet Ayakkabý', 'Rahat süet ayakkabý', 250.00, 15, 208);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Kadýn Gömlek Þifon', 'Hafif ve þýk gömlek', 170.00, 40, 211),
('Kadýn Pantolon Dar Kesim', 'Modern tasarým pantolon', 190.00, 30, 212),
('Kadýn Tiþört Yazlýk', 'Rahat ve hafif tiþört', 120.00, 60, 217),
('Kadýn Þort Keten', 'Yazlýk þort', 140.00, 50, 218),
('Kadýn Kazak', 'Kýþ için sýcak kazak', 200.00, 35, 219),
('Kadýn Ceket', 'Þýk ofis ceketi', 250.00, 20, 220);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Kadýn Küpe Altýn Kaplama', 'Zarif altýn kaplama küpe', 80.00, 100, 185),
('Kadýn Kemer Deri', 'Kaliteli deri kemer', 90.00, 80, 186),
('Kadýn Kolye Ýnci', 'Þýk inci kolye', 150.00, 60, 187);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Kýz Bebek Toka', 'Renkli ve yumuþak toka', 25.00, 100, 230),
('Kýz Bebek Tiþört', 'Pamuklu rahat tiþört', 30.00, 100, 231),
('Kýz Bebek Þort', 'Yazlýk þort', 35.00, 80, 232),
('Kýz Bebek Elbise', 'Þirin elbise', 50.00, 60, 233);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Bebek Þort', 'Yumuþak kumaþ þort', 30.00, 90, 234),
('Erkek Bebek Gömlek', 'Küçük gömlek', 40.00, 70, 235),
('Erkek Bebek Tiþört', 'Rahat tiþört', 30.00, 80, 236),
('Erkek Bebek Þapka', 'Koruyucu þapka', 25.00, 75, 237);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Parfüm', 'Ferahlatýcý erkek parfümü', 300.00, 40, 183),
('Erkek Þapka', 'Modern erkek þapkasý', 100.00, 50, 184);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Kadýn Deri Çanta', 'Kaliteli siyah deri çanta', 320.90, 20, 215),
('Kadýn Süvet Çanta', 'Rahat süet çanta', 250.99, 15, 216),
('Kadýn Deri Ayakkabý', 'Kaliteli siyah deri ayakkabý', 120.95, 20, 213),
('kadýn Süvet Ayakkabý', 'Rahat süet ayakkabý', 250.00, 15, 214);

ALTER TABLE Products
ADD ImageUrl NVARCHAR(MAX) NULL;
GO


-- Erkek Ürünleri için
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/05/02/2730921/4848eb42-682a-43f4-8081-bebb38cabb5d_size870x1142.jpg' WHERE CategoryId = 222 AND Name = 'Erkek Siyah Þort';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/24/454219/eba84b68-b940-48d4-a73d-0092347a7a74_size870x1142.jpg' WHERE CategoryId = 224 AND Name = 'Erkek Resmi Ceket ';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/09/13/96295/145e5ed1-0f1a-446d-aacb-6a9c23df62da_size870x1142.jpg' WHERE CategoryId = 205 AND Name = 'Erkek Gömlek Slim Fit';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2021/11/10/84283/dae10fa0-d444-458b-8293-c311653dca03_size870x1142.jpg' WHERE CategoryId = 206 AND Name = 'Erkek Pantolon Klasik';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/02/14/2868533/8004fa45-7c7e-4a7b-a4eb-45de9db0ef28_size870x1142.jpg' WHERE CategoryId = 221 AND Name = 'Erkek Tiþört Casual';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/12/04/2850138/b2e18cf6-834b-4d08-91db-c7898832e3e1_size870x1142.jpg' WHERE CategoryId = 223 AND Name = 'Erkek Kazak';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/25/749245/41ba3efc-01ef-4e02-bd07-21e77cbfdc68_size870x1142.jpg' WHERE CategoryId = 209 AND Name = 'Erkek Deri Çanta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/09/09/2986742/aff76034-8d6e-4a64-a585-a9b52241986d.jpg' WHERE CategoryId = 210 AND Name = 'Erkek Süvet Çanta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/23/444119/813f0295-26d5-4eac-8954-9420b7552df1_size870x1142.jpg' WHERE CategoryId = 207 AND Name = 'Erkek Deri Ayakkabý';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2021/11/09/77476/88a80b9e-aed3-41da-a76a-22772f113a89_size870x1142.jpg' WHERE CategoryId = 208 AND Name = 'Erkek Süvet Ayakkabý';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/04/13/2669748/f8dcac93-2e10-43e0-b1c8-8ddcc5e43f20_size870x1142.jpg' WHERE CategoryId = 183 AND Name = 'Erkek Parfüm';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/03/18/2895579/8188c57c-7965-48e1-a829-faab7b6148cb_size870x1142.jpg' WHERE CategoryId = 184 AND Name = 'Erkek Þapka';


-- Kadýn Ürünleri için
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/04/13/2744773/e5d0c3a1-9637-4e62-b485-6573f869f80e_size870x1142.jpg' WHERE CategoryId = 211 AND Name = 'Kadýn Gömlek Þifon';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/03/21/2710149/d9e7e5c9-ce5b-4081-aed4-aee7244dcc76_size870x1142.jpg' WHERE CategoryId = 212 AND Name = 'Kadýn Pantolon Dar Kesim';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/12/28/2859799/b73dad82-2b57-4824-b057-4ecd9f8343d2_size870x1142.jpg' WHERE CategoryId = 217 AND Name = 'Kadýn Tiþört Yazlýk';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/04/18/2739318/e68377f7-d8fa-47f5-ae27-efd07e7bcf44_size870x1142.jpg' WHERE CategoryId = 218 AND Name = 'Kadýn Þort Keten';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/10/17/2826145/44156795-33c3-4b15-9e92-1075a1f9810d_size870x1142.jpg' WHERE CategoryId = 219 AND Name = 'Kadýn Kazak';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/08/14/2971876/2c16d9cd-1bd0-4d8f-82f1-f788d47c2d64_size870x1142.jpg' WHERE CategoryId = 220 AND Name = 'Kadýn Ceket';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/11/16/2620235/2b82a6b7-725c-4af5-84c3-08cbdec14e7f.jpg' WHERE CategoryId = 185 AND Name = 'Kadýn Küpe Altýn Kaplama';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/08/22/2977649/39b7274b-4e68-4d3c-8ec9-64584894a1e2_size870x1142.jpg' WHERE CategoryId = 186 AND Name = 'Kadýn Kemer Deri';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/06/27/2940932/639b27e5-ec0f-4fb0-908c-3d0ce536834d.jpg' WHERE CategoryId = 187 AND Name = 'Kadýn Kolye Ýnci';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/05/16/1033660/59e73e46-7338-4709-ada6-346687c94dec_size870x1142.jpg' WHERE CategoryId = 215 AND Name = 'Kadýn Deri Çanta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/11/27/2991607/72ddf19d-1ebc-4a9a-a856-6b89af9cee68_size870x1142.jpg' WHERE CategoryId = 216 AND Name = 'Kadýn Süvet Çanta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/23/442382/61bb44f7-9407-49df-9be0-45a6958996a2_size870x1142.jpg' WHERE CategoryId = 213 AND Name = 'Kadýn Deri Ayakkabý';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/30/247717/b1c219da-19e8-4311-b85d-f69b4ce5f035.jpg' WHERE CategoryId = 214 AND Name = 'kadýn Süvet Ayakkabý';


-- Bebek Ürünleri için
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/05/09/2917503/7740ab54-3607-4e98-a540-c7af5016f602_size870x1142.jpg' WHERE CategoryId = 230 AND Name = 'Kýz Bebek Toka';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/09/04/2804574/bd3f9e48-6a66-490e-b4f9-dd06728d3dbf_size870x1142.jpg' WHERE CategoryId = 231 AND Name = 'Kýz Bebek Tiþört';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/06/13/2725955/ab228cfc-20c6-4294-8490-e17d39f2e629_size870x1142.jpg' WHERE CategoryId = 232 AND Name = 'Kýz Bebek Þort';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/09/26/2817436/e4dc4f25-f907-4770-aa57-4b94879d01fd_size870x1142.jpg' WHERE CategoryId = 233 AND Name = 'Kýz Bebek Elbise';
UPDATE Products SET ImageUrl = 'https://cdn.yenikoza.com.tr/content/images/thumbs/f60146f4-aa66-4fdb-98c2-24ebe5d2d241_koton-erkek-bebek-ort-5smb40003tk.webp' WHERE CategoryId = 234 AND Name = 'Erkek Bebek Þort';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/02/26/2888763/6ffa92bb-13a6-47a6-aa84-e4ba9a70ddf6_size870x1142.jpg' WHERE CategoryId = 235 AND Name = 'Erkek Bebek Gömlek';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/11/21/3017764/afcf9bd1-d62c-4d02-98e3-1b90ad3d2717_size870x1142.jpg' WHERE CategoryId = 236 AND Name = 'Erkek Bebek Tiþört';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/06/27/2771904/355e9683-0cb0-42d4-84cd-1e756a6fb6da_size870x1142.jpg' WHERE CategoryId = 237 AND Name = 'Erkek Bebek Þapka';