package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 * komanda za brisanje objekta bilo koje klase
 */
public class DeleteCommand implements Command {

    private Class clazz;

    public DeleteCommand(Class clazz) {
        this.clazz = clazz;
    }

    @Override
    public String execute(HttpServletRequest request) {
        String id = request.getParameter("id");
        try {
          HibernateUtil.delete(HibernateUtil.load(clazz, id));       
        } catch (Exception ex) {
          //narušavanje referencijalnog integriteta
          CommandsUtils.attachI18nMessage(request,"DELETE_IMPOSSIBLE");
        }
        return new ListCommand(clazz).execute(request);
    }
}
