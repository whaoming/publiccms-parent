package com.publiccms.common.database;

import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import com.publiccms.common.base.AbstractCmsUpgrader;
import com.publiccms.common.constants.CmsVersion;
import com.publiccms.common.tools.CommonUtils;

/**
 *
 * CmsUpgrader
 *
 */
public class CmsUpgrader extends AbstractCmsUpgrader {

    /**
     * 主键策略
     */
    public static final String IDENTIFIER_GENERATOR = IDENTIFIER_GENERATOR_IDENTITY;
    /**
     *
     */
    private final static String VERSION_20170318 = "V2017.0318", VERSION_20170520 = "V2017.0520", VERSION_20170708 = "V2017.0708",
            VERSION_20180210 = "V4.0.20180210";
    /**
     *
     */
    private final static List<String> VERSION_LIST = Arrays
            .asList(new String[] { VERSION_20170318, VERSION_20170520, VERSION_20170708, VERSION_20180210 });

    public CmsUpgrader(Properties config) {
        super(config);
    }

    /**
     * @throws SQLException
     * @throws IOException
     */
    @Override
    public void update(Connection connection, String fromVersion) throws SQLException, IOException {
        switch (fromVersion) {
        case VERSION_20170318:
            runScript(connection, VERSION_20170318, VERSION_20170520);
        case VERSION_20170520:
            runScript(connection, VERSION_20170520, VERSION_20170708);
        case VERSION_20170708:
            runScript(connection, VERSION_20170708, VERSION_20180210);
        case VERSION_20180210:
            runScript(connection, VERSION_20180210, CmsVersion.getVersion());
            break;
        }
    }

    @Override
    public void setDataBaseUrl(Properties dbconfig, String host, String port, String database)
            throws IOException, URISyntaxException {
        StringBuilder sb = new StringBuilder();
        sb.append("jdbc:mysql://");
        sb.append(host);
        if (CommonUtils.notEmpty(port) && !"3306".equals(port)) {
            sb.append(":");
            sb.append(port);
        }
        sb.append("/");
        sb.append(database);
        sb.append("?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=round&useSSL=false");
        dbconfig.setProperty("jdbc.url", sb.toString());
        dbconfig.setProperty("jdbc.driverClassName", "com.mysql.jdbc.Driver");
    }

    @Override
    public List<String> getVersionList() {
        return VERSION_LIST;
    }

    @Override
    public int getDefaultPort() {
        return 3306;
    }
}
