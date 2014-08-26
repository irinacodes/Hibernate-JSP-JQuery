package homework.controller;

import homework.model.User;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.core.Config;

/**
 *
 * @author ibranovic
 */
public class ChangeLanguageCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String language = request.getParameter("lang"); //sr ili en
       
        if(language.equals("sr"))
          Config.set(session, Config.FMT_LOCALE, new Locale("sr","RS"));
        else
          Config.set(session, Config.FMT_LOCALE, new Locale("en","US")); 
        
        User logged = (User) session.getAttribute("korisnik");
        return CommandsUtils.homePageSwitch(logged, request); 
    }   
    
}
