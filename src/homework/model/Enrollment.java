package homework.model;

import homework.util.HibernateUtil;
import javax.persistence.*;
import org.hibernate.Query;


/**
 *
 * @author ibranovic
 * prijava za vežbu
 */

@Entity
@Table(name = "KORISNIK_VEZBA")
public class Enrollment {
    
    @Id 
    @GeneratedValue
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name="korisnikid")
    private User user;
    
    @ManyToOne
    @JoinColumn(name="vezbaid")
    private Exercise exercise;
    
    @ManyToOne
    @JoinColumn(name="aktivnostid")
    private Activity activity;
    
    @Column (name="komentar")
    private String comment;
    
    @Column (name="prihvacena")
    private Boolean accepted = false;
    
    public Integer getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Boolean getAccepted() {
        return accepted;
    }

    public void setAccepted(Boolean accepted) {
        this.accepted = accepted;
    }

    public Enrollment() {
    }
    
    //prijava za određenu vežbu za određenog demonstratora
    public static Enrollment findForUserAndExercise(User user, Exercise exercise) {
        String hql = " from Enrollment as enroll where enroll.user = :argUser and enroll.exercise = :argExercise";
        Query query = HibernateUtil.createHqlQuery(hql); 
        query.setParameter("argUser", user);
        query.setParameter("argExercise", exercise);
        return (Enrollment) query.uniqueResult(); 
    }
     
}
