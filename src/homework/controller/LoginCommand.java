package homework.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.digest.DigestUtils;
import homework.model.User;
import homework.util.Validate;

public class LoginCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {

        String username = request.getParameter("user");
        String password = request.getParameter("pwd");
        String next = "index";

        //provera parametara na serverskoj strani
        boolean validParams = Validate.exists(username) && Validate.exists(password);
        
        HttpSession session = request.getSession();
        if (validParams) {
            User user = User.findByUsername(username);
            if (user != null && user.isActive() && passwordMatch(user, password)) {               
                session.setAttribute("korisnik", user);
                next = CommandsUtils.homePageSwitch(user, request);
            } else {
                //pogrešni podaci
               CommandsUtils.attachI18nMessage(request,"TRY_AGAIN");
            }
        } else {
            //nisu unete sve vrednosti
            CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
        }
        return next;
    }
    

    private boolean passwordMatch(User user, String password) {
        return user.getPassword().equals(DigestUtils.sha1Hex(password));
    }

    
}
