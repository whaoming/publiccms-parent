package com.publiccms.views.directive.tools;

// Generated 2015-5-10 17:54:56 by com.publiccms.common.source.SourceGenerator

import java.io.IOException;

import com.publiccms.common.base.AbstractTemplateDirective;
import com.publiccms.common.constants.CommonConstants;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.publiccms.common.handler.RenderHandler;
import com.publiccms.logic.component.file.FileComponent;

/**
 *
 * WebFileListDirective
 * 
 */
@Component
public class WebFileListDirective extends AbstractTemplateDirective {

    @Override
    public void execute(RenderHandler handler) throws IOException, Exception {
        String path = handler.getString("path", CommonConstants.SEPARATOR);
        handler.put("list",
                fileComponent.getFileList(siteComponent.getWebFilePath(getSite(handler), path), handler.getString("orderField")))
                .render();
    }

    @Override
    public boolean needAppToken() {
        return true;
    }

    @Autowired
    private FileComponent fileComponent;

}