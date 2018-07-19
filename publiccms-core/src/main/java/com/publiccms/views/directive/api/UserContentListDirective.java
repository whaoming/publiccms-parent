package com.publiccms.views.directive.api;

import com.publiccms.common.base.AbstractTemplateDirective;
import com.publiccms.common.handler.PageHandler;
import com.publiccms.common.handler.RenderHandler;
import com.publiccms.entities.sys.SysUser;
import com.publiccms.logic.service.cms.CmsAppointmentService;
import com.publiccms.logic.service.cms.CmsContentService;
import com.publiccms.views.pojo.query.CmsContentQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class UserContentListDirective extends AbstractTemplateDirective {


    @Override
    public void execute(RenderHandler handler) throws IOException, Exception {

        long userId = handler.getInteger("userId", -1);
        PageHandler page = service.getPage(
                new CmsContentQuery(getSite(handler).getId(), handler.getIntegerArray("status"), handler.getInteger("categoryId"),
                        handler.getIntegerArray("categoryIds"), false, null, handler.getLong("parentId"),
                        handler.getBoolean("emptyParent"), handler.getBoolean("onlyUrl"), handler.getBoolean("hasImages"),
                        handler.getBoolean("hasCover"), handler.getBoolean("hasFiles"), null, userId, null,
                        handler.getDate("endPublishDate")),
                handler.getBoolean("containChild"), null, null, handler.getInteger("pageIndex", 1),
                handler.getInteger("count", 30));
        handler.put("page", page).render();
    }

    @Autowired
    private CmsContentService service;
}
