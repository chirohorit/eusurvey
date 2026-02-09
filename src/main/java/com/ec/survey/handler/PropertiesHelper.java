package com.ec.survey.handler;

import com.ec.survey.model.survey.Survey;
import com.ec.survey.tools.Tools;

public class PropertiesHelper {

    public interface PropertyGetter {
        Object get(Survey survey);
    }

    public static boolean checkForPendingChanges(Survey a, Survey b, PropertyGetter... getters){
        for (PropertyGetter g : getters) {
            if (!Tools.isEqual(g.get(a), g.get(b))){
                return true;
            }
        }
        return false;
    }

}
