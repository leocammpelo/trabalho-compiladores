import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import java.io.*;
import java.util.Map;

public class Main {


    public static void main (String[] args) throws IOException {


        String fileName = "./Test/HelloWorld.java";

        File file = new File(fileName);

        FileInputStream fis = null;

        fis = new FileInputStream(file);

        ANTLRInputStream input = new ANTLRInputStream(fis);


        Scanner scanner = new Scanner(input);
        scanner.removeErrorListeners();
        scanner.addErrorListener(LexicalErrorListener.INSTANCE);


        CommonTokenStream allTokensGenerated = new CommonTokenStream(scanner);
        JavaParser parser = new JavaParser(allTokensGenerated);
        parser.removeErrorListeners();
        parser.addErrorListener(ParserErrorListener.INSTANCE);
        parser.setErrorHandler(new DefaultErrorStrategy());

        ParserRuleContext tree = parser.compilationUnit();

        ParseTreeWalker walker = new ParseTreeWalker();
        ParsingListener listener = new ParsingListener();

         walker.walk(listener, tree);
       // System.out.println(scanner.getE);

//        scanner.removeErrorListeners();
//        scanner.addErrorListener(new LexicalErrorListener());
//        System.out.println(scanner.getErrorDisplay());


       PrintLexerBuildSymbolTable(file);

    }

    //Metodo auxiliar para obter o nome dos tipos de tokens
    public static Object getKeyFromValue(Map map, Object value) {
        for (Object o : map.keySet()) {
            if (map.get(o).equals(value)) {
                return o;
            }
        }
        return null;
    }

    public static void PrintLexerBuildSymbolTable(File file) throws IOException {

        FileInputStream fis = null;

        fis = new FileInputStream(file);

        ANTLRInputStream input = new ANTLRInputStream(fis);


        Scanner scanner = new Scanner(input);
        scanner.removeErrorListeners();
        scanner.addErrorListener(LexicalErrorListener.INSTANCE);

        SymbolTable symbolTable = new SymbolTable();
        int index = 0;

        for (Token token: scanner.getAllTokens()) {
            //token.
            //System.out.println(scanner.);

            System.out.println("Linha: " + token.getLine());
            System.out.println("Coluna: " + token.getCharPositionInLine());
            System.out.println("Lexema: " + token.getText());
            System.out.println("Token: " + "<" + getKeyFromValue(scanner.getTokenTypeMap(), token.getType()) + "," + token.getText() + ">");
            System.out.println("********************************");
            if (getKeyFromValue(scanner.getTokenTypeMap(), token.getType()).equals("IDENTIFIER")) {
                symbolTable.addSymbol(index, new Symbol(token.getText()));
                index++;
            }

            symbolTable.printTable();
        }

    }
}

//toString().replaceAll(" ", "\n")
