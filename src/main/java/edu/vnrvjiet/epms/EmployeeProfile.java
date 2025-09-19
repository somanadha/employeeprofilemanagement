package edu.vnrvjiet.epms;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.net.URL;

@Data
@AllArgsConstructor
@Entity
public class EmployeeProfile {
    @Id
    private Integer employeeId;
    private String name;
    private String mobile;
    private String email;
    private URL linkedInUrl;
}
