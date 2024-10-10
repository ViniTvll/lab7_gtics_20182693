package com.example.lab7_gtics_20182693.repository;

import com.example.lab7_gtics_20182693.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsersRepository extends JpaRepository<Users, Integer> {

    public Users findByEmail(String email);
}
