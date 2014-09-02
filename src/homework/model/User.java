package homework.model;

import homework.util.ConversionUtils;
import homework.util.HibernateUtil;
import homework.util.Validate;
import java.io.Serializable;
import java.util.*;
import javax.persistence.*;

import org.hibernate.*;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author ibranovic
 */
@Entity
@Table(name = "KORISNIK")
public class User {

    @Id
    @GeneratedValue
    private Integer id;
    @Column(name = "korisnickoime")
    private String username;
    @Column(name = "lozinka")
    private String password;
    @Column(name = "ime")
    private String name;
    @Column(name = "prezime")
    private String surname;
    @Column(name = "telefon")
    private String phone;
    @Column(name = "eposta")
    private String email;
    @Column(name = "godstudija")
    private Integer yearOfStudy;
    @Column(name = "prosek")
    private Double gpa;
    @Column(name = "admin")
    private Boolean admin = false;
    @Column(name = "aktivan")
    private Boolean active = false;

    //one-to-many veza
    @ManyToOne
    @JoinColumn(name = "zvanjeid")
    private Title title;

    //many-to-many veze
    //kada čuvamo korisnika, čuvamo i njegove predmete i odseke (cascade save - update)
    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "KORISNIK_ODSEK",
            joinColumns = {
                    @JoinColumn(name = "korisnikid")},
            inverseJoinColumns = {
                    @JoinColumn(name = "odsekid")})
    private Set<Department> departments = new HashSet<Department>();

    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "KORISNIK_PREDMET",
            joinColumns = {
                    @JoinColumn(name = "korisnikid")},
            inverseJoinColumns = {
                    @JoinColumn(name = "predmetid")})
    private Set<Course> courses = new HashSet<Course>();

    public User() {
    }

    public Integer getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getYearOfStudy() {
        return yearOfStudy;
    }

    public void setYearOfStudy(Integer yearOfStudy) {
        this.yearOfStudy = yearOfStudy;
    }

    public Double getGpa() {
        return gpa;
    }

    public void setGpa(Double gpa) {
        this.gpa = gpa;
    }

    public Boolean isAdmin() {
        return admin;
    }

    public Boolean getAdmin() {
        return isAdmin();
    }

    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }

    public Boolean isActive() {
        return active;
    }

    public Boolean getActive() {
        return isActive();
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public boolean isInstructor() {
        return title.isInstructor();
    }

    public boolean getInstructor() {
        return isInstructor();
    }

    public boolean isDemonstrator() {
        return title.isDemonstrator();
    }

    public boolean getDemonstrator() {
        return isDemonstrator();
    }

    public Title getTitle() {
        return title;
    }

    public void setTitle(Title title) {
        this.title = title;
    }

    public Set<Department> getDepartments() {
        return departments;
    }

    public Set<Course> getCourses() {
        return courses;
    }

    public void addCourse(Course course) {
        courses.add(course);
    }

    public void addCourse(Serializable courseId) {
        courses.add(HibernateUtil.load(Course.class, courseId));
    }

    public void clearCourses() {
        courses.clear();
    }

    public void addDepartment(Department department) {
        departments.add(department);
    }

    public void addDepartment(Serializable departmentId) {
        departments.add(HibernateUtil.load(Department.class, departmentId));
    }

    public void clearDepartments() {
        departments.clear();
    }

    //admin može da aktivira ili deaktivira korisnika
    public void changeVisibility(Boolean isActive) {
        setActive(isActive);
        HibernateUtil.saveOrUpdate(this);
    }

    //svi nastavnici
    public static List<User> findInstructors() {
        List<String> titles = new ArrayList<String>();
        titles.add(Title.TEACHING_ASSISTANT);
        titles.add(Title.ASSISTANT_PROF);
        titles.add(Title.ASSOCIATED_PROF);
        titles.add(Title.FULL_PROF);
        return findByTitle(titles);
    }

    public static List<User> findDemonstrators() {
        List<String> titles = new ArrayList<String>();
        titles.add(Title.DEMONSTRATOR);
        return findByTitle(titles);
    }

    private static List<User> findByTitle(List<String> argsList) {
        Query query = HibernateUtil.createHqlQuery("from User user where user.title.name in (:argList)");
        query.setParameterList("argList", argsList);
        return query.list();
    }

    public static User findByUsername(String username) {
        Query query = HibernateUtil.createHqlQuery("from User user where user.username = :argUsername");
        query.setString("argUsername", username);
        return (User) query.uniqueResult();
    }

    //primer korišćenja Hibernate Criteria API za složene upite
    public static List<User> find(String name, String surname, String[] titleIds,
                                  String[] courseIds, boolean demonstratorsOnly) {

        Criteria criteria = HibernateUtil.createCriteria(User.class)
                .createAlias("courses", "c")
                .createAlias("title", "t");

        if (Validate.exists(name)) {
            criteria.add(Restrictions.eq("name", name));
        }
        if (Validate.exists(surname)) {
            criteria.add(Restrictions.eq("surname", surname));
        }
        if (titleIds != null) {
            criteria.add(Restrictions.in("t.id", ConversionUtils.stringArrayToIntegerList(courseIds)));
        }
        if (courseIds != null) {
            criteria.add(Restrictions.in("c.id", ConversionUtils.stringArrayToIntegerList(courseIds)));
        }
        if (demonstratorsOnly) {
            criteria.add(Restrictions.eq("t.name", Title.DEMONSTRATOR));
        }

        //dodavanje klauzule distinct
        criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);

        return (List<User>) criteria.list();
    }

    //kada ne bi postojao Criteria API u alatu Hibernate
    //morao bi se konstruisati peške ovaj ružan kod

    /*   public static List<User> find(String name, String surname, String[] titleIds,
     String[] courseIds, boolean demonstratorsOnly) {

     boolean allEmpty = !Validate.exists(name) && !Validate.exists(surname)
     && courseIds == null && titleIds == null;
     String hql = "select user from User user ";

     if (!allEmpty) {
     StringBuilder conditionalHql = new StringBuilder();
     if (courseIds != null) {
     hql += " join user.courses c ";
     conditionalHql.append(" and c.id in (:courseIds) ");
     }
     hql+=" where";
     if (Validate.exists(name)) {
     conditionalHql.append(" and user.name = :argName ");
     }
     if (Validate.exists(surname)) {
     conditionalHql.append(" and user.surname = :argSurname ");
     }

     if (titleIds != null) {
     conditionalHql.append(" and user.title.id in (:titleIds) ");
     }
     if(demonstratorsOnly) {
     conditionalHql.append(" and user.title.name = :demoName ");
     }
     //izbaci prvi and
     hql += conditionalHql.substring(4, conditionalHql.length()) + " group by user.id ";
     }

     Query query = HibernateUtil.createHqlQuery(hql);
     if (Validate.exists(name)) {
     query.setString("argName", name);
     }
     if (Validate.exists(surname)) {
     query.setString("argSurname", surname);
     }
     if (courseIds != null) {
     query.setParameterList("courseIds", stringArrayToIntegerList(courseIds));
     }
     if (titleIds != null) {
     query.setParameterList("titleIds", stringArrayToIntegerList(titleIds));
     }
     if(demonstratorsOnly) {
     query.setString("demoName", Title.DEMONSTRATOR);
     }
     return query.list();
     } */

    //demonstratori koji se mogu pozvati za vežbu
    public static List<User> getAvailableDemonstratorsForExercise(Exercise exercise) {
        String hql = "select distinct user from User user "
                + " where :argCourse member of user.courses"
                + " and user.title.name = :argDemo"
                + " and user.active is true "
                + " and user not in "
                + "(select enroll.user from Enrollment enroll where enroll.exercise = :argExercise "
                + " and enroll.exercise.locked is false) ";
        Query query = HibernateUtil.createHqlQuery(hql);
        query.setString("argDemo", Title.DEMONSTRATOR);
        query.setEntity("argCourse", exercise.getCourse());
        query.setEntity("argExercise", exercise);
        return query.list();
    }

}
