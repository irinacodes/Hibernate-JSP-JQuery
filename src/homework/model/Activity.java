package homework.model;

import homework.util.HibernateUtil;
import javax.persistence.*;
import org.hibernate.Query;


/**
 *
 * @author ibranovic
 */

@Entity
@Table(name = "AKTIVNOST")
public class Activity {
    
    @Id 
    @GeneratedValue
    private Integer id;

    @Column (name="naziv")
    private String name;
    
    @Column (name="koeficijent")
    private Double coefficient;

    public Activity() {
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

    public Double getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(Double coefficient) {
        this.coefficient = coefficient;
    } 

    public static Activity ofDemonstratorOnExercise(Exercise exercise, User demonstrator) {
        String hql = " select enroll.activity from Enrollment enroll where enroll.user = :argUser "
                + " and enroll.exercise = :argExercise";
        Query query = HibernateUtil.createHqlQuery(hql); 
        query.setParameter("argUser", demonstrator);
        query.setParameter("argExercise", exercise);
        return (Activity) query.uniqueResult(); 
    }

}
