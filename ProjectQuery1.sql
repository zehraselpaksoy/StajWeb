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
INSERT INTO Categories (Name, ParentId) VALUES ('Kad�n', NULL);
INSERT INTO Categories (Name, ParentId) VALUES ('Bebek', NULL);

INSERT INTO Categories (Name, ParentId)
VALUES ('Aksesuar', 178);

INSERT INTO Categories (Name, ParentId)
VALUES
('Parf�m', 181),
('�apka', 181);

INSERT INTO Categories (Name, ParentId)
VALUES ('Aksesuar', 179);

INSERT INTO Categories (Name, ParentId)
VALUES
('K�z Bebek', 180),
('Erkek Bebek', 180);

-- 2. Aksesuar'� Kad�n'�n alt kategorisi olarak ekle

INSERT INTO Categories (Name, ParentId)
VALUES 
('K�pe', 182),
('Kemer', 182),
('Kolye', 182);

INSERT INTO Categories (Name, ParentId) VALUES ('Giyim', 178);
INSERT INTO Categories (Name, ParentId) VALUES ('Ayakkab�', 178);
INSERT INTO Categories (Name, ParentId) VALUES ('�anta', 178);

-- Kad�n alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Giyim', 179);
INSERT INTO Categories (Name, ParentId) VALUES ('Ayakkab�', 179);
INSERT INTO Categories (Name, ParentId) VALUES ('�anta', 179);



-- Erkek Giyim alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('G�mlek',188);
INSERT INTO Categories (Name, ParentId) VALUES ('Pantolon', 188);

-- Erkek Ayakkab� alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 189);
INSERT INTO Categories (Name, ParentId) VALUES ('S�vet', 189);

-- Erkek �anta alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 190);
INSERT INTO Categories (Name, ParentId) VALUES ('S�vet', 190);

-- Kad�n Giyim alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('G�mlek', 191);
INSERT INTO Categories (Name, ParentId) VALUES ('Pantolon', 191);

-- Kad�n Ayakkab� alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 192);
INSERT INTO Categories (Name, ParentId) VALUES ('S�vet', 192);

-- Kad�n �anta alt kategorileri
INSERT INTO Categories (Name, ParentId) VALUES ('Deri', 193);
INSERT INTO Categories (Name, ParentId) VALUES ('S�vet', 193);

-- Kad�n > Giyim kategorisinin Id'si 6 (�nceki tablodan)
INSERT INTO Categories (Name, ParentId)
VALUES 
('Ti��rt', 191),
('�ort', 191),
('Kazak', 191),
('Ceket', 191);

-- Erkek > Giyim kategorisinin Id'si 3
INSERT INTO Categories (Name, ParentId)
VALUES 
('Ti��rt', 188),
('�ort', 188),
('Kazak', 188),
('Ceket', 188);

-- 1. Kad�n kategorisinin Id'si 2
-- 2. Aksesuar'� Kad�n'�n alt kategorisi olarak ekle

INSERT INTO Categories (Name, ParentId)
VALUES 
('K�pe', 182),
('Kemer', 182),
('Kolye', 182);


INSERT INTO Categories (Name, ParentId)
VALUES
('Parf�m', 181),
('�apka', 181);



INSERT INTO Categories (Name, ParentId)
VALUES
('Toka', 194),
('Ti��rt', 194),
('�ort', 194),
('Elbise', 194);

INSERT INTO Categories (Name, ParentId)
VALUES
('�ort', 195),
('G�mlek', 195),
('Ti��rt', 195),
('�apka', 195);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Siyah �ort', '��k ve rahat erkek �ort', 178.00, 50, 222),
('Erkek Resmi Ceket ', '��k erkek ceket', 480.00, 25, 224),
('Erkek G�mlek Slim Fit', '��k ve rahat erkek g�mlek', 180.00, 50, 205),
('Erkek Pantolon Klasik', 'Konforlu ve dayan�kl� klasik pantolon', 210.00, 40, 206),
('Erkek Ti��rt Casual', 'G�nl�k kullan�m i�in ti��rt', 90.00, 70, 221),
('Erkek Kazak', 'S�cak tutan lacivert kazak', 220.00, 30, 223);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Deri �anta', 'Kaliteli siyah deri �anta', 320.00, 20, 209),
('Erkek S�vet �anta', 'Rahat s�et �anta', 250.00, 15, 210)
('Erkek Deri Ayakkab�', 'Kaliteli siyah deri ayakkab�', 320.00, 20, 207),
('Erkek S�vet Ayakkab�', 'Rahat s�et ayakkab�', 250.00, 15, 208);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Kad�n G�mlek �ifon', 'Hafif ve ��k g�mlek', 170.00, 40, 211),
('Kad�n Pantolon Dar Kesim', 'Modern tasar�m pantolon', 190.00, 30, 212),
('Kad�n Ti��rt Yazl�k', 'Rahat ve hafif ti��rt', 120.00, 60, 217),
('Kad�n �ort Keten', 'Yazl�k �ort', 140.00, 50, 218),
('Kad�n Kazak', 'K�� i�in s�cak kazak', 200.00, 35, 219),
('Kad�n Ceket', '��k ofis ceketi', 250.00, 20, 220);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Kad�n K�pe Alt�n Kaplama', 'Zarif alt�n kaplama k�pe', 80.00, 100, 185),
('Kad�n Kemer Deri', 'Kaliteli deri kemer', 90.00, 80, 186),
('Kad�n Kolye �nci', '��k inci kolye', 150.00, 60, 187);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('K�z Bebek Toka', 'Renkli ve yumu�ak toka', 25.00, 100, 230),
('K�z Bebek Ti��rt', 'Pamuklu rahat ti��rt', 30.00, 100, 231),
('K�z Bebek �ort', 'Yazl�k �ort', 35.00, 80, 232),
('K�z Bebek Elbise', '�irin elbise', 50.00, 60, 233);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Bebek �ort', 'Yumu�ak kuma� �ort', 30.00, 90, 234),
('Erkek Bebek G�mlek', 'K���k g�mlek', 40.00, 70, 235),
('Erkek Bebek Ti��rt', 'Rahat ti��rt', 30.00, 80, 236),
('Erkek Bebek �apka', 'Koruyucu �apka', 25.00, 75, 237);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Erkek Parf�m', 'Ferahlat�c� erkek parf�m�', 300.00, 40, 183),
('Erkek �apka', 'Modern erkek �apkas�', 100.00, 50, 184);

INSERT INTO Products (Name, Description, Price, Stock, CategoryId) VALUES
('Kad�n Deri �anta', 'Kaliteli siyah deri �anta', 320.90, 20, 215),
('Kad�n S�vet �anta', 'Rahat s�et �anta', 250.99, 15, 216),
('Kad�n Deri Ayakkab�', 'Kaliteli siyah deri ayakkab�', 120.95, 20, 213),
('kad�n S�vet Ayakkab�', 'Rahat s�et ayakkab�', 250.00, 15, 214);

ALTER TABLE Products
ADD ImageUrl NVARCHAR(MAX) NULL;
GO


-- Erkek �r�nleri i�in
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/05/02/2730921/4848eb42-682a-43f4-8081-bebb38cabb5d_size870x1142.jpg' WHERE CategoryId = 222 AND Name = 'Erkek Siyah �ort';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/24/454219/eba84b68-b940-48d4-a73d-0092347a7a74_size870x1142.jpg' WHERE CategoryId = 224 AND Name = 'Erkek Resmi Ceket ';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/09/13/96295/145e5ed1-0f1a-446d-aacb-6a9c23df62da_size870x1142.jpg' WHERE CategoryId = 205 AND Name = 'Erkek G�mlek Slim Fit';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2021/11/10/84283/dae10fa0-d444-458b-8293-c311653dca03_size870x1142.jpg' WHERE CategoryId = 206 AND Name = 'Erkek Pantolon Klasik';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/02/14/2868533/8004fa45-7c7e-4a7b-a4eb-45de9db0ef28_size870x1142.jpg' WHERE CategoryId = 221 AND Name = 'Erkek Ti��rt Casual';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/12/04/2850138/b2e18cf6-834b-4d08-91db-c7898832e3e1_size870x1142.jpg' WHERE CategoryId = 223 AND Name = 'Erkek Kazak';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/25/749245/41ba3efc-01ef-4e02-bd07-21e77cbfdc68_size870x1142.jpg' WHERE CategoryId = 209 AND Name = 'Erkek Deri �anta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/09/09/2986742/aff76034-8d6e-4a64-a585-a9b52241986d.jpg' WHERE CategoryId = 210 AND Name = 'Erkek S�vet �anta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/23/444119/813f0295-26d5-4eac-8954-9420b7552df1_size870x1142.jpg' WHERE CategoryId = 207 AND Name = 'Erkek Deri Ayakkab�';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2021/11/09/77476/88a80b9e-aed3-41da-a76a-22772f113a89_size870x1142.jpg' WHERE CategoryId = 208 AND Name = 'Erkek S�vet Ayakkab�';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/04/13/2669748/f8dcac93-2e10-43e0-b1c8-8ddcc5e43f20_size870x1142.jpg' WHERE CategoryId = 183 AND Name = 'Erkek Parf�m';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/03/18/2895579/8188c57c-7965-48e1-a829-faab7b6148cb_size870x1142.jpg' WHERE CategoryId = 184 AND Name = 'Erkek �apka';


-- Kad�n �r�nleri i�in
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/04/13/2744773/e5d0c3a1-9637-4e62-b485-6573f869f80e_size870x1142.jpg' WHERE CategoryId = 211 AND Name = 'Kad�n G�mlek �ifon';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/03/21/2710149/d9e7e5c9-ce5b-4081-aed4-aee7244dcc76_size870x1142.jpg' WHERE CategoryId = 212 AND Name = 'Kad�n Pantolon Dar Kesim';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/12/28/2859799/b73dad82-2b57-4824-b057-4ecd9f8343d2_size870x1142.jpg' WHERE CategoryId = 217 AND Name = 'Kad�n Ti��rt Yazl�k';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/04/18/2739318/e68377f7-d8fa-47f5-ae27-efd07e7bcf44_size870x1142.jpg' WHERE CategoryId = 218 AND Name = 'Kad�n �ort Keten';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/10/17/2826145/44156795-33c3-4b15-9e92-1075a1f9810d_size870x1142.jpg' WHERE CategoryId = 219 AND Name = 'Kad�n Kazak';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/08/14/2971876/2c16d9cd-1bd0-4d8f-82f1-f788d47c2d64_size870x1142.jpg' WHERE CategoryId = 220 AND Name = 'Kad�n Ceket';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/11/16/2620235/2b82a6b7-725c-4af5-84c3-08cbdec14e7f.jpg' WHERE CategoryId = 185 AND Name = 'Kad�n K�pe Alt�n Kaplama';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/08/22/2977649/39b7274b-4e68-4d3c-8ec9-64584894a1e2_size870x1142.jpg' WHERE CategoryId = 186 AND Name = 'Kad�n Kemer Deri';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/06/27/2940932/639b27e5-ec0f-4fb0-908c-3d0ce536834d.jpg' WHERE CategoryId = 187 AND Name = 'Kad�n Kolye �nci';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/05/16/1033660/59e73e46-7338-4709-ada6-346687c94dec_size870x1142.jpg' WHERE CategoryId = 215 AND Name = 'Kad�n Deri �anta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/11/27/2991607/72ddf19d-1ebc-4a9a-a856-6b89af9cee68_size870x1142.jpg' WHERE CategoryId = 216 AND Name = 'Kad�n S�vet �anta';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/23/442382/61bb44f7-9407-49df-9be0-45a6958996a2_size870x1142.jpg' WHERE CategoryId = 213 AND Name = 'Kad�n Deri Ayakkab�';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2022/04/30/247717/b1c219da-19e8-4311-b85d-f69b4ce5f035.jpg' WHERE CategoryId = 214 AND Name = 'kad�n S�vet Ayakkab�';


-- Bebek �r�nleri i�in
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/05/09/2917503/7740ab54-3607-4e98-a540-c7af5016f602_size870x1142.jpg' WHERE CategoryId = 230 AND Name = 'K�z Bebek Toka';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/09/04/2804574/bd3f9e48-6a66-490e-b4f9-dd06728d3dbf_size870x1142.jpg' WHERE CategoryId = 231 AND Name = 'K�z Bebek Ti��rt';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/06/13/2725955/ab228cfc-20c6-4294-8490-e17d39f2e629_size870x1142.jpg' WHERE CategoryId = 232 AND Name = 'K�z Bebek �ort';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2023/09/26/2817436/e4dc4f25-f907-4770-aa57-4b94879d01fd_size870x1142.jpg' WHERE CategoryId = 233 AND Name = 'K�z Bebek Elbise';
UPDATE Products SET ImageUrl = 'https://cdn.yenikoza.com.tr/content/images/thumbs/f60146f4-aa66-4fdb-98c2-24ebe5d2d241_koton-erkek-bebek-ort-5smb40003tk.webp' WHERE CategoryId = 234 AND Name = 'Erkek Bebek �ort';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/02/26/2888763/6ffa92bb-13a6-47a6-aa84-e4ba9a70ddf6_size870x1142.jpg' WHERE CategoryId = 235 AND Name = 'Erkek Bebek G�mlek';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/11/21/3017764/afcf9bd1-d62c-4d02-98e3-1b90ad3d2717_size870x1142.jpg' WHERE CategoryId = 236 AND Name = 'Erkek Bebek Ti��rt';
UPDATE Products SET ImageUrl = 'https://ktnimg2.mncdn.com/products/2024/06/27/2771904/355e9683-0cb0-42d4-84cd-1e756a6fb6da_size870x1142.jpg' WHERE CategoryId = 237 AND Name = 'Erkek Bebek �apka';