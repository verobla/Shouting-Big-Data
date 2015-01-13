package nl.utwente.bigdata.shouting;

/**
 * Created by Saygin on 11.1.2015.
 */
public class Testclass {
    public static void main(String[] args) {
        System.out.println( stripSourceName("<a href=\\\"https://about.twitter.com/products/tweetdeck\\\" rel=\\\"nofollow\\\">TweetDeck<\\/a>"));
        System.out.print( isUppercaseShouting( "ЭТo ЗДОРОВО!") );
    }
    private static String stripSourceName(String device) {
        try{
            return device.substring( device.indexOf( '>')+1, device.lastIndexOf( '<') );
        }
        catch ( Exception e){
            return  "empty";
        }

    }
    private static boolean isUppercaseShouting(String str) {
        String[] words = str.split( " ");
        for (String word : words) {
            if( true )  {
                return word.matches( "[\\p{Lu}]+");
            }
        }
        return false;
    }
}
