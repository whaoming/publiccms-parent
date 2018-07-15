package com.publiccms.logic.dao.cms;

import com.publiccms.common.base.BaseDao;
import com.publiccms.common.constants.CommonConstants;
import com.publiccms.common.handler.PageHandler;
import com.publiccms.common.handler.QueryHandler;
import com.publiccms.common.tools.CommonUtils;
import com.publiccms.entities.cms.CmsAppointment;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public class CmsAppointmentDao extends BaseDao<CmsAppointment> {
    @Override
    protected CmsAppointment init(CmsAppointment entity) {
        return entity;
    }

    public PageHandler getPage(Short siteId, Integer pageIndex, Integer pageSize) {
        QueryHandler queryHandler = getQueryHandler("from CmsAppointment bean");
        if (CommonUtils.notEmpty(siteId)) {
            queryHandler.condition("bean.siteId = :siteId").setParameter("siteId", siteId);
        }
        return getPage(queryHandler, pageIndex, pageSize);
    }
}
