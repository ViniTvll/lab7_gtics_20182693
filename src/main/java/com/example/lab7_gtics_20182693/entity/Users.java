package com.example.lab7_gtics_20182693.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="usurs")
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    private Integer id;
    @Column(nullable = false)
    private String name;
    private String password;
    private String email;

    @ManyToOne
    @JoinColumn(name= "roleId")
    private Roles roles;
}
