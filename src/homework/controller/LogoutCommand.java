package homework.controller;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public class LogoutCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        request.getSession().invalidate();
        return "index";
    }
}
