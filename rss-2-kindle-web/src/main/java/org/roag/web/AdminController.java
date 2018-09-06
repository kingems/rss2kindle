package org.roag.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by eurohlam on 19/02/2018.
 */
@Controller
@RequestMapping("admin")
@Secured({"ROLE_ADMIN"})
public class AdminController extends AbstractController {

    private final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @RequestMapping(value="users", method = RequestMethod.GET)
    public String adminPage(ModelMap model) {
        return "admin/users";
    }

}
