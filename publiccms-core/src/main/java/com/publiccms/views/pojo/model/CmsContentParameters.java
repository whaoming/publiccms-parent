package com.publiccms.views.pojo.model;

import java.util.List;

import com.publiccms.entities.cms.CmsContentFile;
import com.publiccms.entities.cms.CmsContentRelated;
import com.publiccms.entities.cms.CmsTag;
import com.publiccms.views.pojo.entities.ExtendData;

/**
 *
 * CmsContentParameters
 * 
 */
public class CmsContentParameters implements java.io.Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private List<CmsContentRelated> contentRelateds;
    private List<CmsTag> tags;
    private List<CmsContentFile> files;
    private List<CmsContentFile> images;
    private List<ExtendData> modelExtendDataList;
    private List<ExtendData> categoryExtendDataList;

    /**
     * @return
     */
    public List<CmsContentRelated> getContentRelateds() {
        return contentRelateds;
    }

    /**
     * @param contentRelateds
     */
    public void setContentRelateds(List<CmsContentRelated> contentRelateds) {
        this.contentRelateds = contentRelateds;
    }

    /**
     * @return
     */
    public List<CmsContentFile> getFiles() {
        return files;
    }

    /**
     * @param files
     */
    public void setFiles(List<CmsContentFile> files) {
        this.files = files;
    }

    /**
     * @return
     */
    public List<ExtendData> getModelExtendDataList() {
        return modelExtendDataList;
    }

    /**
     * @param modelExtendDataList
     */
    public void setModelExtendDataList(List<ExtendData> modelExtendDataList) {
        this.modelExtendDataList = modelExtendDataList;
    }

    /**
     * @return
     */
    public List<ExtendData> getCategoryExtendDataList() {
        return categoryExtendDataList;
    }

    /**
     * @param categoryExtendDataList
     */
    public void setCategoryExtendDataList(List<ExtendData> categoryExtendDataList) {
        this.categoryExtendDataList = categoryExtendDataList;
    }

    /**
     * @return
     */
    public List<CmsContentFile> getImages() {
        return images;
    }

    /**
     * @param images
     */
    public void setImages(List<CmsContentFile> images) {
        this.images = images;
    }

    /**
     * @return
     */
    public List<CmsTag> getTags() {
        return tags;
    }

    /**
     * @param tags
     */
    public void setTags(List<CmsTag> tags) {
        this.tags = tags;
    }
}