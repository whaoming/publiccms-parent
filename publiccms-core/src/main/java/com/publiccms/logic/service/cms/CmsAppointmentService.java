package com.publiccms.logic.service.cms;

import com.publiccms.common.base.BaseService;
import com.publiccms.common.handler.PageHandler;
import com.publiccms.entities.cms.CmsAppointment;
import com.publiccms.entities.cms.CmsCategoryAttribute;
import com.publiccms.logic.dao.cms.CmsAppointmentDao;
import com.publiccms.logic.dao.cms.CmsCategoryDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 *
 * CmsCategoryAttributeService
 * 
 */
@Service
@Transactional
public class CmsAppointmentService extends BaseService<CmsAppointment> {
    private String[] ignoreProperties = new String[] { "categoryId" };



    @Transactional(readOnly = true)
    public PageHandler getPage(Short siteId, Integer pageIndex,
                               Integer pageSize) {
        return dao.getPage(siteId, pageIndex, pageSize);
    }

    @Autowired
    private CmsAppointmentDao dao;
}