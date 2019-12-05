import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.ATNConfigSet;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.ParseCancellationException;

import java.util.BitSet;

public class LexicalErrorListener extends BaseErrorListener implements ANTLRErrorListener {

    public LexicalErrorListener() {
        super();
    }

    public static final LexicalErrorListener INSTANCE = new LexicalErrorListener();

    @Override
    public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e){
        System.out.println("*************LEXER ERROR*****************");
        System.out.println(String.format("%s\nLinha:%d\nColuna:%d", msg.replaceFirst("t", "T"), line, charPositionInLine ));
        System.out.println("********************************");
    }
}
