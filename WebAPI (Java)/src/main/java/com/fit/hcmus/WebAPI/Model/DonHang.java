package com.fit.hcmus.WebAPI.Model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "v_donhang")

public class DonHang 
{	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="madh")
	private int maDH;
	
	@Column(name="ngaylap")
	private String ngayLap;
	
	@Column(name="tongtien")
	private float tongTien; 
	
	@Column(name="trangthai")
	private String trangThai;
	
	@Column(name="makh")
	private int maKH;
	
	@Column(name="hinhthucthanhtoan")
	private String hinhThucThanhToan;
	
	@Column(name="madvvc")
	private int maDVVC;
	
	@Column(name="phivanchuyen")
	private float phiVanChuyen;
	
	@Column(name="tendvvc")
	private String tenDVVC;
	
	@Column(name="tenkh")
	private String tenKH;
	
	public DonHang() 
	{ 
		
	}
	
	public DonHang(int madh, String ngaylap, float tongtien, String trangthai, 
			int makh, String hinhthucthanhtoan, int madvvc, float phivanchuyen, String tendvvc, String tenkh) 
	{
		this.maDH = madh;
		this.ngayLap = ngaylap;
		this.tongTien = tongtien;
		this.trangThai = trangthai;
		this.maKH = makh;
		this.hinhThucThanhToan = hinhthucthanhtoan;
		this.maDVVC = madvvc;
		this.phiVanChuyen = phivanchuyen;
		this.tenDVVC = tendvvc;
		this.tenKH = tenkh;
	}
	
	public DonHang(String ngaylap, float tongtien, String trangthai, 
			int makh, String hinhthucthanhtoan, int madvvc, float phivanchuyen, String tendvvc, String tenkh) 
	{
		this.ngayLap = ngaylap;
		this.tongTien = tongtien;
		this.trangThai = trangthai;
		this.maKH = makh;
		this.hinhThucThanhToan = hinhthucthanhtoan;
		this.maDVVC = madvvc;
		this.phiVanChuyen = phivanchuyen;
		this.tenDVVC = tendvvc;
		this.tenKH = tenkh;
	}
	
	public int getMaDH()
	{
		return maDH;
	}
	
	public void setMaDH(int madh)
	{
		this.maDH = madh;
	}

	public String getNgayLap()
	{
		return ngayLap;
	}
	
	public void setNgayLap(String ngaylap)
	{
		this.ngayLap = ngaylap;
	}
	
	public float getTongTien()
	{
		return tongTien;
	}
	
	public void setTongTien(float tongtien)
	{
		this.tongTien = tongtien;
	}
	
	public String getTrangThai()
	{
		return trangThai;
	}
	
	public void setTrangThai(String trangthai)
	{
		this.trangThai = trangthai;
	}

	public int getMaKH()
	{
		return maKH;
	}
	
	public void setMaKH(int makh)
	{
		this.maKH = makh;
	}
	
	public String getHinhThucThanhToan()
	{
		return hinhThucThanhToan;
	}
	
	public void setHinhThucThanhToan(String hinhthucthanhtoan)
	{
		this.hinhThucThanhToan = hinhthucthanhtoan;
	}
	
	public int getMaDVVC()
	{
		return maDVVC;
	}
	
	public void setMaDVVC(int madvvc)
	{
		this.maDVVC = madvvc;
	}
	
	public float getPhiVanChuyen()
	{
		return phiVanChuyen;
	}
	
	public void setPhiVanChuyen(float phivanchuyen)
	{
		this.phiVanChuyen = phivanchuyen;
	}
	
	public String getTenDVVC()
	{
		return tenDVVC;
	}
	
	public void setTenDVVC(String tendvvc)
	{
		this.tenDVVC = tendvvc;
	}
	public String getTenKH()
	{
		return tenKH;
	}
	
	public void setTenKH(String tenkh)
	{
		this.tenKH = tenkh;
	}
	
	@Override
	public String toString() {
		return "DonHang [maDH = " + maDH + 
				", ngayLap=" + ngayLap + 
				", tongTien=" + tongTien + 
				", trangThai=" + trangThai + 
				", maKH=" + maKH +
				", hinhThucThanhToan=" + hinhThucThanhToan + 
				", maDVVC=" + maDVVC +
				", phiVanChuyen=" + phiVanChuyen +
				", tenDVVC=" + tenDVVC + 
				", tenKH=" + tenKH + "]";
	}
	

}
