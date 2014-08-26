package homework.model;

import homework.util.HibernateUtil;
import java.util.*;
import javax.persistence.*;
import org.hibernate.Query;

/**
 *
 * @author ibranovic
 */

@Entity
@Table(name = "LABVEZBA")
public class Exercise {

    @Id 
    @GeneratedValue
    private Integer id;
    
    @Column (name="naziv")
    private String name;
        
    @Column (name="datum")
    @Temporal(TemporalType.DATE)
    private Date date;
    
    @Column (name="vremeod")
    @Temporal(TemporalType.TIME)
    private Date timeFrom;
    
    @Column (name="vremedo")
    @Temporal(TemporalType.TIME)
    private Date timeTo;
    
    @Column (name="laboratorija")
    private String laboratory;
    
    @Column (name="maxbrdemo")
    private Integer maxDemonstratorNo;
    
    @Column (name="zakljucana")
    private Boolean locked = false;

    @ManyToOne
    @JoinColumn(name="predmetid")
    private Course course;
    
    @OneToMany(mappedBy="exercise")
    private Set<Enrollment> enrollments = new HashSet<Enrollment>();

    public Set<Enrollment> getEnrollments() {
        return enrollments;
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

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getTimeFrom() {
        return timeFrom;
    }

    public void setTimeFrom(Date timeFrom) {
        this.timeFrom = timeFrom;
    }

    public Date getTimeTo() {
        return timeTo;
    }

    public void setTimeTo(Date timeTo) {
        this.timeTo = timeTo;
    }

    public String getLaboratory() {
        return laboratory;
    }

    public void setLaboratory(String laboratory) {
        this.laboratory = laboratory;
    }

    public Integer getMaxDemonstratorNo() {
        return maxDemonstratorNo;
    }

    public void setMaxDemonstratorNo(Integer maxDemonstratorNo) {
        this.maxDemonstratorNo = maxDemonstratorNo;
    }

    public Boolean isLocked() {
        return locked;
    }

    public Boolean getLocked() {
        return isLocked();
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }

    public Exercise() {
    }
    
    //zaključavanje lab vežbe
    public void lock() {
        setLocked(true);
        HibernateUtil.saveOrUpdate(this);
    }

    
 
    //pozivi za vežbe koje demonstrator moze da vidi
    public static List<Exercise> callsForDemonstrator(User demonstrator, boolean accepted, boolean locked) {
        String hql="select enroll.exercise from Enrollment enroll where enroll.exercise.locked is :argLocked"
                + " and enroll.accepted is :argAccepted and enroll.user = :argUser";
        Query query = HibernateUtil.createHqlQuery(hql);
        query.setParameter("argLocked", locked);
        query.setParameter("argUser", demonstrator);
        query.setParameter("argAccepted", accepted);
        return (List<Exercise>)query.list();   
    }
    
    public static List<Exercise> callsForDemonstrator(User demonstrator) {
       return callsForDemonstrator(demonstrator, false, false);
    }
    
    public static List<Exercise> exerciseInCourseForDemonstrator(User demonstrator) {
       return callsForDemonstrator(demonstrator, true, false);
    }
   
    //lista vežbi koja se prikazuje nastavniku za njegove predmete
    public static List<Exercise> listForInstructor(User instructor) {
        String hql = "from Exercise ex where ex.course in (:courseList)";
        Query query = HibernateUtil.createHqlQuery(hql);
        query.setParameterList("courseList", instructor.getCourses());
        return (List<Exercise>) query.list();
    }

    //demonstratori koji su prihvatili dežurstvo za vežbu
    public List<User> getEnrolledDemonstrators() {
        String hql = "select enroll.user from Enrollment enroll where enroll.exercise = :argExercise and enroll.accepted is true";
        Query query = HibernateUtil.createHqlQuery(hql);
        query.setParameter("argExercise", this);
        return (List<User>) query.list();
    }
}
