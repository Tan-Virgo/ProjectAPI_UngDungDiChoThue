package com.fit.hcmus.WebAPI.Repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.fit.hcmus.WebAPI.Model.ChiTietDonHang;

public interface ChiTietDonHangRepository  extends JpaRepository<ChiTietDonHang, Integer>  
{
	//@Query("SELECT v FROM V_ChiTietDonHang v")
    //List<ChiTietDonHang> findByMaDH(@Param("madh") Integer madh);

}
