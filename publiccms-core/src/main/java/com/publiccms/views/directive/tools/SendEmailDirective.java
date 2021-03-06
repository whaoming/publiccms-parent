package com.publiccms.views.directive.tools;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.publiccms.common.base.AbstractTemplateDirective;
import com.publiccms.common.handler.RenderHandler;
import com.publiccms.common.tools.CommonUtils;
import com.publiccms.common.tools.FreeMarkerUtils;
import com.publiccms.entities.sys.SysSite;
import com.publiccms.logic.component.site.EmailComponent;
import com.publiccms.logic.component.template.TemplateComponent;

/**
 *
 * SendEmailDirective
 * 
 */
@Component
public class SendEmailDirective extends AbstractTemplateDirective {

    @Override
    public void execute(RenderHandler handler) throws IOException, Exception {
        String email = handler.getString("email");
        String title = handler.getString("title");
        String templatePath = handler.getString("templatePath");
        if (CommonUtils.notEmpty(email) && CommonUtils.notEmpty(title)) {
            SysSite site = getSite(handler);
            String content = handler.getString("content");
            if (CommonUtils.notEmpty(templatePath)) {
                Map<String, Object> model = new HashMap<>();
                expose(handler, model);
                content = FreeMarkerUtils.generateStringByFile(siteComponent.getWebTemplateFilePath(site, templatePath),
                        templateComponent.getWebConfiguration(), model);
            }
            if (CommonUtils.notEmpty(content)) {
                handler.put("result", emailComponent.sendHtml(site.getId(), email, title, content)).render();
            }
        }
    }

    @Override
    public boolean needAppToken() {
        return true;
    }

    @Autowired
    private EmailComponent emailComponent;
    @Autowired
    private TemplateComponent templateComponent;
}
