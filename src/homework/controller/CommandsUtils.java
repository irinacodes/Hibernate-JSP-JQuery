package homework.controller;

import homework.model.User;
import java.util.Locale;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.jstl.core.Config;

/**
 *
 * @author ibranovic
 */
public class CommandsUtils {

    //iz sesije vadi jezik i stavlja prevedenu poruku u request
    public static void attachI18nMessage(HttpServletRequest request, String message) {
        
        Locale locale = (Locale) Config.get(request.getSession(), Config.FMT_LOCALE);
        if (locale == null) {
            locale = new Locale("en_US");//default locale
        }
        ResourceBundle bundle = ResourceBundle.getBundle("homework.I18n.bundle", locale);
        if (message != null && !message.isEmpty()) {
            request.setAttribute("message", bundle.getString(message));
        }
    }

    //šalje na različite početne strane u zavisnosti od uloge
    public static String homePageSwitch(User user, HttpServletRequest request) {
        String next = "index";
        if (user != null) {
            if (user.isAdmin()) {
                //napravi listu svih korisnika
                next = new UserListCommand().execute(request);
            } else if (user.isInstructor()) {
                //napravi listu lab vezbi
                next = new InstructorExercisesCommand().execute(request);
            } else {
                //spisak poziva za vežbe za demonstratora
                next = new EnrollmentListCommand().execute(request);
            }
        }
        return next;
    }
}
