package com.ec.survey.tools;

import java.util.Date;
import org.springframework.stereotype.Component;
import tools.jackson.core.JsonGenerator;
import tools.jackson.databind.SerializationContext;
import tools.jackson.databind.ValueSerializer;

@Component
public class JsonDateSerializer extends ValueSerializer<Date> { // Use ValueSerializer
    @Override
    public void serialize(Date date, JsonGenerator gen, SerializationContext provider) {
        String formattedDate = Tools.formatDate(date, "MM/dd/yyyy HH:mm"); // ISO 8601 (based on your comment)
        gen.writeString(formattedDate);
    }
}
