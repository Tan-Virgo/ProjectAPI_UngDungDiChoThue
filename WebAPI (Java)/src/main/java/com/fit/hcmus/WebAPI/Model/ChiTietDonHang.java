package com.fit.hcmus.WebAPI.Model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "v_chitietdonhang")
public class ChiTietDonHang 
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	@Column(name="id")
	private int id;
	
	@Column(name="madh")
	private int maDH;
	
	@Column(name="masp")
	private int maSP;
	
	@Column(name="tensp")
	private String tenSP;
	
	@Column(name="mancc")
	private int maNCC;
	
	@Column(name="tenncc")
	private String tenNCC;
	
	@Column(name="nsx")
	private String nsx;
	
	@Column(name="gia")
	private float gia;
	
	@Column(name="soluong")
	private int soLuong;
	
	public ChiTietDonHang() 
	{
		
	}
	
	public ChiTietDonHang(int id, int madh, int masp, String tensp,
			int mancc, String tenncc, String nsx, float gia, int soluong) 
	{
		this.id = id;
		this.maDH = madh;
		this.maSP = masp;
		this.maNCC = mancc;
		this.tenSP = tensp;
		this.tenNCC = tenncc;
		this.nsx = nsx;
		this.gia = gia;
		this.soLuong = soluong;
	}
	
	public ChiTietDonHang(String tensp, String tenncc, String nsx, float gia, int soluong) 
	{
		this.tenSP = tensp;
		this.tenNCC = tenncc;
		this.nsx = nsx;
		this.gia = gia;
		this.soLuong = soluong;
	}
	
	public int getID()
	{
		return id;
	}
	
	
	public int getMaDH()
	{
		return maDH;
	}
	
	public void setMaDH(int madh)
	{
		this.maDH = madh;
	}
	
	public int getMaSP()
	{
		return maSP;
	}
	
	public void setMaSP(int masp)
	{
		this.maSP = masp;
	}
	
	public int getMaNCC()
	{
		return maNCC;
	}
	
	public void setMaNCC(int mancc)
	{
		this.maNCC = mancc;
	}
	
	public String getTenSP()
	{
		return tenSP;
	}
	
	public void setTenSP(String tensp)
	{
		this.tenSP= tensp;
	}
	
	public String getTenNCC()
	{
		return tenNCC;
	}
	
	public void setTenNCC(String tenncc)
	{
		this.tenNCC= tenncc;
	}
	
	public String getNSX()
	{
		return nsx;
	}
	
	public void setNSX(String nsx)
	{
		this.nsx = nsx;
	}
	
	public int getSoLuong()
	{
		return soLuong;
	}
	
	public void setSoLuong(int soluong)
	{
		this.soLuong = soluong;
	}
	
	public float getGia()
	{
		return gia;
	}
	
	public void setGia(int gia)
	{
		this.gia = gia;
	}
	
	@Override
	public String toString() {
		return "ChiTietDonHang [maDH = " + maDH + 
				", maSP=" + maSP +
				", tenSP=" + tenSP + 
				", maNCC=" + maNCC + 
				", tenNCC=" + tenNCC +
				", nsx=" + nsx + 
				", gia=" + gia + 
				", soLuong=" + soLuong +"]";
	}
}
