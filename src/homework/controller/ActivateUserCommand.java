
package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.User;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 */
public class ActivateUserCommand implements Command {
    
    private boolean isActive;
    
    public ActivateUserCommand(boolean active) {
        this.isActive = active;
    }

    @Override
    public String execute(HttpServletRequest request) {
        String userId = request.getParameter("id");
        User toBeActivated = HibernateUtil.findByPrimaryKey(User.class, userId);
        toBeActivated.changeVisibility(isActive);
        //nakon aktivacije ili deaktivacije, treba se vratiti na listu korisnika
        return new UserListCommand().execute(request);
    }
    
}
