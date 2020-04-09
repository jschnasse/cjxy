package org.schnasse.cjxy.reader.base;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonReader {
	static public Map<String, Object> getMap(InputStream in) {
		try {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> map = mapper.readValue(in, HashMap.class);
			return map;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
