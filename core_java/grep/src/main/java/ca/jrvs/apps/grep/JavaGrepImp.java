package ca.jrvs.apps.grep;


import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;
import java.io.File;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import static java.util.Collections.addAll;

public class JavaGrepImp implements JavaGrep {

    private static final Logger logger= LoggerFactory.getLogger(JavaGrep.class);
    private String regex;
    private String rootPath;
    private String outFile;

    public static void main(String[] args) {
        if (args.length!=3 )
        {
            throw new IllegalArgumentException("USAGE: JavaGrep regex RootPath outFile");
        }

        JavaGrepImp javagrepImp = new JavaGrepImp();
        javagrepImp.setRegex(args[0]);
        javagrepImp.setRootPath(args[1]);
        javagrepImp.setOutFile(args[2]);

        try
        {
            javagrepImp.process();
        }
        catch (Exception e) {
            JavaGrepImp.logger.error("Error: Unable to process", e);
        }

    }

    @Override
    public void setRegex(String regex) {
        this.regex = regex;
    }

    @Override
    public void setRootPath(String rootPath) {
        this.rootPath = rootPath;
    }

    @Override
    public void setOutFile(String outFile) {
        this.outFile = outFile;
    }

    @Override
    public String getRegex() {
        return regex;
    }

    @Override
    public String getRootPath() {
        return rootPath;
    }

    @Override
    public String getOutFile() {
        return outFile;
    }


    public Logger getLogger() {
        return logger;
    }



    @Override
    public void process() throws IOException {


        List<String> matchedLines=new ArrayList<>();
        List<File> filesList = listFiles(rootPath);
        for (File file:filesList)
        {
            List<String>fileLines=readLines(file);
            for (String line : fileLines)
            {
                if (containsPatterns(line))
                {
                    matchedLines.add(line);
                }
            }
        }

        WriteToFile(matchedLines);



    }

    @Override
    public List<File> listFiles(String rootDir) throws IOException
    {
        List<File> list = new ArrayList<>();
        try (Stream<Path> paths = Files.list(Paths.get(rootDir))) {
            return paths
                    .filter(Files::isRegularFile)
                    .map(Path::toFile)
                    .collect(Collectors.toList());
        }


    }

    @Override
    public List<String> readLines(File inputFile) throws IllegalArgumentException,IOException {


        return Files.readAllLines(inputFile.toPath());
    }

    @Override
    public boolean containsPatterns(String line) {
        return Pattern.compile(getRegex()).matcher(line).find();
    }

    @Override
    public void WriteToFile(List<String> lines) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(getOutFile()))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine(); // Add newline after each element
            }
        }

    }


}
