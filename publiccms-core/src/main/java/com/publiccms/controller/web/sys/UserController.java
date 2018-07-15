package com.publiccms.controller.web.sys;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.publiccms.common.base.AbstractController;
import com.publiccms.common.constants.CommonConstants;
import com.publiccms.common.tools.CommonUtils;
import com.publiccms.common.tools.ControllerUtils;
import com.publiccms.common.tools.FreeMarkerUtils;
import com.publiccms.common.tools.RequestUtils;
import com.publiccms.common.tools.VerificationUtils;
import com.publiccms.entities.log.LogOperate;
import com.publiccms.entities.sys.SysEmailToken;
import com.publiccms.entities.sys.SysSite;
import com.publiccms.entities.sys.SysUser;
import com.publiccms.entities.sys.SysUserToken;
import com.publiccms.logic.component.config.ConfigComponent;
import com.publiccms.logic.component.config.EmailTemplateConfigComponent;
import com.publiccms.logic.component.site.EmailComponent;
import com.publiccms.logic.component.template.TemplateComponent;
import com.publiccms.logic.service.log.LogLoginService;
import com.publiccms.logic.service.sys.SysEmailTokenService;
import com.publiccms.logic.service.sys.SysUserService;
import com.publiccms.logic.service.sys.SysUserTokenService;

import freemarker.template.TemplateException;

/**
 * 
 * UserController 用户逻辑处理
 *
 */
@Controller
@RequestMapping("user")
public class UserController extends AbstractController {
    @Autowired
    private SysUserService service;
    @Autowired
    private SysUserTokenService sysUserTokenService;
    @Autowired
    private EmailComponent emailComponent;
    @Autowired
    private TemplateComponent templateComponent;
    @Autowired
    private SysEmailTokenService sysEmailTokenService;
    @Autowired
    private ConfigComponent configComponent;

    /**
     * @param oldpassword
     * @param password
     * @param repassword
     * @param returnUrl
     * @param _csrf
     * @param request
     * @param session
     * @param response
     * @param model
     * @return view name
     */
    @RequestMapping(value = "changePassword", method = RequestMethod.POST)
    public String changePassword(String oldpassword, String password, String repassword, String returnUrl, String _csrf,
            HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model) {
        SysSite site = getSite(request);
        if (CommonUtils.empty(returnUrl)) {
            returnUrl = site.getDynamicPath();
        }
        SysUser user = ControllerUtils.getUserFromSession(session);
        if (ControllerUtils.verifyNotEquals("_csrf", ControllerUtils.getWebToken(request), _csrf, model)
                || ControllerUtils.verifyNotEmpty("user", user, model)
                || ControllerUtils.verifyNotEmpty("password", password, model)
                || ControllerUtils.verifyNotEquals("repassword", password, repassword, model) || ControllerUtils
                        .verifyNotEquals("password", user.getPassword(), VerificationUtils.md5Encode(oldpassword), model)) {
            return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
        } else {
            Cookie userCookie = RequestUtils.getCookie(request.getCookies(), CommonConstants.getCookiesUser());
            if (null != userCookie && CommonUtils.notEmpty(userCookie.getValue())) {
                String value = userCookie.getValue();
                if (null != value) {
                    String[] userData = value.split(CommonConstants.getCookiesUserSplit());
                    if (userData.length > 1) {
                        sysUserTokenService.delete(userData[1]);
                    }
                }
            }
            ControllerUtils.clearUserToSession(request.getContextPath(), session, response);
            service.updatePassword(user.getId(), VerificationUtils.md5Encode(password));
            model.addAttribute(CommonConstants.MESSAGE, CommonConstants.SUCCESS);
            logOperateService.save(new LogOperate(site.getId(), user.getId(), LogLoginService.CHANNEL_WEB, "changepassword",
                    RequestUtils.getIpAddress(request), CommonUtils.getDate(), user.getPassword()));
            return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
        }
    }

    /**
     * @param email
     * @param returnUrl
     * @param _csrf
     * @param request
     * @param session
     * @param response
     * @param model
     * @return view name
     */
    @RequestMapping(value = "saveEmail", method = RequestMethod.POST)
    public String saveEmail(String email, String returnUrl, String _csrf, HttpServletRequest request, HttpSession session,
            HttpServletResponse response, ModelMap model) {
        SysSite site = getSite(request);
        if (CommonUtils.empty(returnUrl)) {
            returnUrl = site.getDynamicPath();
        }
        Map<String, String> config = configComponent.getConfigData(site.getId(), EmailComponent.CONFIG_CODE);
        String emailTitle = config.get(EmailTemplateConfigComponent.CONFIG_EMAIL_TITLE);
        String emailPath = config.get(EmailTemplateConfigComponent.CONFIG_EMAIL_PATH);
        SysUser user = ControllerUtils.getUserFromSession(session);
        if (ControllerUtils.verifyNotEquals("_csrf", ControllerUtils.getWebToken(request), _csrf, model)
                || ControllerUtils.verifyNotEmpty("user", user, model) || ControllerUtils.verifyNotEmpty("email", email, model)
                || ControllerUtils.verifyNotEmpty("email.config", emailTitle, model)
                || ControllerUtils.verifyNotEmpty("email.config", emailPath, model)
                || ControllerUtils.verifyNotEMail("email", email, model)
                || ControllerUtils.verifyHasExist("email", service.findByEmail(site.getId(), email), model)) {
            return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
        } else {
            SysEmailToken sysEmailToken = new SysEmailToken();
            sysEmailToken.setUserId(user.getId());
            sysEmailToken.setAuthToken(UUID.randomUUID().toString());
            sysEmailToken.setEmail(email);
            sysEmailTokenService.save(sysEmailToken);
            try {
                Map<String, Object> emailModel = new HashMap<>();
                emailModel.put("user", user);
                emailModel.put("site", site);
                emailModel.put("email", email);
                emailModel.put("authToken", sysEmailToken.getAuthToken());
                if (emailComponent.sendHtml(site.getId(), email,
                        FreeMarkerUtils.generateStringByString(emailTitle, templateComponent.getWebConfiguration(), emailModel),
                        FreeMarkerUtils.generateStringByFile(siteComponent.getWebTemplateFilePath(site, emailPath),
                                templateComponent.getWebConfiguration(), emailModel))) {
                    model.addAttribute(CommonConstants.MESSAGE, "sendEmail.success");
                } else {
                    model.addAttribute(CommonConstants.MESSAGE, "sendEmail.error");
                }
            } catch (IOException | TemplateException | MessagingException e) {
                model.addAttribute(CommonConstants.ERROR, "sendEmail.error");
            }
            return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
        }
    }

    /**
     * @param authToken
     * @param returnUrl
     * @param request
     * @param session
     * @param response
     * @param model
     * @return view name
     */
    @RequestMapping(value = "verifyEmail", method = RequestMethod.POST)
    public String verifyEmail(String authToken, String returnUrl, HttpServletRequest request, HttpSession session,
            HttpServletResponse response, ModelMap model) {
        SysSite site = getSite(request);
        if (CommonUtils.empty(returnUrl)) {
            returnUrl = site.getDynamicPath();
        }
        SysEmailToken sysEmailToken = sysEmailTokenService.getEntity(authToken);
        if (ControllerUtils.verifyNotEmpty("verifyEmail.authToken", authToken, model)
                || ControllerUtils.verifyNotExist("verifyEmail.sysEmailToken", sysEmailToken, model)) {
            return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
        } else {
            sysEmailTokenService.delete(sysEmailToken.getAuthToken());
            service.checked(sysEmailToken.getUserId(), sysEmailToken.getEmail());
            ControllerUtils.clearUserTimeToSession(session);
            model.addAttribute(CommonConstants.MESSAGE, "verifyEmail.success");
            return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
        }
    }

    /**
     * @param authToken
     * @param returnUrl
     * @param request
     * @param session
     * @param model
     * @return view name
     */
    @RequestMapping(value = "deleteToken", method = RequestMethod.POST)
    public String deleteToken(String authToken, String returnUrl, HttpServletRequest request, HttpSession session,
            ModelMap model) {
        SysSite site = getSite(request);
        if (CommonUtils.empty(returnUrl)) {
            returnUrl = site.getDynamicPath();
        }
        SysUserToken entity = sysUserTokenService.getEntity(authToken);
        Long userId = ControllerUtils.getAdminFromSession(session).getId();
        if (null != entity) {
            if (ControllerUtils.verifyNotEquals("userId", userId, entity.getUserId(), model)) {
                return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
            }
            sysUserTokenService.delete(authToken);
        }
        return UrlBasedViewResolver.REDIRECT_URL_PREFIX + returnUrl;
    }
}
