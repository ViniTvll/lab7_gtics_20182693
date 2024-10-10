package com.example.lab7_gtics_20182693.config;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;

import java.io.IOException;
import java.util.Collection;

@Configuration
public class WebSecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {


        http.formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/procesologueo")
                .usernameParameter("email")
                .successHandler(authenticationSuccessHandler()) // Llama a un método separado
                .permitAll()  // Usar el formulario de login por defecto de Spring Security
        );

        http.authorizeHttpRequests()
                .requestMatchers("/admin","/admin/**").authenticated()
                .requestMatchers("/cliente","/cliente/**").authenticated()
                .requestMatchers("/gerente","/gerente/**").authenticated()
                .anyRequest().permitAll();
        return http.build();
    }


    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return new AuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
                    throws IOException, ServletException {
                // Verificar si existe una URL guardada en la sesión (DefaultSavedRequest)
                DefaultSavedRequest savedRequest = (DefaultSavedRequest) request.getSession().getAttribute("SPRING_SECURITY_SAVED_REQUEST");
                if (savedRequest != null) {
                    String targetURL = savedRequest.getRedirectUrl();
                    redirectStrategy.sendRedirect(request, response, targetURL);
                } else {
                    // Obtener los roles del usuario autenticado
                    Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) authentication.getAuthorities();

                    // Redirigir de acuerdo al rol
                    if (authorities.stream().anyMatch(role -> role.getAuthority().equals("admin"))) {
                        response.sendRedirect("/admin/inicio");
                    } else if (authorities.stream().anyMatch(role -> role.getAuthority().equals("cliente"))) {
                        response.sendRedirect("/cliente/inicio");
                    }else if (authorities.stream().anyMatch(role -> role.getAuthority().equals("gerente"))) {
                        response.sendRedirect("/gerente/inicio");
                    } else {
                        // Si no tiene ningún rol específico, redirige a una página por defecto
                        response.sendRedirect("/login");
                    }
                }
            }
        };

}
