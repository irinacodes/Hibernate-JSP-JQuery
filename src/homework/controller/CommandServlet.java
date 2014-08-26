package homework.controller;

import homework.model.Activity;
import homework.model.Department;
import homework.model.Exercise;
import homework.model.Course;
import homework.model.Enrollment;
import java.io.IOException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author ibranovic
 */

@WebServlet(name="CommandServlet", urlPatterns={"/CommandServlet"}) 
public class CommandServlet extends HttpServlet {

    Map<String, Command> commands = new HashMap<String, Command>();

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        commands.put("login", new LoginCommand());
        commands.put("logout", new LogoutCommand());
        commands.put("index", new NullCommand("index"));
        commands.put("promenilozinku", new NullCommand("changepassword"));
        commands.put("lozinka", new ChangePasswordCommand());       
        commands.put("korisnik", new UserCommand());
        commands.put("korisnici", new UserListCommand());
        commands.put("demonstratori", new DemonstratorCommand());
        commands.put("demohome", new DemonstratorHomeCommand());
        commands.put("editkorisnik", new EditUserCommand());
        commands.put("aktivirajkorisnika", new ActivateUserCommand(true));
        commands.put("deaktivirajkorisnika", new ActivateUserCommand(false));
        commands.put("pronadjikorisnika", new FindUserCommand());
        commands.put("labvezbe", new ListCommand(Exercise.class));   
        commands.put("labvezba", new ExerciseCommand());
        commands.put("mojevezbe", new InstructorExercisesCommand());
        commands.put("editlabvezba", new PrepareViewCommand(Exercise.class));
        commands.put("obrisilabvezbu", new DeleteCommand(Exercise.class));
        commands.put("zakljucajlabvezbu", new LockExerciseCommand());
        commands.put("prijava", new EnrollmentCommand());
        commands.put("pozovidemo", new CallDemonstratorsCommand());
        commands.put("prijave", new ListCommand(Enrollment.class));
        commands.put("potvrdiprijavu", new ConfirmEnrollmentCommand());
        commands.put("odbijprijavu", new RefuseEnrollmentCommand());
        commands.put("obrisiprijavu", new DeleteCommand(Enrollment.class));
        commands.put("prijavademo", new EnrollmentListCommand());
        commands.put("predmet", new CourseCommand());        
        commands.put("predmeti", new ListCommand(Course.class));
        commands.put("mojipredmeti", new InstructorCoursesCommand());
        commands.put("editpredmet", new PrepareViewCommand(Course.class));
        commands.put("obrisipredmet", new DeleteCommand(Course.class));
        commands.put("dodelipredmet", new EditCoursesCommand()); 
        commands.put("korisnikpredmet", new AssignCoursesCommand()); 
        commands.put("odsek", new DepartmentCommand());
        commands.put("odseci", new ListCommand(Department.class));
        commands.put("editodsek", new PrepareViewCommand(Department.class));
        commands.put("obrisiodsek", new DeleteCommand(Department.class));
        commands.put("aktivnost", new ActivityCommand());
        commands.put("aktivnosti", new ListCommand(Activity.class));
        commands.put("editaktivnost", new PrepareViewCommand(Activity.class));
        commands.put("obrisiaktivnost", new DeleteCommand(Activity.class));
        commands.put("promenijezik", new ChangeLanguageCommand());
    }

    private Command lookupCommand(String cmd, HttpServletRequest request) {
        if (commands.containsKey(cmd.toLowerCase())) {
            return commands.get(cmd);
        } else {
            request.getSession().invalidate();
            return new NullCommand("index");
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String cmd = request.getParameter("cmd");
        Command command = lookupCommand(cmd, request);
        String next;
        try {
            next = command.execute(request);
            getServletContext().getRequestDispatcher("/" + next + ".jsp").forward(request, response);
        } catch (Exception ex) {
           request.setAttribute(RequestDispatcher.ERROR_EXCEPTION, ex);
           request.setAttribute(RequestDispatcher.ERROR_SERVLET_NAME, CommandServlet.class.getName());
           getServletContext().getRequestDispatcher("/ErrorHandlingServlet").forward(request, response); 
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Command servlet";
    }
}
