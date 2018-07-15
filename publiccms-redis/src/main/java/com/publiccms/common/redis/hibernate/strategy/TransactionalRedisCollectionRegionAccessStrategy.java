package com.publiccms.common.redis.hibernate.strategy;

import org.hibernate.boot.spi.SessionFactoryOptions;
import org.hibernate.cache.internal.DefaultCacheKeysFactory;
import org.hibernate.cache.spi.CollectionRegion;
import org.hibernate.cache.spi.access.CollectionRegionAccessStrategy;
import org.hibernate.cache.spi.access.SoftLock;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.persister.collection.CollectionPersister;

import com.publiccms.common.redis.DatabaseRedisClient;
import com.publiccms.common.redis.hibernate.regions.RedisCollectionRegion;

/**
 *
 * TransactionalRedisCollectionRegionAccessStrategy
 * 
 */
public class TransactionalRedisCollectionRegionAccessStrategy extends AbstractRedisAccessStrategy<RedisCollectionRegion>
        implements CollectionRegionAccessStrategy {

    private final DatabaseRedisClient redisClient;

    /**
     * @param region
     * @param options
     */
    public TransactionalRedisCollectionRegionAccessStrategy(RedisCollectionRegion region, SessionFactoryOptions options) {
        super(region, options);
        this.redisClient = region.getRedisClient();
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
    public SoftLock lockItem(SessionImplementor session, Object key, Object version) {
        region.remove(key);
        return null;
    }

    @Override
    public void unlockItem(SessionImplementor session, Object key, SoftLock lock) {
        region.remove(key);
    }

    @Override
    public void remove(SessionImplementor session, Object key) {
        region.remove(key);
    }

    /**
     * @return
     */
    public DatabaseRedisClient getRedisClient() {
        return redisClient;
    }
}
