package com.publiccms.views.directive.cms;

import java.io.IOException;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.publiccms.common.base.AbstractTemplateDirective;
import com.publiccms.common.constants.CommonConstants;
import com.publiccms.common.handler.PageHandler;
import com.publiccms.common.handler.RenderHandler;
import com.publiccms.common.tools.CommonUtils;
import com.publiccms.logic.service.cms.CmsPlaceService;

/**
 *
 * CmsPlaceListDirective
 * 
 */
@Component
public class CmsPlaceListDirective extends AbstractTemplateDirective {

    @Override
    public void execute(RenderHandler handler) throws IOException, Exception {
        Date endPublishDate = handler.getDate("endPublishDate");
        String path = handler.getString("path");
        Boolean disabled = false;
        Integer status = CmsPlaceService.STATUS_NORMAL;
        if (handler.getBoolean("advanced", false)) {
            status = handler.getInteger("status");
            disabled = handler.getBoolean("disabled", false);
        } else {
            Date now = CommonUtils.getMinuteDate();
            if (null == endPublishDate || endPublishDate.after(now)) {
                endPublishDate = now;
            }
        }
        if (CommonUtils.notEmpty(path)) {
            path = path.replace("//", CommonConstants.SEPARATOR);
        }
        PageHandler page = service.getPage(getSite(handler).getId(), handler.getLong("userId"), path,
                handler.getString("itemType"), handler.getLong("itemId"), handler.getDate("startPublishDate"),
                handler.getDate("endPublishDate"), status, disabled, handler.getString("orderField"),
                handler.getString("orderType"), handler.getInteger("pageIndex", 1), handler.getInteger("count", 30));
        handler.put("page", page).render();
    }

    @Autowired
    private CmsPlaceService service;

}