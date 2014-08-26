package homework.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.digest.DigestUtils;
import homework.model.User;
import homework.util.HibernateUtil;
import homework.util.Validate;

/**
 *
 * @author ibranovic
 */
public class ChangePasswordCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String password = request.getParameter("pwd");
        String newPassword = request.getParameter("newpwd");
        String newPasswordConfirm = request.getParameter("newpwdconfirm");
        String nextPage = "changepassword";
        
        boolean validParams = Validate.exists(password) && Validate.exists(newPassword) 
                && Validate.exists(newPasswordConfirm);

        if (validParams) {
            
            if (newPassword.equals(newPasswordConfirm)) {
                
                HttpSession session = request.getSession();
                User logged = (User) session.getAttribute("korisnik");

                if (logged.getPassword().equals(DigestUtils.sha1Hex(password))) {
                    //promeni lozinku i posalji na početnu stranu
                    logged.setPassword(DigestUtils.sha1Hex(newPassword));
                    HibernateUtil.saveOrUpdate(logged);
                    CommandsUtils.attachI18nMessage(request,"PASSWORD_SUCCESS");
                    session.invalidate();
                    nextPage="index";  
                } else {                   
                    CommandsUtils.attachI18nMessage(request,"PASSWORD_OLD_NOT_VALID");
                }
                
           } else {
               CommandsUtils.attachI18nMessage(request,"PASSWORD_MISMATCH");           
           } 
        } else {
           CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
        }
        return nextPage;
    }
}
