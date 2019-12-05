public class Symbol {

    private String varName;

    Symbol(String varName){
        this.varName = varName;
    }

    public String toString() {
        return varName;
    }

    public boolean equals(Symbol symbol) {
        if(this.varName.equals(symbol.varName)){
            return true;
        }
        return false;
    }
}
