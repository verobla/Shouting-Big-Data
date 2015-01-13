package nl.utwente.bigdata.shouting;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mrunit.mapreduce.MapDriver;
import org.apache.hadoop.mrunit.mapreduce.MapReduceDriver;
import org.apache.hadoop.mrunit.mapreduce.ReduceDriver;
import org.apache.hadoop.mrunit.types.Pair;
import org.junit.Before;

import java.io.IOException;
import java.util.List;

/**
 * Created by saygindogu on 1/13/15.
 */
public class Test {
    private MapDriver<Object, Text, Text, Text> mapDriver;
    private ReduceDriver<Text, Text, Text, Text> reduceDriver;
    private MapReduceDriver<Object, Text, Text, Text, Text, Text> mapReduceDriver;

    @Before
    public void setUp() {
        Sorter.SorterMapper  mapper= new Sorter.SorterMapper();
        Sorter.SorterReducer  reducer= new Sorter.SorterReducer();
        mapDriver = MapDriver.newMapDriver(mapper);
        reduceDriver = ReduceDriver.newReduceDriver(reducer);
        mapReduceDriver = MapReduceDriver.newMapReduceDriver(mapper, reducer);
    }


    @org.junit.Test
    public void testMapper() throws IOException {
        Object key = new Object();
        Text value = new Text( "BOK 15");
        mapDriver.withInput(key, value);
        mapDriver.withOutput( new Text("15"), new Text( "BOK") );

        List<Pair<Text,Text>> outputs = mapDriver.run();
        for (Pair<Text, Text> textPair : outputs) {
            System.out.println( textPair.getFirst().toString() + ":" + textPair.getSecond().toString() );
        }

        //mapDriver.runTest();
    }

}
