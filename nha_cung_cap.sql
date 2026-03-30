SELECT * FROM public.nha_cung_cap
ORDER BY ma_nha_cung_cap ASC 
INSERT INTO nha_cung_cap(ten_nha_cung_cap,sdt_lien_lac, email) 
VALUES 
('Công ty Sữa Việt Nam', '0987654321', 'contact@vinamilk.vn'),
('Công ty Thực phẩm Á Châu', '0912345678', 'contact@acecook.vn');
UPDATE nha_cung_cap
SET sdt_lien_lac = '0911112222'
WHERE ten_nha_cung_cap = 'Công ty Thực phẩm Á Châu';