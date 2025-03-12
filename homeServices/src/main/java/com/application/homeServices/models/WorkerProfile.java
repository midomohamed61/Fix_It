package com.application.homeServices.models;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Worker_profile ")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class WorkerProfile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(name = "user_id")
    private long userId;
    private String name;
    private String jobTittle;

    public WorkerProfile (long id, String name,String jobTittle) {
        this.userId=id;
        this.name=name;
        this.jobTittle=jobTittle;
    }
}
