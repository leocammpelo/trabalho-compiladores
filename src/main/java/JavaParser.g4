parser grammar JavaParser;

//Parser rules
//check with the BNF before use
//programs

options {
    tokenVocab=Scanner;
    }

compilationUnit: packageDeclaration? importDeclaration? typeDeclaration;

//declarations

packageDeclaration: PACKAGE packageName SEMI;

importDeclarations:	importDeclaration | importDeclarations importDeclaration;

importDeclaration: singleTypeImportDeclaration | typeImportOnDemandDeclaration;

singleTypeImportDeclaration: IMPORT typeName  SEMI;

typeImportOnDemandDeclaration: IMPORT packageName DOT MUL;

typeDeclarations: typeDeclaration | typeDeclarations typeDeclaration;

typeDeclaration: classDeclaration | interfaceDeclaration | SEMI;

classDeclaration: classModifiers ? CLASS IDENTIFIER super_parser? interfaces? classBody;

classModifiers: classModifier | classModifiers classModifier;

classModifier: PUBLIC | ABSTRACT | PRIVATE;

super_parser: EXTENDS classType;

interfaces: IMPLEMENTS interfaceTypeList;

interfaceTypeList: interfaceType | interfaceTypeList COMMA interfaceType;

classBody: LBRACE classBodyDeclaration? RBRACE;

classBodyDeclarations:  classBodyDeclaration | classBodyDeclarations classBodyDeclaration;

classBodyDeclaration: classMemberDeclaration | staticInitializer | constructorDeclaration;

classMemberDeclaration: fieldDeclaration | methodDeclaration;

staticInitializer: STATIC block;

classTypeList: classType | classTypeList COMMA classType;

constructorDeclaration: constructorModifiers? constructorDeclarator (THROWS classTypeList)? constructorBody;

constructorModifiers: constructorModifier | constructorModifiers constructorModifier;

constructorModifier: PUBLIC | PROTECTED | PRIVATE;

constructorDeclarator: simpleTypeName LPAREN formalParameterList? RPAREN;

formalParameterList: formalParameter | formalParameterList COMMA formalParameter;

formalParameter: type variableDeclaratorId;

constructorBody: LBRACE explicitConstructorInvocation? blockStatements? RBRACE;

explicitConstructorInvocation: THIS LPAREN argumentList? RPAREN | SUPER LPAREN argumentList? RPAREN;

fieldDeclaration: fieldModifiers? type variableDeclarators SEMI;

fieldModifiers: fieldModifier | fieldModifiers fieldModifier;

fieldModifier: PUBLIC | PROTECTED | PRIVATE | STATIC | FINAL | TRANSIENT | VOLATILE;

variableDeclarators: variableDeclarator | variableDeclarators COMMA variableDeclarator;

variableDeclarator: variableDeclaratorId | variableDeclaratorId ASSIGN variableInitializer;

variableDeclaratorId: IDENTIFIER | variableDeclaratorId LBRACK RBRACK;

variableInitializer: expression | arrayInitializer;

methodDeclaration: methodHeader methodBody;

methodHeader: methodModifiers? resultType methodDeclarator (THROWS classTypeList)?;

resultType: type | VOID;

methodModifiers: methodModifier | methodModifiers methodModifier;

methodModifier: PUBLIC | PROTECTED | PRIVATE | STATIC | ABSTRACT | FINAL | SYNCHRONIZED | NATIVE;

methodDeclarator: IDENTIFIER LPAREN formalParameterList? RPAREN;

methodBody: block | SEMI;

interfaceDeclaration: interfaceModifiers? INTERFACE IDENTIFIER extendsInterfaces? interfaceBody;

interfaceModifiers: interfaceModifier | interfaceModifiers interfaceModifier;

interfaceModifier: PUBLIC | ABSTRACT;

extendsInterfaces: EXTENDS interfaceType | extendsInterfaces COMMA interfaceType;

interfaceBody: LBRACE interfaceMemberDeclarations? RBRACE;

interfaceMemberDeclarations: interfaceMemberDeclaration | interfaceMemberDeclarations interfaceMemberDeclaration;

interfaceMemberDeclaration: constantDeclaration | abstractMethodDeclaration;

constantDeclaration: constantModifiers type variableDeclarator;

constantModifiers: PUBLIC | STATIC | FINAL;

abstractMethodDeclaration: abstractMethodModifiers? resultType methodDeclarator (THROWS classTypeList)?SEMI;

abstractMethodModifiers: abstractMethodModifier | abstractMethodModifiers abstractMethodModifier;

abstractMethodModifier: PUBLIC | ABSTRACT;

arrayInitializer: LBRACE variableInitializers? COMMA? RBRACE;

variableInitializers: variableInitializer | variableInitializers COMMA variableInitializer;

//Types

type: primitiveType | classOrInterfaceType | type LBRACK RBRACK;

primitiveType: numericType | BOOLEAN;

numericType: integralType | floatingPointType;

integralType: BYTE | SHORT | INT | LONG | CHAR;

floatingPointType: FLOAT | DOUBLE;

classOrInterfaceType: classType | interfaceType;

classType: typeName;

interfaceType: typeName;



//Blocks and Commands

block: LBRACE (blockStatements)? RBRACE;

blockStatements: blockStatement | blockStatements blockStatement;

blockStatement: localVariableDeclarationStatement | statement;

localVariableDeclarationStatement: localVariableDeclaration SEMI;

localVariableDeclaration: type variableDeclarators;

statement: statementWithoutTrailingSubstatement | labeledStatement | ifThenStatement | ifThenElseStatement | whileStatement | forStatement;

statementNoShortIf: statementWithoutTrailingSubstatement | labeledStatementNoShortIf | ifThenElseStatementNoShortIf | whileStatementNoShortIf | forStatementNoShortIf;

statementWithoutTrailingSubstatement: block | emptyStatement | expressionStatement | switchStatement | doStatement | breakStatement | continueStatement | returnStatement | synchronizedStatement | throwsStatement | tryStatement;

emptyStatement: SEMI;

labeledStatement: IDENTIFIER COLON statement;

labeledStatementNoShortIf: IDENTIFIER COLLON statementNoShortIf;

expressionStatement: statementExpression SEMI;

statementExpression: assignment | preincrementExpression | postincrementExpression | predecrementExpression | postdecrementExpression | methodInvocation | classInstanceCreationExpression;

ifThenStatement: IF LPAREN expression RPAREN statement;

ifThenElseStatement: IF LPAREN expression RPAREN statementNoShortIf ELSE statement;

ifThenElseStatementNoShortIf: IF LPAREN expression RPAREN statementNoShortIf ELSE statementNoShortIf;

switchStatement: SWITCH LPAREN expression RPAREN switchBlock;

switchBlock: LBRACE switchBlockStatementGroups? switchLabels? RBRACE;

switchBlockStatementGroups: switchBlockStatementGroup | switchBlockStatementGroups switchBlockStatementGroup;

switchBlockStatementGroup: switchLabels blockStatements;

switchLabels: switchLabel | switchLabels switchLabel;

switchLabel: CASE constantExpression COLLON | DEFAULT COLLON;

whileStatement: WHILE LPAREN expression RPAREN statement;

whileStatementNoShortIf: WHILE LPAREN expression RPAREN statementNoShortIf;

doStatement: DO statement WHILE LPAREN expression RPAREN SEMI;

forStatement: FOR LPAREN forInit? SEMI expression? SEMI forUpdate? RPAREN statement;

forStatementNoShortIf: FOR LPAREN forInit? SEMI expression? SEMI forUpdate? RPAREN statementNoShortIf;

forInit: statementExpressionList | localVariableDeclaration;

forUpdate: statementExpressionList;

statementExpressionList: statementExpression | statementExpressionList COMMA statementExpression;

breakStatement: BREAK IDENTIFIER? SEMI;

continueStatement: CONTINUE IDENTIFIER? SEMI;

returnStatement: RETURN expression? SEMI;

throwsStatement: THROW expression SEMI ;

synchronizedStatement: SYNCHRONIZED LPAREN expression RPAREN block;

tryStatement: TRY block catches | TRY block catches? FINALLY block;

catches: catchClause | catches catchClause;

catchClause: CATCH LPAREN formalParameter RPAREN block;

//finally: FINALLY block;



//Expression

constantExpression: expression;

expression: assignmentExpression;

assignmentExpression: conditionalExpression | assignment;

assignment: leftHandSide assignmentOperator assignmentExpression;

leftHandSide: expressionName | fieldAccess | (expressionName LBRACK expression RBRACK | primaryNoNewArray LBRACK expression);

assignmentOperator: ASSIGN | MUL_ASSIGN | DIV_ASSIGN | MOD_ASSIGN | ADD_ASSIGN | SUB_ASSIGN | LSHIFT_ASSIGN | RSHIFT_ASSIGN | URSHIFT_ASSIGN | AND_ASSIGN | XOR_ASSIGN | BITOR;

conditionalExpression: conditionalOrExpression | conditionalOrExpression QUESTION expression COLLON conditionalExpression;

conditionalOrExpression: conditionalAndExpression | conditionalOrExpression OR conditionalAndExpression;

conditionalAndExpression: inclusiveOrExpression | conditionalAndExpression AND inclusiveOrExpression;

inclusiveOrExpression: exclusiveOrExpression  (BITOR exclusiveOrExpression)*;

exclusiveOrExpression: andExpression | exclusiveOrExpression CARET andExpression;

andExpression: equalityExpression | andExpression BITAND equalityExpression;

equalityExpression: relationalExpression | equalityExpression  EQUAL relationalExpression | equalityExpression NOTEQUAL relationalExpression;

relationalExpression: shiftExpression | relationalExpression LT shiftExpression | relationalExpression GT shiftExpression | relationalExpression LE shiftExpression | relationalExpression GE shiftExpression | relationalExpression INSTANCEOF (classOrInterfaceType | type LBRACK RBRACK);

shiftExpression: additiveExpression | shiftExpression SHIFT_RIGHT additiveExpression | shiftExpression SHIFT_RIGHT additiveExpression | shiftExpression UNSIGNED_SHIFT_RIGHT additiveExpression;

additiveExpression: multiplicativeExpression | additiveExpression ADD multiplicativeExpression | additiveExpression SUB multiplicativeExpression;

multiplicativeExpression: unaryExpression | multiplicativeExpression MUL unaryExpression | multiplicativeExpression DIV unaryExpression | multiplicativeExpression MOD unaryExpression;

castExpression: LPAREN primitiveType RPAREN unaryExpression | LPAREN classOrInterfaceType | type LBRACK RBRACK RPAREN unaryExpressionNotPlusMinus;

unaryExpression: preincrementExpression | predecrementExpression | ADD unaryExpression | SUB unaryExpression | unaryExpressionNotPlusMinus;

predecrementExpression: DEC unaryExpression;

preincrementExpression: INC unaryExpression;

unaryExpressionNotPlusMinus: (postdecrementExpression|postincrementExpression) | TILDE unaryExpression | BANG unaryExpression | castExpression;

postdecrementExpression: postfixExpression DEC;

postincrementExpression: postfixExpression INC;

postfixExpression: (primaryNoNewArray | arrayCreationExpression) | expressionName;

methodInvocation: methodName LPAREN argumentList? RPAREN | (primaryNoNewArray | arrayCreationExpression) DOT IDENTIFIER LPAREN argumentList? RPAREN | SUPER DOT IDENTIFIER LPAREN argumentList? RPAREN;

fieldAccess: (primaryNoNewArray | arrayCreationExpression) DOT IDENTIFIER | SUPER DOT IDENTIFIER;

primaryNoNewArray: (literal | THIS | LPAREN expression RPAREN | classInstanceCreationExpression | ((primaryNonNewArrayRepeat | arrayCreationExpression)DOT IDENTIFIER | SUPER DOT IDENTIFIER) | (methodName LPAREN argumentList? RPAREN | (primaryNonNewArrayRepeat| arrayCreationExpression) DOT IDENTIFIER LPAREN argumentList? RPAREN | SUPER DOT IDENTIFIER LPAREN argumentList? RPAREN) | expressionName LBRACK expression RBRACK) + LBRACK expression;

primaryNoNewArrayAux: (literal | THIS | LPAREN expression RPAREN | classInstanceCreationExpression | DOT IDENTIFIER | SUPER DOT IDENTIFIER) | (methodName LPAREN argumentList? RPAREN | DOT IDENTIFIER LPAREN argumentList? RPAREN | SUPER DOT IDENTIFIER LPAREN argumentList? RPAREN) | expressionName LBRACK expression RBRACK + LBRACK expression;

primaryNonNewArrayRepeat: (primaryNoNewArrayAux)+;

classInstanceCreationExpression:  NEW classType LPAREN argumentList?;

argumentList: expression | argumentList COMMA expression;

arrayCreationExpression: NEW primitiveType dimExprs dims? | NEW classOrInterfaceType dimExprs dims?;

dimExprs: dimExpr | dimExprs dimExpr;

dimExpr: LBRACK expression;

dims: LBRACK RBRACK | dims LBRACK RBRACK;




//Tokens

packageName: IDENTIFIER | packageName DOT IDENTIFIER;

typeName: IDENTIFIER | packageName DOT IDENTIFIER;

simpleTypeName: IDENTIFIER;

expressionName: IDENTIFIER | ambiguousName DOT IDENTIFIER;

methodName: IDENTIFIER | ambiguousName DOT IDENTIFIER;

ambiguousName: IDENTIFIER | ambiguousName DOT IDENTIFIER;

literal: integerLiteral | floatingPointLiteral | booleanLiteral | characterLiteral | stringLiteral | nullLiteral;

integerLiteral: decimalIntegerLiteral | hexIntegerLiteral | octalIntegerLiteral;

decimalIntegerLiteral: decimalNumeral integerTypeSuffix?;

hexIntegerLiteral: HexNumeral integerTypeSuffix?;

octalIntegerLiteral: OctalNumeral integerTypeSuffix?;

integerTypeSuffix: IntegerTypeSuffix;

decimalNumeral:  Zero | NonZeroDigit digits?;

digits: digit | digits digit;

digit: Zero | NonZeroDigit;


floatingPointLiteral: digits DOT digits? exponentPart? FloatTypeSuffix? digits exponentPart? FloatTypeSuffix?;

exponentPart: ExponentIndicator signedInteger;

signedInteger: sign? digits;

sign: ADD | SUB;

booleanLiteral: TRUE | FALSE;

characterLiteral : CHARACTER;

stringLiteral : STRING;

nullLiteral : NULL;