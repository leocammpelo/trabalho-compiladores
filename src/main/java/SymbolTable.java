import java.util.LinkedHashMap;
import java.util.Map;

public class SymbolTable {

    private Map<Integer, Symbol> table;

    SymbolTable(){
        this.table = new LinkedHashMap<Integer, Symbol>();
    }

    public void addSymbol(int index, Symbol symbol){
        if(!this.table.containsKey(index)){
            this.table.put(index,symbol);
        }
    }

    public int getIndex(Symbol symbol){
        if(this.table.containsValue(symbol)) {
            for (Integer key : this.table.keySet()) {
                if (this.table.get(key).equals(symbol)) {
                    return key;
                }
            }
        }
        return -1;
    }

    public void printTable(){
        System.out.println("Index|Lexema");
        for (Integer key : this.table.keySet()) {
            System.out.println(String.valueOf(key) +"|" + this.table.get(key).toString());
        }
    }

}

