package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.Department;
import homework.util.HibernateUtil;
import homework.util.Validate;

/**
 *
 * @author ibranovic
 */
public class DepartmentCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String departmentId = request.getParameter("odsekid");
        String name = request.getParameter("naziv");

        if (Validate.exists(name)) {
            Department department;
            
            if (Validate.exists(departmentId)) {
                //edit
                department = HibernateUtil.load(Department.class, departmentId);                     
            } else {
               //nov odsek
                department = new Department();  
            }
            
            department.setName(name);
            HibernateUtil.saveOrUpdate(department);
            return new ListCommand(Department.class).execute(request);           
        } else {
            CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
            return "department"; 
        }
    }
}
