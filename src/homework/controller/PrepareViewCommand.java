package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.util.HibernateUtil;
import homework.util.Validate;

/**
 *
 * @author ibranovic 
 * komanda koja priprema objekat koji se edituje 
 * klasa objekta koji se edituje prosledjuje se kao argument 
 */
public class PrepareViewCommand implements Command {

    private Class editableClass;

    public PrepareViewCommand(Class editableClass) {
        this.editableClass = editableClass;
    }

    @Override
    public String execute(HttpServletRequest request) {

        //id objekta koji se edituje stiže kroz request
        String id = request.getParameter("id");
        if (Validate.exists(id)) {
            //objekat koji se edituje se stavlja u request kao atribut sa nazivom editable
            request.setAttribute("editable", HibernateUtil.findByPrimaryKey(editableClass, id));
        }
        //ide na stranu koja odgovara nazivu klase objekta koji se edituje, npr. korisnik.jsp
        return editableClass.getSimpleName().toLowerCase();
    }
}
