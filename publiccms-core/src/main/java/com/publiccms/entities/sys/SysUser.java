package com.publiccms.entities.sys;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.publiccms.common.database.CmsUpgrader;
import com.publiccms.common.generator.annotation.GeneratorColumn;

/**
 * SysUser generated by hbm2java
 */
@Entity
@Table(name = "sys_user", uniqueConstraints = { @UniqueConstraint(columnNames = { "name", "site_id" }),
        @UniqueConstraint(columnNames = { "nick_name", "site_id" }) })
@DynamicUpdate
public class SysUser implements java.io.Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    @GeneratorColumn(title = "ID")
    private Long id;
    @GeneratorColumn(title = "站点", condition = true)
    @JsonIgnore
    private short siteId;
    @GeneratorColumn(title = "用户名", condition = true, like = true, or = true, name = "name")
    private String name;
    @GeneratorColumn(title = "密码")
    @JsonIgnore
    private String password;
    @GeneratorColumn(title = "用户昵称", condition = true, like = true, or = true, name = "name")
    private String nickName;
    @GeneratorColumn(title = "部门", condition = true)
    private Integer deptId;
    @GeneratorColumn(title = "角色")
    private String roles;
    @GeneratorColumn(title = "邮箱", condition = true, like = true, or = true, name = "name")
    private String email;
    @GeneratorColumn(title = "已验证邮箱", condition = true)
    private boolean emailChecked;
    @GeneratorColumn(title = "是否管理员", condition = true)
    private boolean superuserAccess;
    @GeneratorColumn(title = "已禁用", condition = true)
    private boolean disabled;
    @GeneratorColumn(title = "上次登录日期", condition = true, order = true)
    private Date lastLoginDate;
    @GeneratorColumn(title = "上次登录IP")
    private String lastLoginIp;
    @GeneratorColumn(title = "登录次数", order = true)
    private int loginCount;
    @GeneratorColumn(title = "注册日期", condition = true, order = true)
    private Date registeredDate;

    public SysUser() {
    }

    public SysUser(short siteId, String name, String password, String nickName, boolean emailChecked, boolean superuserAccess,
            boolean disabled, int loginCount) {
        this.siteId = siteId;
        this.name = name;
        this.password = password;
        this.nickName = nickName;
        this.emailChecked = emailChecked;
        this.superuserAccess = superuserAccess;
        this.disabled = disabled;
        this.loginCount = loginCount;
    }

    public SysUser(short siteId, String name, String password, String nickName, Integer deptId, String roles, String email,
            boolean emailChecked, boolean superuserAccess, boolean disabled, Date lastLoginDate, String lastLoginIp,
            int loginCount, Date registeredDate) {
        this.siteId = siteId;
        this.name = name;
        this.password = password;
        this.nickName = nickName;
        this.deptId = deptId;
        this.roles = roles;
        this.email = email;
        this.emailChecked = emailChecked;
        this.superuserAccess = superuserAccess;
        this.disabled = disabled;
        this.lastLoginDate = lastLoginDate;
        this.lastLoginIp = lastLoginIp;
        this.loginCount = loginCount;
        this.registeredDate = registeredDate;
    }

    @Id
    @GeneratedValue(generator = "cmsGenerator")
    @GenericGenerator(name = "cmsGenerator", strategy = CmsUpgrader.IDENTIFIER_GENERATOR)
    @Column(name = "id", unique = true, nullable = false)
    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "site_id", nullable = false)
    public short getSiteId() {
        return this.siteId;
    }

    public void setSiteId(short siteId) {
        this.siteId = siteId;
    }

    @Column(name = "name", nullable = false, length = 50)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "password", nullable = false, length = 32)
    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "nick_name", nullable = false, length = 45)
    public String getNickName() {
        return this.nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    @Column(name = "dept_id")
    public Integer getDeptId() {
        return this.deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    @Column(name = "roles", length = 65535)
    public String getRoles() {
        return this.roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }

    @Column(name = "email", length = 100)
    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "email_checked", nullable = false)
    public boolean isEmailChecked() {
        return this.emailChecked;
    }

    public void setEmailChecked(boolean emailChecked) {
        this.emailChecked = emailChecked;
    }

    @Column(name = "superuser_access", nullable = false)
    public boolean isSuperuserAccess() {
        return this.superuserAccess;
    }

    public void setSuperuserAccess(boolean superuserAccess) {
        this.superuserAccess = superuserAccess;
    }

    @Column(name = "disabled", nullable = false)
    public boolean isDisabled() {
        return this.disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_login_date", length = 19)
    public Date getLastLoginDate() {
        return this.lastLoginDate;
    }

    public void setLastLoginDate(Date lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    @Column(name = "last_login_ip", length = 64)
    public String getLastLoginIp() {
        return this.lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    @Column(name = "login_count", nullable = false)
    public int getLoginCount() {
        return this.loginCount;
    }

    public void setLoginCount(int loginCount) {
        this.loginCount = loginCount;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "registered_date", length = 19)
    public Date getRegisteredDate() {
        return this.registeredDate;
    }

    public void setRegisteredDate(Date registeredDate) {
        this.registeredDate = registeredDate;
    }

}
