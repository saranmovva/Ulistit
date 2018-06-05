package edu.ben.controller;

import edu.ben.model.User;
import edu.ben.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController extends BaseController {
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;

	/**
	 * @Autowired ServletContext context;
	 */

	@Autowired
	UserService userService;

	@PostMapping("/loginUser")
	public String login(HttpServletRequest request) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		System.out.println(email);
		System.out.println(password);

		User user = userService.findBySchoolEmail(email);

		String url = "";
		String message = "";

        if (user != null) {
            if (user.getBanned() < 1) {
                if (user.getActive() > 0 && user.getLocked() < 1) {
                    if (user.getPassword() != null && user.getPassword().equals(password)) {
                        request.getSession().setAttribute("user", user);
                        userService.updateAttemptedLogins(0, user);

                        HttpSession session = request.getSession();
                        // Set the timeout for one hour
                        session.setMaxInactiveInterval(-1);
                        session.setAttribute("user", user);

                        user.setLoggedIn(1);
                        userService.update(user);

                        if (request.getSession().getAttribute("lastPage") != null) {
                            String lastPage = (String) request.getSession().getAttribute("lastPage");
                            request.getSession().removeAttribute("lastPage");
                            return "redirect:" + lastPage;
                        }
                        return "redirect:/index";

					} else {
						request.setAttribute("email", email);
						int loginAttempts = user.getLoginAttempts() + 1;
						userService.updateAttemptedLogins(loginAttempts, user);

						if (loginAttempts >= 5) {
							userService.lockByUsername(user.getUsername());
							addErrorMessage(
									"invalid username and password - login limit exceeded, your account has been locked out");
						} else {
							addErrorMessage("invalid password - you have " + (5 - loginAttempts) + " remaining");
						}
						url = "login";
					}
				} else {
					addErrorMessage("Your account is locked out, click unlock to activate your account");
					url = "login";
				}
			} else {
				addErrorMessage("This account is currently banned from our site");
				url = "login";
			}
		} else {
			addErrorMessage("We didn't find your email linked to an account in our Database");
			url = "login";
		}

		request.setAttribute("email", email);
		request.setAttribute("message", message);
		setRequest(request);
		return url;

	}

	@GetMapping("/landingPage")
	public String landingPage() {
		return "landingPage";
	}

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/unlock")
	public String unlock() {
		return "unlock";
	}

	@GetMapping("/reset")
	public String emailReset() {
		return "emailReset";
	}

	@GetMapping("/banAppeal")
	public String banAppeal() {
		return "banAppeal";
	}

	@GetMapping("/email")
	public String email() {
		return "email";
	}

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {

        User u = (User) request.getSession().getAttribute("user");

        if (u == null) {
            addErrorMessage("No User Logged In");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        HttpSession session = request.getSession();
        session.invalidate();

        // Mark user as logged out in db
        u.setLoggedIn(0);
        userService.update(u);

        request.removeAttribute("user");
        return "redirect:/";

    }

	@RequestMapping(value="loginValidEmail", method= RequestMethod.POST, produces="application/json")
	public @ResponseBody boolean loginValidEmail(HttpServletRequest request, @RequestParam("email") String email){
		User usr = userService.findBySchoolEmail(email);
		if(usr != null) {
			return true;
		}
		return false;
	}

	/*
	 * @PostMapping("/unlock") public String unlock(HttpServletRequest request) {
	 * String action = request.getParameter("action"); String message = ""; String
	 * url = "unlock";
	 * 
	 * if (action.equals("email")) { String email = request.getParameter("email");
	 * 
	 * User user = userService.findBySchoolEmail(email);
	 * 
	 * if (user != null) {
	 * 
	 * Email mail = new Email(); message = Email.unlockCode(email); url = "unlock";
	 * } else {
	 * 
	 * message = "We didn't find your email linked to an account in our Database";
	 * url = "unlockCode";
	 * 
	 * }
	 * 
	 * } else if (action.equals("code")) {
	 * 
	 * String email = request.getParameter("email"); String code =
	 * request.getParameter("code");
	 * 
	 * User user = userService.findBySchoolEmail(email);
	 * 
	 * if (user != null) {
	 * 
	 * if (code.equals(user.getUnlockCode())) { UserDAO.updateIsActive(1, email);
	 * message = "Account successfully unlocked"; url = "login"; } else { message =
	 * "The entered code doesn't match the code we sent you"; url = "unlock"; }
	 * 
	 * } else {
	 * 
	 * message = "We didn't find your email linked to an account in our Database";
	 * 
	 * }
	 * 
	 * }
	 * 
	 * request.setAttribute("message", message); return url;
	 * 
	 * }
	 * 
	 * }
	 */
}
