package homework.util;

import java.text.SimpleDateFormat;

/**
 *
 * @author ibranovic
 * metode za proveru parametara na serverskoj strani
 */
public class Validate {

    public static boolean exists(String param) {
        return (param != null && !param.isEmpty());
    }

    public static boolean isInteger(String param) {
        try {
            if (!exists(param)) {
                throw new Exception();
            } else {
                Integer.valueOf(param);
                return true;
            }
        } catch (Exception ex) {
            return false;
        }
    }

    public static boolean isDouble(String param) {
        try {
            if (!exists(param)) {
                throw new Exception();
            } else {
                Double.valueOf(param);
                return true;
            }
        } catch (Exception ex) {
            return false;
        }
    }
    
    private static boolean isDateTime(String param, String format) {
        int formatLength = format.length();
        try {
            if (!exists(param) || param.length() != formatLength) {
                throw new Exception();
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat(format);
                sdf.setLenient(false);
                sdf.parse(param);
                return true;
            }
        } catch (Exception ex) {
            return false;
        } 
    }

    public static boolean isDate(String date) {
       return isDateTime(date, "dd.MM.yyyy");        
    }
    
    public static boolean isTime(String time) {
      return isDateTime(time, "HH:mm"); 
    }
}
