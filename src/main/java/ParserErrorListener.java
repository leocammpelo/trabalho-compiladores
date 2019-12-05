import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.ParseCancellationException;

import java.util.ArrayList;

public class ParserErrorListener extends BaseErrorListener implements ANTLRErrorListener {
    public static ParserErrorListener INSTANCE = new ParserErrorListener();

    @Override
    public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e)   {
        System.out.println("*************PARSER ERROR*****************");
        System.out.println(String.format("%s\nLine:%d\nColumn:%d", msg, line, charPositionInLine ));
        System.out.println("********************************");
    }

}