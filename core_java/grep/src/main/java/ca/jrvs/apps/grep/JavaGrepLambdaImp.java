package ca.jrvs.apps.grep;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;
import java.io.IOException;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class JavaGrepLambdaImp extends JavaGrepImp{

    public static void main(String[] args) {
        if (args.length!=3 )
        {
            throw new IllegalArgumentException("USAGE: JavaGrep regex RootPath outFile");
        }

        JavaGrepLambdaImp javagrepLambdaImp = new JavaGrepLambdaImp();
        javagrepLambdaImp.setRegex(args[0]);
        javagrepLambdaImp.setRootPath(args[1]);
        javagrepLambdaImp.setOutFile(args[2]);

        try
        {
            javagrepLambdaImp.process();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    @Override
    public List<String> readLines(File inputFile) throws IllegalArgumentException,IOException {

        Path path= inputFile.toPath();
        try (Stream<String> lines = Files.lines(path))
        {
            return lines.collect(Collectors.toList());
        }
    }
}
