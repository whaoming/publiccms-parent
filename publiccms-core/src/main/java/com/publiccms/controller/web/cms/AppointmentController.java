package com.publiccms.controller.web.cms;

import com.publiccms.common.base.AbstractController;
import com.publiccms.common.tools.CommonUtils;
import com.publiccms.common.tools.ControllerUtils;
import com.publiccms.common.tools.RequestUtils;
import com.publiccms.entities.cms.CmsAppointment;
import com.publiccms.entities.cms.CmsPlace;
import com.publiccms.entities.log.LogOperate;
import com.publiccms.entities.sys.SysSite;
import com.publiccms.entities.sys.SysUser;
import com.publiccms.logic.service.cms.CmsAppointmentService;
import com.publiccms.logic.service.cms.CmsPlaceService;
import com.publiccms.logic.service.log.LogLoginService;
import com.publiccms.views.pojo.model.CmsPlaceParameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("appointment")
public class AppointmentController extends AbstractController {
    @Autowired
    private CmsAppointmentService service;

    @RequestMapping(value = "save")
    public String save(CmsAppointment entity, String returnUrl, String _csrf,
                       HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model) {
        SysUser user = ControllerUtils.getUserFromSession(session);
        if(user == null){
            return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
        }

        SysSite site = getSite(request);
        if (CommonUtils.empty(returnUrl)) {
            returnUrl = site.getDynamicPath();
        }
        if (entity == null) {
            entity = new CmsAppointment();
        }
        entity.setDescription("我是预约描述");
        entity.setSiteId(site.getId());
        System.out.println("asd");
        service.save(entity);
        return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
    }
}
