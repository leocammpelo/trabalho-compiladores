lexer grammar Scanner;
//parser rules start with lowercase letters, lexer rules with uppercase
//Scanner Rules

//Lexer rules

//reserved words
ABSTRACT: 'abstract';
BOOLEAN: 'boolean';
BREAK: 'break';
BYTE: 'byte';
CASE: 'case';
CATCH: 'catch';
CHAR: 'char';
CLASS: 'class';
CONST: 'const';
CONTINUE: 'continue';
DEFAULT: 'default';
DO: 'do';
DOUBLE: 'double';
ELSE: 'else';
EXTENDS: 'extends';
FINAL: 'final';
FINALLY: 'finally';
FLOAT: 'float';
FOR: 'for';
GOTO: 'goto';
IF: 'if';
IMPLEMENTS: 'implements';
IMPORT: 'import';
INSTANCEOF: 'instanceof';
INT: 'int';
INTERFACE: 'interface';
LONG: 'long';
NATIVE: 'native';
NEW: 'new';
PACKAGE: 'package';
PRIVATE: 'private';
PROTECTED: 'protected';
PUBLIC: 'public';
RETURN: 'return';
SHORT: 'short';
STATIC: 'static';
SUPER: 'super';
SWITCH: 'switch';
SYNCHRONIZED: 'synchronized';
THIS: 'this';
THROW: 'throw';
THROWS: 'throws';
TRANSIENT: 'transient';
TRY: 'try';
VOID: 'void';
VOLATILE: 'volatile';
TRUE: 'true';
FALSE: 'false';
WHILE: 'while';
NULL: 'null';

//Operators

ASSIGN : '=';
GT : '>';
LT : '<';
BANG : '!';
TILDE : '~';
QUESTION : '?';
COLON : ':';
EQUAL : '==';
LE : '<=';
GE : '>=';
NOTEQUAL : '!=';
AND : '&&';
OR : '||';
INC : '++';
DEC : '--';
ADD : '+';
SUB : '-';
MUL : '*';
DIV : '/';
BITAND : '&';
BITOR : '|';
CARET : '^';
MOD : '%';
ARROW : '->';
COLONCOLON : '::';

//Assignment Operator

ADD_ASSIGN : '+=';
SUB_ASSIGN : '-=';
MUL_ASSIGN : '*=';
DIV_ASSIGN : '/=';
AND_ASSIGN : '&=';
OR_ASSIGN : '|=';
XOR_ASSIGN : '^=';
MOD_ASSIGN : '%=';
SHIFT_LEFT:  '<<';
SHIFT_RIGHT: '>>';
UNSIGNED_SHIFT_RIGHT: '>>>';
LSHIFT_ASSIGN : '<<=';
RSHIFT_ASSIGN : '>>=';
URSHIFT_ASSIGN : '>>>=';

//Separators

LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
LBRACK: '[';
RBRACK: ']';
SEMI: ';';
COMMA: ',';
DOT: '.';

//IDs
fragment Letter: [a-zA-Z];
fragment Letter_Id: (Letter | '_' | '$');
fragment Digit: [0-9];
fragment Zero: '0';
fragment OctalDigit: '0'..'7';
fragment HexDigit:  ('0'..'9' | 'a'..'f' | 'A'..'F');
fragment NonZeroDigit: [1-9];
fragment
ESCAPESEQUENCES
    :    '\\b' /* backspace BS */
    |    '\\t' /* horizontal tab HT */
    |    '\\n' /*  linefeed LF */
    |    '\\f' /*  form feed FF */
    |    '\\r' /*  carriage return CR */
    |    '\\"' /* double quote " */
    |    '\\\'' /*  single quote ' */
    |    '\\\\' /*  backslash \ */
    ;
fragment IntegerTypeSuffix:  'l' |  'L';
fragment FloatTypeSuffix: 'f' | 'F '| 'd' | 'D';
fragment ExponentIndicator: 'e' | 'E';
fragment OctalNumeral: ('0' OctalDigit)+ OctalDigit;
fragment HexNumeral: (('0' 'x'HexDigit)|('0' 'X' HexDigit))+ HexDigit;


NUMINT : ('+'|'-')?('0'..'9')+ ;
NUMREAL : ('+'|'-')?('0'..'9')+ ('.' ('0'..'9')+)?;
CHARACTER: ('\'') (~['\\\r\n]) ('\'');
STRING: ('"') (~['\\\r\n])* ('"');

//add $ and _ to the frist digit of the identifier and the rest can be anything
IDENTIFIER: (Letter_Id)(Letter_Id | Digit)*;

LINE_COMMENT: '//' ~[\r\n]* -> skip;

COMMENT: '/*' .*? '*/' -> skip;

WHITESPACE: ('\t' | ' ' | '\r' | '\n' | '\u000C') -> skip;

