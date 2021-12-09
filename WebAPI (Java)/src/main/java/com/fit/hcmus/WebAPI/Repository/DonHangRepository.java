package com.fit.hcmus.WebAPI.Repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.fit.hcmus.WebAPI.Model.DonHang;

public interface DonHangRepository extends JpaRepository<DonHang, Integer> 
{
	//List<DonHang> findByMaKHAndTrangThai(int makh, String trangthai);
	
	@Query("SELECT v FROM V_DonHang v")
    List<DonHang> findByMaKHAndTrangThai(@Param("makh") Integer makh, @Param("trangthai") String trangthai);
}
