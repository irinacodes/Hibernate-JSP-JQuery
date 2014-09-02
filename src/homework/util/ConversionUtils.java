package homework.util;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ibranovic
 */
public class ConversionUtils {

    public static List<Integer> stringArrayToIntegerList(String[] stringArray) {
        List<Integer> integerList = new ArrayList<Integer>(stringArray.length);
        for (String s : stringArray) {
            integerList.add(Integer.valueOf(s));
        }
        return integerList;
    }
}
