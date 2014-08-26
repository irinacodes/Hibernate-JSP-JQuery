package homework.model;

import javax.persistence.*;

/**
 *
 * @author ibranovic
 */

@Entity
@Table(name = "ODSEK")
public class Department {

    @Id 
    @GeneratedValue
    private Integer id;   
    
    @Column (name="naziv")
    private String name;

    public Department() {
    }

    public Integer getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
