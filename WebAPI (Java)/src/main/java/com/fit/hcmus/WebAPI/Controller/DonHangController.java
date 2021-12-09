package com.fit.hcmus.WebAPI.Controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fit.hcmus.WebAPI.Model.DonHang;
import com.fit.hcmus.WebAPI.Repository.DonHangRepository;


@RestController
@RequestMapping("/api")
public class DonHangController 
{
	@Autowired
	private DonHangRepository donHangRepository;
	
	@GetMapping("/donhangs/{makh}/{trangthai}")
	//Lấy tất cả đơn hàng theo mã khách hàng và trạng thái
	public ResponseEntity<List<DonHang>> getDonHangTheoTrangThai
	(@PathVariable("makh") int makh, @PathVariable("trangthai") int trangthai)
	{
		try
		{
			String t = "";
			if (trangthai == 1)
				t = "Đã giao";
			else if (trangthai == 2)
				t = "Đang giao";
			else t = "Đổi trả";
			
			List<DonHang> donhangs = donHangRepository.findByMaKHAndTrangThai(makh, t);
			
			if(donhangs.isEmpty()) 
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			
			return new ResponseEntity<>(donhangs, HttpStatus.OK);
		}
		catch (Exception e)
		{
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
}
