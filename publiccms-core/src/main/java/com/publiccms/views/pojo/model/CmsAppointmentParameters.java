package com.publiccms.views.pojo.model;

import com.publiccms.views.pojo.entities.ExtendData;

import java.util.List;

public class CmsAppointmentParameters  implements java.io.Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;
    List<ExtendData> extendDataList;

    /**
     * @return
     */
    public List<ExtendData> getExtendDataList() {
        return extendDataList;
    }

    /**
     * @param extendDataList
     */
    public void setExtendDataList(List<ExtendData> extendDataList) {
        this.extendDataList = extendDataList;
    }
}