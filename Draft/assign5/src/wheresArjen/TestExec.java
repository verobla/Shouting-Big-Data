package wheresArjen;

import static org.junit.Assert.*;

import java.io.IOException;

import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;
import org.junit.Test;

public class TestExec {
	
	private TupleFactory tupleFactory = TupleFactory.getInstance();

	@Test
	public void testExec() {
		
		WheresArjen arj = new WheresArjen();
		try {
			Tuple input=tupleFactory.newTuple(1);;
			input.set(0, "tzuifhscoarjEn rOBBenfgziqhospfo52687");
			assertEquals(true,arj.exec(input));
		} catch (ExecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
		
	}

}
