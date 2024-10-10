package com.example.lab7_gtics_20182693.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cliente")
public class ClienteController {

    @GetMapping("/peliculas")
    public String peliculasCliente(){

        return "cliente/peliculas";
    }

    @GetMapping("/reservas")
    public String reservasCliente(){

        return "cliente/reservas";
    }
}
