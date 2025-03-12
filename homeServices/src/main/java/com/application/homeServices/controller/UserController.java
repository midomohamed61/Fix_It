package com.application.homeServices.controller;

import com.application.homeServices.dto.Customerdata;
import com.application.homeServices.service.ImageService;
import com.application.homeServices.service.ProfileServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/customer")
public class UserController {

    @Autowired
    private ProfileServices profileServices;

    @PostMapping("/data")
    public ResponseEntity<?> userData(@RequestBody Customerdata customerdata) {
        return ResponseEntity.ok(profileServices.CustomerEdit(customerdata));
    }


}