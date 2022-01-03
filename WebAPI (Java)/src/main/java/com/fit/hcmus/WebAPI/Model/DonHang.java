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
	
	@Column(name="hinhthucthanhtoan")
	private String hinhThucThanhToan;

	@Column(name="phivanchuyen")
	private float phiVanChuyen;
	
	@Column(name="makh")
	private int maKH;
	
	@Column(name="tenkh")
	private String tenKH;
	
	@Column(name="mashipper")
	private int maShipper;
	
	@Column(name="tenshipper")
	private String tenShipper;
	

	public DonHang() 
	{ 
		
	}
	
	public DonHang(int madh, String ngaylap, float tongtien, String trangthai, 
			String hinhthucthanhtoan, float phivanchuyen, 
			int makh, String tenkh, int mashipper, String tenshipper) 
	{
		this.maDH = madh;
		this.ngayLap = ngaylap;
		this.tongTien = tongtien;
		this.trangThai = trangthai;
		this.hinhThucThanhToan = hinhthucthanhtoan;
		this.phiVanChuyen = phivanchuyen;
		this.maKH = makh;
		this.tenKH = tenkh;
		this.maShipper = mashipper;
		this.tenShipper = tenshipper;
	}
	
	public DonHang(String ngaylap, float tongtien, String trangthai, 
			String hinhthucthanhtoan, float phivanchuyen, 
			int makh, String tenkh, int mashipper, String tenshipper) 
	{
		this.ngayLap = ngaylap;
		this.tongTien = tongtien;
		this.trangThai = trangthai;
		this.maKH = makh;
		this.hinhThucThanhToan = hinhthucthanhtoan;
		this.phiVanChuyen = phivanchuyen;
		this.maKH = makh;
		this.tenKH = tenkh;
		this.maShipper = mashipper;
		this.tenShipper = tenshipper;
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

	public String getHinhThucThanhToan()
	{
		return hinhThucThanhToan;
	}
	
	public void setHinhThucThanhToan(String hinhthucthanhtoan)
	{
		this.hinhThucThanhToan = hinhthucthanhtoan;
	}
	
	public float getPhiVanChuyen()
	{
		return phiVanChuyen;
	}
	
	public void setPhiVanChuyen(float phivanchuyen)
	{
		this.phiVanChuyen = phivanchuyen;
	}
	
	public int getMaKH()
	{
		return maKH;
	}
	
	public void setMaKH(int makh)
	{
		this.maKH = makh;
	}
	
	public String getTenKH()
	{
		return tenKH;
	}
	
	public void setTenKH(String tenkh)
	{
		this.tenKH = tenkh;
	}
	
	public int getMaShipper()
	{
		return maShipper;
	}
	
	public void setMaShipper(int mashipper)
	{
		this.maShipper = mashipper;
	}
	
	public String getTenShipper()
	{
		return tenShipper;
	}
	
	public void setTenShipper(String tenshipper)
	{
		this.tenShipper = tenshipper;
	}
	
	@Override
	public String toString() {
		return "DonHang [maDH = " + maDH + 
				", ngayLap=" + ngayLap + 
				", tongTien=" + tongTien + 
				", trangThai=" + trangThai + 
				", maKH=" + maKH +
				", hinhThucThanhToan=" + hinhThucThanhToan + 
				", phiVanChuyen=" + phiVanChuyen +
				",  maKH=" + maKH +
				", tenKH=" + tenKH +
				", maShipper="+ maShipper + 
				", tenShipper=" + tenShipper +"]";
	}
	

}
