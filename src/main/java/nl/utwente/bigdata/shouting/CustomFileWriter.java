package nl.utwente.bigdata.shouting;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;

public class CustomFileWriter {
	java.io.FileWriter fileWriter = null;
	BufferedWriter bufferedWriter = null;
	
    /**
     * Constructor
     * @param fileName
     */
    public CustomFileWriter(String fileName) {
        try {
        	File file = new File(fileName);
        	file.createNewFile();
        	fileWriter = new java.io.FileWriter(file);
        	bufferedWriter = new BufferedWriter(fileWriter);   // Write to the output.txt file
        }
        catch(Exception ex) {
            System.out.println("Error:" + ex);
        }
    }
    
    /**
     * Write to file
     * @param txt
     */
    public void write(String txt) {
    	try {
			bufferedWriter.write(txt);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * Close file
     */
    public void closeFile() {
    	try {
			bufferedWriter.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
