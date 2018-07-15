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
