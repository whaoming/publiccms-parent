package com.publiccms.entities.cms;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.publiccms.common.database.CmsUpgrader;
import com.publiccms.common.generator.annotation.GeneratorColumn;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@Entity
@Table(name = "cms_appointment")
@DynamicUpdate
public class CmsAppointment implements java.io.Serializable{
    private static final long serialVersionUID = 1L;
    @GeneratorColumn(title = "ID")
    private Integer id;
    @GeneratorColumn(title = "站点", condition = true)
    @JsonIgnore
    private short siteId;

    @GeneratorColumn(title = "描述")
    private String description;

    //用户id
    private long userId;
    //价格
    private int price;
    //内容id
    private long contentId;
    //创建时间
    private String createTime;
    //预约时间
    private String pointTime;
    //拍摄地址
    private String location;

    //套餐信息
    private String content_title;
    //服务时长
    private String content_duration;





    @Id
    @GeneratedValue(generator = "cmsGenerator")
    @GenericGenerator(name = "cmsGenerator", strategy = CmsUpgrader.IDENTIFIER_GENERATOR)
    @Column(name = "id", unique = true, nullable = false)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    @Column(name = "site_id", nullable = false)
    public short getSiteId() {
        return siteId;
    }

    public void setSiteId(short siteId) {
        this.siteId = siteId;
    }

    @Column(name = "description", nullable = false)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
