package com.publiccms.logic.dao.sys;

import java.util.Date;

import org.springframework.stereotype.Repository;

import com.publiccms.common.base.BaseDao;
import com.publiccms.common.handler.PageHandler;
import com.publiccms.common.handler.QueryHandler;
import com.publiccms.common.tools.CommonUtils;
import com.publiccms.entities.sys.SysAppToken;

/**
 *
 * SysAppTokenDao
 * 
 */
@Repository
public class SysAppTokenDao extends BaseDao<SysAppToken> {

    /**
     * @param appId
     * @param pageIndex
     * @param pageSize
     * @return results page
     */
    public PageHandler getPage(Integer appId, Integer pageIndex, Integer pageSize) {
        QueryHandler queryHandler = getQueryHandler("from SysAppToken bean");
        if (CommonUtils.notEmpty(appId)) {
            queryHandler.condition("bean.appId = :appId").setParameter("appId", appId);
        }
        queryHandler.order("bean.id desc");
        return getPage(queryHandler, pageIndex, pageSize);
    }

    /**
     * @param createDate
     * @return number of data deleted
     */
    public int delete(Date createDate) {
        if (null != createDate) {
            QueryHandler queryHandler = getDeleteQueryHandler("from SysAppToken bean");
            queryHandler.condition("bean.createDate <= :createDate").setParameter("createDate", createDate);
            return delete(queryHandler);
        }
        return 0;
    }

    @Override
    protected SysAppToken init(SysAppToken entity) {
        if (null == entity.getCreateDate()) {
            entity.setCreateDate(CommonUtils.getDate());
        }
        return entity;
    }

}