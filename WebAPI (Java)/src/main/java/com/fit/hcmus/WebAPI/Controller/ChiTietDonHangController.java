package com.fit.hcmus.WebAPI.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fit.hcmus.WebAPI.Model.ChiTietDonHang;
import com.fit.hcmus.WebAPI.Repository.ChiTietDonHangRepository;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:3000")
public class ChiTietDonHangController 
{
	@Autowired
	private ChiTietDonHangRepository chiTietDonHangRepository;
	
	@GetMapping("/chitietdonhangs")

	public ResponseEntity<List<ChiTietDonHang>> getChiTietDonHang()
	{
		List<ChiTietDonHang> chitietdonhangs = new ArrayList<ChiTietDonHang>();
		
		try
		{	
			chiTietDonHangRepository.findAll().forEach(chitietdonhangs::add);
			
			if(chitietdonhangs.isEmpty()) 
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			
			return new ResponseEntity<>(chitietdonhangs, HttpStatus.OK);
		}
		catch (Exception e)
		{
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
