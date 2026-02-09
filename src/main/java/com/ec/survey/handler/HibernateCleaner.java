package com.ec.survey.handler;

import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.proxy.HibernateProxy;

import java.beans.PropertyDescriptor;
import java.io.InputStream;
import java.sql.Blob;
import java.util.*;

public class HibernateCleaner {
    private static final Logger logger = LoggerFactory.getLogger(HibernateCleaner.class);

    public static Object clean(Session session, Object obj) throws Exception {
        return (clean(session, obj, new HashMap<>()));
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private static Object clean(Session session,
                                Object obj,
                                Map<Class, Map<Object, Object>> visitedObjects) throws Exception {

        if (obj == null) return null;

        // Basic types handling
        if ((obj instanceof Boolean) || (obj instanceof Number) || (obj.getClass().isEnum()) ||
                (obj instanceof Character) || (obj instanceof String) ||
                (obj instanceof Blob) || (obj instanceof InputStream))
            return obj;

        if (obj instanceof Date)
            return new Date(((Date) obj).getTime());

        if (obj instanceof Calendar)
            return ((Calendar) obj).clone();

        // Arrays handling
        if (obj instanceof Object[]) {
            Object[] array = ((Object[]) obj).clone();
            for (int i = 0; i < array.length; i++)
                array[i] = clean(session, array[i], visitedObjects);
            return array;
        }

        // Collection handling
        if (obj instanceof Collection) {
            Collection collection = createCollection((Collection) obj);
            if (Hibernate.isInitialized(obj)) {
                for (Object member : (Collection) obj)
                    collection.add(clean(session, member, visitedObjects));
            }
            return collection;
        }

        // Map handling
        if (obj instanceof Map) {
            Map map = createMap((Map) obj);
            if (Hibernate.isInitialized(obj)) {
                for (Object entryObj : ((Map) obj).entrySet()) {
                    Map.Entry entry = (Map.Entry) entryObj;
                    map.put(clean(session, entry.getKey(), visitedObjects),
                            clean(session, entry.getValue(), visitedObjects));
                }
            }
            return map;
        }

        // Proxy class resolution (HibernateProxyHelper removed in Hibernate 6)
        Class<?> clazz = (obj instanceof HibernateProxy)
                ? ((HibernateProxy) obj).getHibernateLazyInitializer().getPersistentClass()
                : obj.getClass();

        Map<Object, Object> visitedObjectsInClass = visitedObjects.computeIfAbsent(clazz, k -> new HashMap<>());
        if (visitedObjectsInClass.containsKey(obj)) {
            return visitedObjectsInClass.get(obj);
        }

        // Create new instance using modern reflection
        Object newObj = clazz.getDeclaredConstructor().newInstance();
        visitedObjectsInClass.put(obj, newObj);

        if (!Hibernate.isInitialized(obj)) {
            if (session != null) {
                // Replacement for ClassMetadata in Hibernate 6
                SessionImplementor sessionImpl = (SessionImplementor) session;
                Object id = sessionImpl.getPersistenceContextInternal().getEntry(obj).getId();

                // Set the ID back using the Metamodel
                String idPropertyName = sessionImpl.getSessionFactory()
                        .getRuntimeMetamodels()
                        .getMappingMetamodel()
                        .getEntityDescriptor(clazz.getName())
                        .getIdentifierPropertyName();

                PropertyUtils.setProperty(newObj, idPropertyName, id);
            }
        } else {
            PropertyDescriptor[] descriptors = PropertyUtils.getPropertyDescriptors(newObj);
            for (PropertyDescriptor descriptor : descriptors) {
                String property = descriptor.getName();
                if (!property.equals("class")) {
                    try {
                        Object value = PropertyUtils.getProperty(obj, property);
                        Object cleanValue = clean(session, value, visitedObjects);
                        PropertyUtils.setProperty(newObj, property, cleanValue);
                    } catch (NoSuchMethodException e) {
                        // Properties with no setter
                    } catch (Exception e) {
                        logger.error(e.getLocalizedMessage(), e);
                    }
                }
            }
        }

        return newObj;
    }

    @SuppressWarnings("rawtypes")
    private static Collection createCollection(Collection obj) {
        if (obj instanceof SortedSet) return new TreeSet();
        if (obj instanceof Set) return new HashSet();
        return new ArrayList();
    }

    @SuppressWarnings("rawtypes")
    private static Map createMap(Map obj) {
        if (obj instanceof SortedMap) return new TreeMap();
        return new HashMap();
    }
}
