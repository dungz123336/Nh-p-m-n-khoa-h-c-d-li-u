create table khach_hang (
	ma_kh serial primary key,
	ten varchar (50),
	sdt varchar(15),
	dia_chi varchar (100)
);

create table san_pham (
	ma_sp serial primary key,
	ten_sp varchar(50),
	don_gia integer
);

create table don_hang (
	ma_don_hang serial primary key,
	ma_kh integer ,
	ngay_thang_nam date default current_date,
    tong_tien integer,
foreign key (ma_kh) references khach_hang(ma_kh)
);

create table chi_tiet_don_hang(
	ma_don_hang integer,
	ma_sp integer,
	foreign key (ma_don_hang) references don_hang(ma_don_hang),
	foreign key (ma_sp) references san_pham(ma_sp),
	so_luong integer not null
);

--2 tao bang "nha cung cap"
create table nha_cung_cap(
ma_nha_cung_cap serial primary key,
ten_nha_cung_cap varchar(255) not null,
sdt_lien_lac varchar(15) unique

);

--5 tao bang nhap

CREATE TABLE bang_nhap (
    id integer
);
ALTER TABLE nha_cung_cap DROP COLUMN sdt_lien_lac;
drop tabale bang_nhap;





