package nl.utwente.bigdata.shouting.util;

import nl.utwente.bigdata.shouting.ShoutingExtactor;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Partitioner;
import org.apache.hadoop.mapreduce.Reducer;
import org.json.simple.parser.JSONParser;

import java.io.IOException;
import java.security.DomainCombiner;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This class contains all map and reduce classes.
 * Created by BigDataShoutingGroup on 1/13/15.
 */
public class MapReducers {
    public static int INFINITY = 999999999;

    /**
     * Mapper to generate the PigTable of shouts
     * @author BigDataShoutingGroup
     *
     */
    public static class PigTableMapper
            extends Mapper<Object, Text, Text, Text> {

    	// Data to gather from shout
        private Text idString = new Text();
        private Text contents = new Text();
        private String tweetText;
        private String isShoutingText;
        private String date;
        private String tweetLanguage;
        private String device;
        
        // JSON parser and actual tweet
        private JSONParser parser = new JSONParser();
        private Map tweet;

        // Mapping process
        public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {

            try {
                tweet = (Map<String, Object>) parser.parse(value.toString());
            } catch (ClassCastException | org.json.simple.parser.ParseException e) {
                return; // do nothing (we might log this)
            }

            // Grab data from tweet
            idString.set((String) tweet.get("id_str"));
            tweetText = ((String) tweet.get("text")).replaceAll("\n", " ").replaceAll("\t", " ");
            date = (String) tweet.get("created_at");
            tweetLanguage = (String) tweet.get("lang");
            device = (String) tweet.get("source");

            // If the tweet is identified as a shout, write the tweet to the reducer
            if (ShoutingExtactor.isShouting(tweetText)) {
                isShoutingText = "true";
                device = stripSourceName(device);
                contents.set(tweetLanguage + "\t" + date + "\t" + device + "\t" + tweetText);
                context.write(idString, contents);
            }
        }

        /**
         * Method to strip the device name out of the full string with HTML data
         */
        private String stripSourceName(String device) {
            try {
                return device.substring(device.indexOf('>') + 1, device.lastIndexOf('<')).replace( "\\s" , " ");
            } catch (Exception e) {
                return "Exceptional Device";
            }
        }
    }

    /**
     * Reducer which has not an actual job except writing the shouted tweets down
     * @author BigDataShoutingGroup
     *
     */
    public static class PigTableReducer
            extends Reducer<Text, Text, Text, Text> {

        public void reduce(Text key, Iterable<Text> values,
                           Context context
        ) throws IOException, InterruptedException {
            for (Text value : values) {
                context.write(key, value);
            }
        }
    }

    /**
     * This MapReduce job is built to count the most shouted words
     * 
     * The mapper here collects the shouted words from a tweet and adds a 1 counter to it
     * @author BigDataShoutingGroup
     *
     */
    public static class ShoutingWordsMapper
            extends Mapper<Object, Text, Text, Text> {


        private JSONParser parser = new JSONParser();
        private Map tweet;
        private String text;
        private List<String> shoutedWords;

        public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {
            try {
                tweet = (Map<String, Object>) parser.parse(value.toString());
            } catch (ClassCastException | org.json.simple.parser.ParseException e) {
                return; // do nothing (we might log this)
            }
            text = ((String) tweet.get("text"));
            shoutedWords = grabShoutedWords(text);
            for (String shoutedWord : shoutedWords) {
                Text one = new Text("1");

                shoutedWord = getCommonShoutingWord(shoutedWord);
                Text shotedWordText = new Text(shoutedWord);

                context.write(shotedWordText, one);
            }

        }
    }

    /**
     * This mapper is meant to count all non shouting words
     * @author BigDataShoutingGroup
     *
     */
    public static class NonShoutingWordsMapper
            extends Mapper<Object, Text, Text, Text> {


        private JSONParser parser = new JSONParser();
        private Map tweet;
        private String text;
        private List<String> nonShoutedWords;

        public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {
            try {
                tweet = (Map<String, Object>) parser.parse(value.toString());
            } catch (ClassCastException | org.json.simple.parser.ParseException e) {
                return; // do nothing (we might log this)
            }
            text = ((String) tweet.get("text"));
            nonShoutedWords = grabNonShoutedWords(text);

            for (String shoutedWord : nonShoutedWords) {
                Text one = new Text("1");

                shoutedWord = getCommonShoutingWord(shoutedWord);
                Text shotedWordText = new Text(shoutedWord);

                context.write(shotedWordText, one);
            }

        }
    }

    /**
     * This reducer allows counting the most shouted words
     * @author BigDataShoutingGroup
     *
     */
    public static class CounterReducer
            extends Reducer<Text, Text, Text, Text> {

        public void reduce(Text key, Iterable<Text> values,
                           Context context
        ) throws IOException, InterruptedException {
            long count = 0;
            for (Text value : values) {
                long addition = Long.parseLong(value.toString());
                count += addition;
            }
            Text countText = new Text(count + "");
            context.write(key, countText);
        }
    }


    /**
     * The goal of this mapper is to sort data by value
     * The sorter mapper splits the read data by spaces and splits it up in the following parts
     * "count","data"
     * @author BigDataShoutingGroup
     *
     */
    public static class SorterMapper
            extends Mapper<Object, Text, Text, Text> {

        public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {
            String[] words = value.toString().split("\\s");
            String leadingZeroes = String.format("%08d", INFINITY - Integer.parseInt(words[1]));
            context.write(new Text(leadingZeroes), new Text(words[0]));
        }
    }

    /**
     * The SorterReducer writes the sorted values
     * @author BigDataShoutingGroup
     *
     */
    public static class SorterReducer
            extends Reducer<Text, Text, Text, Text> {

        public void reduce(Text key, Iterable<Text> values,
                           Context context
        ) throws IOException, InterruptedException {
            for (Text value : values) {
                context.write(value, new Text("" + (INFINITY - Integer.parseInt(key.toString()))));
            }
        }
    }

    /**
     * The petitioner makes sure the data arrives in chunks or so called "partitions"
     * to ensure the data arrives more or less in an order
     * @author BigDataShoutingGroup
     *
     */
    public static class SorterPartitioner
            extends Partitioner<Text, Text> {

        @Override
        public int getPartition(Text key, Text value, int partitionCount) {
            int number = Integer.parseInt(key.toString());
            int leap = INFINITY / partitionCount;
            int threshold = 0;
            int partition = 0;
            while (partition < partitionCount) {
                if (number <= threshold + leap) {
                    return partition;
                }
                partition++;
                threshold += leap;
            }
            return partitionCount - 1;
        }
    }

    /**
     * This mapper is used to count all the words and it splits the words to the categories of shouting and non shouting
     * @author BigDataShoutingGroup
     *
     */
    public static class DistinctShoutingCountMapper extends Mapper<Object, Text, Text, Text> {
        private String text;

        public void map(Object key, Text value, Mapper.Context context
        ) throws InterruptedException, IOException {

            text = value.toString();
            System.err.println(text);
            String[] words = text.split("\\s");
            Text count;
            Text keyText;
            try {
                count = new Text(words[1]);

                if (ShoutingExtactor.isUppercaseShouting(words[0])) {
                    keyText = new Text("Shout");
                } else {
                    keyText = new Text("Not Shout");
                }

                context.write(keyText, count);
            } catch (ArrayIndexOutOfBoundsException e) {
                keyText = new Text("Exception");
                count = new Text("1");
                context.write(keyText, count);
            }

        }
    }

    private static List<String> grabNonShoutedWords(String text) {
        String[] words = text.split(" ");
        ArrayList<String> shoutingWords = new ArrayList<>();
        for (String word : words) {
            if (!ShoutingExtactor.isUppercaseShouting(word))
                shoutingWords.add(word);
        }
        return shoutingWords;
    }

    private static String getCommonShoutingWord(String shoutedWord) {
        if (shoutedWord.matches("G+O+A*L+")) {
            return "GOAL";
        } else if (shoutedWord.matches("BRA[SZ]IL")) {
            return "BRASIL";
        } else {
            return shoutedWord;
        }
    }

    public static List<String> grabShoutedWords(String text) {
        String[] words = text.split(" ");
        ArrayList<String> shoutingWords = new ArrayList<>();
        for (String word : words) {
            if (ShoutingExtactor.isUppercaseShouting(word))
                shoutingWords.add(word);
        }
        return shoutingWords;
    }
}
