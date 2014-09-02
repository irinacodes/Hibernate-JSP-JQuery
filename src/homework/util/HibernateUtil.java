package homework.util;


import java.io.Serializable;
import java.util.Date;
import java.util.List;
import org.hibernate.*;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

/**
 *
 * @author ibranovic
 */
public class HibernateUtil {
    private static SessionFactory sessionFactory;
    
    static {
        Configuration configuration = new Configuration().configure();
        ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry();
        sessionFactory = configuration.buildSessionFactory(serviceRegistry);
    }
    
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    
    public static void shutdown() {
        sessionFactory.close();
    }
    
    public static void saveOrUpdate(Object toSave) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(toSave);       
    }
      
    public static void delete(Object toDelete) {
       Session session = sessionFactory.getCurrentSession();
       session.delete(toDelete);
    }
    
    public static void update(Object toUpdate) {
      Session session = sessionFactory.getCurrentSession();
      session.update(toUpdate);
    }
    
    public static <T> List<T> findAll(Class<T> clazz) {
       Session session = sessionFactory.getCurrentSession();
       return (List<T>) session.createQuery("from "+ clazz.getCanonicalName()).list();
    }
    
    public static <T> T findUnique(Class<T> clazz, String paramName, Object paramValue) {
       Session session = sessionFactory.getCurrentSession();
       Query query = session.createQuery("from "+clazz.getName()+" cl where cl."+paramName+"= :argValue");
       if(Date.class.equals(clazz)) {
           //setParameter() se ne snalazi sa datumima
           query.setDate(paramName, (Date) paramValue);
       } else {
           query.setParameter("argValue", paramValue);
       }
       return (T) query.uniqueResult(); 
    }
    
    public static <T> T findByPrimaryKey(Class<T> clazz, Serializable primaryKey) {       
        //ako id stiže pravo iz requesta, onda je String
        if(primaryKey instanceof String)
           primaryKey = Integer.valueOf((String)primaryKey);
        
        Session session = sessionFactory.getCurrentSession();
        return (T) session.get(clazz, primaryKey);
    }
    
    public static <T> T load(Class<T> clazz, Serializable primaryKey) {
        //kada nam treba samo proksi
        if(primaryKey instanceof String)
           primaryKey = Integer.valueOf((String)primaryKey);
        Session session = sessionFactory.getCurrentSession();
        return (T) session.load(clazz, primaryKey);
    }
    
    public static Query createHqlQuery(String hql) {
       Session session = sessionFactory.getCurrentSession();
       return session.createQuery(hql); 
    }
    
     public static Criteria createCriteria(Class clazz) {
        Session session = sessionFactory.getCurrentSession();
        return session.createCriteria(clazz);
    }

}
