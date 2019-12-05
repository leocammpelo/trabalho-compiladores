import org.antlr.v4.runtime.ParserRuleContext;

public class ParsingListener extends JavaParserBaseListener {
    @Override
    public void enterEveryRule(ParserRuleContext ctx) {
        System.out.println("rule entered: " + ctx.getText());
    }
    @Override
    public void  exitEveryRule (ParserRuleContext ctx) {
        System.out.println("rule exited:  " + ctx.getText());
    }

}