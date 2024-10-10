package com.example.lab7_gtics_20182693.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/gerente")
public class GerenteController {

    @GetMapping("/proyecciones")
    public String proyeccionesGerente(){

        return "gerente/proyecciones";
    }

    @GetMapping("/reservas")
    public String reservasGerente(){

        return "gerente/reservas";
    }
}
