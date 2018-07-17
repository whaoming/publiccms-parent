package com.publiccms.views.directive.cms;

import com.publiccms.common.base.AbstractTemplateDirective;
import com.publiccms.common.handler.PageHandler;
import com.publiccms.common.handler.RenderHandler;
import com.publiccms.logic.service.cms.CmsAppointmentService;
import freemarker.core.Environment;
import freemarker.ext.servlet.HttpSessionHashModel;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.mail.Session;
import java.io.IOException;
import java.util.Map;

/**
 *
 * CmsPlaceListDirective
 * 
 */
@Component
public class CmsAppointmentListDirective extends AbstractTemplateDirective {


    @Override
    public void execute(RenderHandler handler) throws IOException, Exception {

        PageHandler page = service.getPage(getSite(handler).getId(), handler.getInteger("pageIndex", 1), handler.getInteger("count", 30));
        handler.put("page", page).render();
    }

    @Override
    public void execute(Environment environment, Map parameters, TemplateModel[] loopVars, TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException {

        super.execute(environment, parameters, loopVars, templateDirectiveBody);
    }

    @Autowired
    private CmsAppointmentService service;

}