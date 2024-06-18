package ca.jrvs.apps.grep;

import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.List;
import java.io.File;


public interface JavaGrep {

    /**
     * Top level search workflow
     * @throws IOException
     */
    void process () throws IOExceptioln;

    /**
     * Traverse a given directory and return a list of all files
     * @param rootDir input directory
     * @return all files under rootDir
     * @throws IOException
     */
    List<File> listFiles (String rootDir) throws IOException;

    /**
     * Traverse a given file and return a list of all lines
     * @param inputFile input file
     * @return all lines in inputFile
     * @throws IllegalArgumentException if inputFile is not an actual file
     * @throws IOException if error while reading lines
     */
    List<String> readLines(File inputFile) throws IllegalArgumentException, IOException;

    /**
     * checks if a line contains the regex pattern passed by the user
     * @param line a String line in inputFile
     * @return true if it contains a pattern and no if not
     */
    boolean containsPatterns (String line);

    /**
     * Takes the list of lines that contains the pattern and write it into the OutFile
     * @param lines list of lines that contain the pattern
     * @throws IOException if write fails
     */
    void WriteToFile(List<String> lines) throws IOException;

    String getRootPath();

    void setRootPath(String rootPath);

    String getRegex();

    void setRegex(String regex);

    String getOutFile();
    void setOutFile(String outFile);

}
