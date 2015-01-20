package nl.utwente.bigdata.shouting;

import nl.utwente.bigdata.shouting.util.MapReducers;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

/**
 * Created by BigDataShoutingGroup on 1/13/15.
 *
 * Expects input in the output format of ShoutingExtactor and NonShoutingExtactos
 */
public class WordCounter {
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length < 2) {
            System.err.println("Usage: exampleTwitter <in> [<in>...] <out>");
            System.exit(2);
        }
        Job job = new Job(conf, "Count All Words");
        job.setJarByClass(ShoutingExtactor.class);
        job.setMapperClass(MapReducers.DistinctShoutingCountMapper.class);
        job.setReducerClass( MapReducers.CounterReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        for (int i = 0; i < otherArgs.length - 1; ++i) {
            FileInputFormat.addInputPath(job, new Path(otherArgs[i]));
        }
        FileOutputFormat.setOutputPath(job,
                new Path(otherArgs[otherArgs.length - 1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
