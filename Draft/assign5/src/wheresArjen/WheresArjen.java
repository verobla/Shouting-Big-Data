package wheresArjen;

import java.util.regex.Pattern;
import java.io.IOException;
import org.apache.pig.FilterFunc;
import org.apache.pig.data.Tuple;


public class WheresArjen extends FilterFunc {


	public Boolean exec(Tuple input) throws IOException {
		if (input == null || input.size() == 0)
			return Boolean.valueOf(false);
		try{
			String str = input.toString();
			return Boolean.valueOf(Pattern.compile(Pattern.quote("Arjen Robben"), Pattern.CASE_INSENSITIVE).matcher(str).find());
        }catch(Exception e){
			throw new IOException("Caught exception processing input row "+e.toString(), e);
       }
	}
}

