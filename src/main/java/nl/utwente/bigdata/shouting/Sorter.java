/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package nl.utwente.bigdata.shouting;

import java.io.*;
import java.util.Map;
import java.util.logging.Logger;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Partitioner;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

import org.json.simple.parser.JSONParser;


public class Sorter {

    public static Logger logger = Logger.getLogger( Sorter.class.getName());
    public static int INFINITY = 800000;

    public static class SorterMapper
            extends Mapper<Object, Text, Text, Text>{

        public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {
            String[] words = value.toString().split("\\s");
            String leadingZeroes = String.format("%05d", INFINITY - Integer.parseInt( words[1]));
            context.write( new Text( leadingZeroes ), new Text( words[0]) );
        }
    }

    public static class SorterReducer
            extends Reducer<Text, Text, Text, Text> {

        public void reduce(Text key, Iterable<Text> values,
                           Context context
        ) throws IOException, InterruptedException {
            for (Text value : values) {
                context.write( value, new Text( "" + (INFINITY - Integer.parseInt(key.toString()))));
            }
        }
    }

    public static class SorterPartitioner
        extends Partitioner<Text, Text>{

        @Override
        public int getPartition(Text key, Text value, int partitionCount) {
            return Integer.parseInt( key.toString()) % partitionCount;
        }
    }

    public static void main(String[] args) throws Exception {
        System.out.println( "Sorting YOLO..mhgnvn. ");
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length < 2) {
            System.err.println("Usage: exampleTwitter <in> [<in>...] <out>");
            System.exit(2);
        }
        Job job = new Job(conf, "Sorter");
        job.setJarByClass(Sorter.class);
        job.setMapperClass(SorterMapper.class);
        job.setReducerClass(SorterReducer.class);
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
