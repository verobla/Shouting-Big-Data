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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

import org.json.simple.parser.JSONParser;


public class ShoutingExtactor {

    public static final String[] exceptionWords = {
            "FIFA",
            "RT",
            "AUSTRALIA",
            "IRAN",
            "JAPAN",
            "SOUTH KOREA",
            "ALGERIA",
            "CAMEROON",
            "GHANA",
            "CÔTE", "D'IVOIRE",
            "NIGERIA",
            "COSTA", "RICA",
            "HONDURAS",
            "MEXICO",
            "USA",
            "ARGENTINA",
            //"BRAZIL",
            "CHILE",
            "COLOMBIA",
            "ECUADOR",
            "URUGUAY",
            "BELGIUM",
            "BOSNIA", "AND", "HERZEGOVINA",
            "CROATIA",
            "ENGLAND",
            "FRANCE",
            //"GERMANY",
            "GREECE",
            "ITALY",
            //"NETHERLANDS",
            "PORTUGAL",
            "RUSSIA",
            "SPAIN",
            "SWITZERLAND",
            "ESPN",
            "FC",
            "RETWEET",
            "BBC",
            "IS",
            "THE",
            "AT",
            "IN"
    };
    private static final int MINIMUM_LENGTH = 2;

    public static class ShoutingMapper
            extends Mapper<Object, Text, Text, Text>{


        private JSONParser parser = new JSONParser();
        private Map tweet;
        private String text;
        private List<String> shoutedWords;

        public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {
            try {
                tweet = (Map<String, Object>) parser.parse(value.toString());
            }
            catch (ClassCastException e) {
                return; // do nothing (we might log this)
            }
            catch (org.json.simple.parser.ParseException e) {
                return; // do nothing
            }
            text = ((String) tweet.get("text"));
            shoutedWords = grabShoutedWords( text);
            for (String shoutedWord : shoutedWords) {
                Text one = new Text( "1");
                Text shotedWordText = new Text( shoutedWord);
                context.write( shotedWordText, one);
            }

        }


    }

    public static List<String> grabShoutedWords(String text) {
        String[] words = text.split( " ");
        ArrayList<String> shoutingWords = new ArrayList<>();
        for (String word : words) {
            if( isUppercaseShouting( word))
                shoutingWords.add( word);
        }
        return shoutingWords;
    }

    public static class ShoutingReducer
            extends Reducer<Text, Text, Text, Text> {

        public void reduce(Text key, Iterable<Text> values,
                           Context context
        ) throws IOException, InterruptedException {
            int count = 0;
            for (Text value : values) {
                int addition = Integer.parseInt( value.toString() );
                count += addition;
            }
            Text countText = new Text( count + "" );
            context.write( key,countText);
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length < 2) {
            System.err.println("Usage: exampleTwitter <in> [<in>...] <out>");
            System.exit(2);
        }
        Job job = new Job(conf, "Extract Shouting Words");
        job.setJarByClass(ShoutingExtactor.class);
        job.setMapperClass(ShoutingMapper.class);
        job.setReducerClass(ShoutingReducer.class);
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
            if( !isExceptional( word) && word.length() >= MINIMUM_LENGTH  ){
                return word.matches( "[\\p{Lu}]+");
            }
        }
        return false;
    }

    public static boolean isShouting(String text){
        return isUppercaseShouting(text) || text.contains( "!") || text.contains(":@");
    }

    public static boolean isExceptional(String word) {
        for (String exceptionWord : exceptionWords) {
            if( word.equals(exceptionWord)){
                return true;
            }
        }
        return false;

    }
}
