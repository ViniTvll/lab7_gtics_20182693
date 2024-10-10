package com.example.lab7_gtics_20182693.config;


import com.example.lab7_gtics_20182693.repository.UsersRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Collection;

@Configuration
public class WebSecurityConfig {

    final DataSource dataSource;
    public WebSecurityConfig(DataSource dataSource, UsersRepository usersRepository) {
        this.dataSource = dataSource;

    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, UsersRepository usersRepository) throws Exception {


        http.formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/submitLoginForm")
                .usernameParameter("email")
                .successHandler((request, response, authentication) -> {

                    DefaultSavedRequest defaultSavedRequest =
                            (DefaultSavedRequest) request.getSession().getAttribute("SPRING_SECURITY_SAVED_REQUEST");

                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usersRepository.findByEmail(authentication.getName()));


                    //si vengo por url -> defaultSR existe
                    if (defaultSavedRequest != null) {
                        String targetURl = defaultSavedRequest.getRequestURL();
                        new DefaultRedirectStrategy().sendRedirect(request, response, targetURl);
                    } else { //estoy viniendo del botón de login
                        String rol = "";
                        for (GrantedAuthority role : authentication.getAuthorities()) {
                            rol = role.getAuthority();
                            break;
                        }

                        if (rol.equals("admin")) {
                            response.sendRedirect("/shipper");
                        } else {
                            response.sendRedirect("/employee");
                        }
                    }
                })
                .permitAll()  // Usar el formulario de login por defecto de Spring Security
        );

        http.authorizeHttpRequests()
                .requestMatchers("/admin","/admin/**").authenticated()
                .requestMatchers("/cliente","/cliente/**").authenticated()
                .requestMatchers("/gerente","/gerente/**").authenticated()
                .anyRequest().permitAll();

        http.logout()
                .logoutSuccessUrl("/login")
                .deleteCookies("JSESSIONID")
                .invalidateHttpSession(true);
        return http.build();

    }


    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Bean
    public UserDetailsManager users(DataSource dataSource) {
        JdbcUserDetailsManager users = new JdbcUserDetailsManager(dataSource);
        //para loguearse sqlAuth -> username | password | enable
        String sqlAuth = "SELECT email, password FROM users where email = ?";

        //para autenticación -> username, nombre del rol
        String sqlAuto = "SELECT u.email, r.name FROM users u " +
                "inner join roles r on u.roleId = r.roleId " +
                "where u.email = ?";

        users.setUsersByUsernameQuery(sqlAuth);
        users.setAuthoritiesByUsernameQuery(sqlAuto);

        return users;
    }
}
