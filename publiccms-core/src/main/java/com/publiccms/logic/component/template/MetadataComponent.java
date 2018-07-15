package com.publiccms.logic.component.template;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.publiccms.common.api.Cache;
import com.publiccms.common.cache.CacheEntity;
import com.publiccms.common.cache.CacheEntityFactory;
import com.publiccms.common.constants.CommonConstants;
import com.publiccms.common.tools.CommonUtils;
import com.publiccms.views.pojo.entities.CmsPageMetadata;
import com.publiccms.views.pojo.entities.CmsPlaceMetadata;

/**
 * 元数据组件
 *
 * MetaData Component
 *
 */
@Component
public class MetadataComponent implements Cache {
    /**
     *
     */
    public static final String METADATA_FILE = "metadata.data";

    private CacheEntity<String, Map<String, CmsPageMetadata>> pageCache;
    private CacheEntity<String, Map<String, CmsPlaceMetadata>> placeCache;

    /**
     * 获取推荐位元数据
     *
     * @param filePath
     * @return place metadata
     */
    public CmsPlaceMetadata getPlaceMetadata(String filePath) {
        File file = new File(filePath);
        CmsPlaceMetadata pageMetadata = getPlaceMetadataMap(file.getParent()).get(file.getName());
        if (null != pageMetadata) {
            return pageMetadata;
        }
        return new CmsPlaceMetadata();
    }

    /**
     * 获取模板元数据
     *
     * @param filePath
     * @return template metadata
     */
    public CmsPageMetadata getTemplateMetadata(String filePath) {
        File file = new File(filePath);
        CmsPageMetadata pageMetadata = getTemplateMetadataMap(file.getParent()).get(file.getName());
        if (null == pageMetadata) {
            pageMetadata = new CmsPageMetadata();
            pageMetadata.setUseDynamic(true);
        }
        return pageMetadata;
    }

    /**
     * 更新模板元数据
     *
     * @param filePath
     * @param metadata
     * @return whether the update is successful
     */
    public boolean updateTemplateMetadata(String filePath, CmsPageMetadata metadata) {
        File file = new File(filePath);
        String dirPath = file.getParent();
        Map<String, CmsPageMetadata> metadataMap = getTemplateMetadataMap(dirPath);
        metadataMap.put(file.getName(), metadata);
        try {
            saveTemplateMetadata(dirPath, metadataMap);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    /**
     * 更新推荐位元数据
     *
     * @param filePath
     * @param metadata
     * @return whether the update is successful
     */
    public boolean updatePlaceMetadata(String filePath, CmsPlaceMetadata metadata) {
        File file = new File(filePath);
        String dirPath = file.getParent();
        Map<String, CmsPlaceMetadata> metadataMap = getPlaceMetadataMap(dirPath);
        metadataMap.put(file.getName(), metadata);
        try {
            savePlaceMetadata(dirPath, metadataMap);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    /**
     * 删除模板元数据
     *
     * @param filePath
     * @return whether the delete is successful
     */
    public boolean deleteTemplateMetadata(String filePath) {
        File file = new File(filePath);
        String dirPath = file.getParent();
        Map<String, CmsPageMetadata> metadataMap = getTemplateMetadataMap(dirPath);
        metadataMap.remove(file.getName());
        try {
            saveTemplateMetadata(dirPath, metadataMap);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    /**
     * 删除推荐位元数据
     *
     * @param filePath
     * @return whether the delete is successful
     */
    public boolean deletePlaceMetadata(String filePath) {
        File file = new File(filePath);
        String dirPath = file.getParent();
        Map<String, CmsPlaceMetadata> metadataMap = getPlaceMetadataMap(dirPath);
        metadataMap.remove(file.getName());
        try {
            savePlaceMetadata(dirPath, metadataMap);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    /**
     * 获取目录元数据
     *
     * @param dirPath
     * @return place metadata map
     */
    private Map<String, CmsPlaceMetadata> getPlaceMetadataMap(String dirPath) {
        Map<String, CmsPlaceMetadata> metadataMap = placeCache.get(dirPath);
        if (null == metadataMap) {
            File file = new File(dirPath + CommonConstants.SEPARATOR + METADATA_FILE);
            if (CommonUtils.notEmpty(file)) {
                try {
                    metadataMap = CommonConstants.objectMapper.readValue(file, new TypeReference<Map<String, CmsPlaceMetadata>>() {
                    });
                } catch (IOException | ClassCastException e) {
                    metadataMap = new HashMap<>();
                }
            } else {
                metadataMap = new HashMap<>();
            }
            placeCache.put(dirPath, metadataMap);
        }
        return metadataMap;
    }

    /**
     * 获取目录元数据
     *
     * @param dirPath
     * @return template metadata map
     */
    private Map<String, CmsPageMetadata> getTemplateMetadataMap(String dirPath) {
        Map<String, CmsPageMetadata> metadataMap = pageCache.get(dirPath);
        if (null == metadataMap) {
            File file = new File(dirPath + CommonConstants.SEPARATOR + METADATA_FILE);
            if (CommonUtils.notEmpty(file)) {
                try {
                    metadataMap = CommonConstants.objectMapper.readValue(file, new TypeReference<Map<String, CmsPageMetadata>>() {
                    });
                } catch (IOException | ClassCastException e) {
                    metadataMap = new HashMap<>();
                }
            } else {
                metadataMap = new HashMap<>();
            }
            pageCache.put(dirPath, metadataMap);
        }
        return metadataMap;
    }

    /**
     * 保存模板元数据
     *
     * @param dirPath
     * @param metadataMap
     * @throws JsonGenerationException
     * @throws JsonMappingException
     * @throws IOException
     */
    private void saveTemplateMetadata(String dirPath, Map<String, CmsPageMetadata> metadataMap)
            throws JsonGenerationException, JsonMappingException, IOException {
        File file = new File(dirPath + CommonConstants.SEPARATOR + METADATA_FILE);
        if (CommonUtils.empty(file)) {
            file.getParentFile().mkdirs();
        }
        try (FileOutputStream outputStream = new FileOutputStream(file);) {
            CommonConstants.objectMapper.writeValue(file, metadataMap);
        }
        pageCache.clear();
    }

    /**
     * 保存推荐位元数据
     *
     * @param dirPath
     * @param metadataMap
     * @throws JsonGenerationException
     * @throws JsonMappingException
     * @throws IOException
     */
    private void savePlaceMetadata(String dirPath, Map<String, CmsPlaceMetadata> metadataMap)
            throws JsonGenerationException, JsonMappingException, IOException {
        File file = new File(dirPath + CommonConstants.SEPARATOR + METADATA_FILE);
        if (CommonUtils.empty(file)) {
            file.getParentFile().mkdirs();
        }
        CommonConstants.objectMapper.writeValue(file, metadataMap);
        placeCache.clear();
    }

    @Override
    public void clear() {
        placeCache.clear();
        pageCache.clear();
    }

    /**
     * @param cacheEntityFactory
     * @throws IllegalAccessException
     * @throws InstantiationException
     * @throws ClassNotFoundException
     */
    @Autowired
    public void initCache(CacheEntityFactory cacheEntityFactory)
            throws ClassNotFoundException, InstantiationException, IllegalAccessException {
        pageCache = cacheEntityFactory.createCacheEntity("pageMetadata");
        placeCache = cacheEntityFactory.createCacheEntity("placeMetadata");
    }
}
