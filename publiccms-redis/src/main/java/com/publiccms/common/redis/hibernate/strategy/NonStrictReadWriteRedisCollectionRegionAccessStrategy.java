package com.publiccms.common.redis.hibernate.strategy;

import org.hibernate.boot.spi.SessionFactoryOptions;
import org.hibernate.cache.CacheException;
import org.hibernate.cache.internal.DefaultCacheKeysFactory;
import org.hibernate.cache.spi.CollectionRegion;
import org.hibernate.cache.spi.access.CollectionRegionAccessStrategy;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.persister.collection.CollectionPersister;

import com.publiccms.common.redis.hibernate.regions.RedisCollectionRegion;

/**
 *
 * NonStrictReadWriteRedisCollectionRegionAccessStrategy
 * 
 */
public class NonStrictReadWriteRedisCollectionRegionAccessStrategy extends AbstractRedisAccessStrategy<RedisCollectionRegion>
        implements CollectionRegionAccessStrategy {

    /**
     * @param region
     * @param options
     */
    public NonStrictReadWriteRedisCollectionRegionAccessStrategy(RedisCollectionRegion region, SessionFactoryOptions options) {
        super(region, options);
    }

    @Override
    public Object generateCacheKey(Object id, CollectionPersister persister, SessionFactoryImplementor factory,
            String tenantIdentifier) {
        return DefaultCacheKeysFactory.staticCreateCollectionKey(id, persister, factory, tenantIdentifier);
    }

    @Override
    public Object getCacheKeyId(Object cacheKey) {
        return DefaultCacheKeysFactory.staticGetCollectionId(cacheKey);
    }

    @Override
    public CollectionRegion getRegion() {
        return region;
    }

    @Override
    public boolean putFromLoad(SessionImplementor session, Object key, Object value, long txTimestamp, Object version,
            boolean minimalPutOverride) {
        if (minimalPutOverride && region.contains(key)) {
            return false;
        }
        region.put(key, value);
        return true;
    }

    @Override
    public Object get(SessionImplementor session, Object key, long txTimestamp) throws CacheException {
        return region.get(key);
    }

}
