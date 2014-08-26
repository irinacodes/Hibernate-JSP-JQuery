
package homework.controller;

import homework.model.Department;
import homework.model.Title;
import homework.model.User;
import homework.util.HibernateUtil;
import homework.util.Validate;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public class EditUserCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String userId = request.getParameter("id");
        
        if(Validate.exists(userId))
          request.setAttribute("editable", HibernateUtil.findByPrimaryKey(User.class, userId));
        
        request.setAttribute("titlelist", HibernateUtil.findAll(Title.class));
        request.setAttribute("departmentlist", HibernateUtil.findAll(Department.class));
        return "user";
    }
    
}
