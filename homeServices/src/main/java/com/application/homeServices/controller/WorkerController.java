package com.application.homeServices.controller;

import com.application.homeServices.dto.Customerdata;
import com.application.homeServices.dto.Workerdata;
import com.application.homeServices.service.ProfileServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/worker")
public class WorkerController {

    @Autowired
    private ProfileServices profileServices;

    @PostMapping("/data")
    public ResponseEntity<?> userData(@RequestBody Workerdata workerdata) {
        return ResponseEntity.ok(profileServices.WorkerEdit(workerdata));
    }
}