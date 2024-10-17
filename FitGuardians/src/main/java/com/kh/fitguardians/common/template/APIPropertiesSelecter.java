package com.kh.fitguardians.common.template;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class APIPropertiesSelecter {
	
	public static Properties properties() throws IOException {
		Properties prop = new Properties();
		InputStream is = null;
		
		try {
			is = APIPropertiesSelecter.class.getResourceAsStream("/apiProperties.properties");
			if(is == null) {
	            throw new FileNotFoundException("Property 파일이 해당 클래스패스에 존재하지 않습니다!");
	        }
			prop.load(is);
		} finally {
			if(is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return prop;
	}
	
}
