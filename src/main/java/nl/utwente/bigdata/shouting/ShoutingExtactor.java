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

import nl.utwente.bigdata.shouting.util.MapReducers;
import nl.utwente.bigdata.shouting.util.ShoutingConstants;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;


/**
 * This program extracts the shouting words from json tweet data and counts them.
 * The output is unsorted.
 */
public class ShoutingExtactor {
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length < 2) {
            System.err.println("Usage: exampleTwitter <in> [<in>...] <out>");
            System.exit(2);
        }
        Job job = new Job(conf, "Extract Shouting Words");
        job.setJarByClass(ShoutingExtactor.class);
        job.setMapperClass(MapReducers.ShoutingWordsMapper.class);
        job.setCombinerClass(MapReducers.CounterReducer.class);
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

    public static boolean isUppercaseShouting(String str) {
        String[] words = str.split( " ");
        for (String word : words) {
            if( !isExceptional( word) && word.length() >= ShoutingConstants.MINIMUM_LENGTH  ){
                return word.matches( "[\\p{Lu}]+");
            }
        }
        return false;
    }

    public static boolean isShouting(String text){
        return isUppercaseShouting(text) || text.contains( "!") || text.contains(":@");
    }

    public static boolean isExceptional(String word) {
        for (String exceptionWord : ShoutingConstants.exceptionWords) {
            if( word.equals(exceptionWord)){
                return true;
            }
        }
        return false;
    }
}
