package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 * komanda koja u request stavlja listu svih objekata
 * bilo koje perzistentne klase
 */
public class ListCommand implements Command {

    private Class clazz;

    public ListCommand(Class clazz) {
        this.clazz = clazz;
    }

    @Override
    public String execute(HttpServletRequest request) {
        request.setAttribute("lista", HibernateUtil.findAll(clazz));
        //salje na jsp stranu npr. userlist, courselist, exerciselist i sl.
        return clazz.getSimpleName().toLowerCase() + "list";
    }
}
