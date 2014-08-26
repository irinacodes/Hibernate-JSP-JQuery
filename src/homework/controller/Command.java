package homework.controller;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public interface Command {

    public String execute(HttpServletRequest request);
}
