package com.example.demo;

import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

	@GetMapping("/")
	public HashMap<String, Object> jsongetClientDetail(HttpServletRequest request) {
		
		
		
	    HashMap<String, Object> map = new HashMap<>();
	    Date currentDate = new Date();
	    ;
	    map.put("timestamp", currentDate.getTime() / 1000);
	    map.put("ip", request.getRemoteAddr());
	    return map;
	}
	
}
