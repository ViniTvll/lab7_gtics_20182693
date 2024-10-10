package com.example.lab7_gtics_20182693.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/peliculas")
    public String peliculasAdmin(){

        return "admin/peliculas";
    }

    @GetMapping("/proyecciones")
    public String proyeccionesAdmin(){

        return "admin/proyecciones";
    }

    @GetMapping("/salas")
    public String salasAdmin(){

        return "admin/salas";
    }

}
