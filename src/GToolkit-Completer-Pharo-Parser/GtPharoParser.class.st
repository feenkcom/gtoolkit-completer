Class {
	#name : #GtPharoParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 42 0 237] 
#[ 0 237 0 238] 
#[ 0 237 1 98]
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2020-09-17T12:46:51.848633-05:00'
]

{ #category : #generated }
GtPharoParser class >> definitionComment [
"%glr;
%prefix GtPharo;
%suffix Node;
%root Program;
%start Method MethodSequence Statement MethodPattern;
%id <bar> <binary>;
%hierarchy Value (
	Array
	Assignment
	Block
	Cascade
	Error
	Literal
	MessageSend
	Variable
);
%hierarchy Literal (StringLiteral NumberLiteral CharacterLiteral SymbolLiteral ArrayLiteral BooleanLiteral NilLiteral);
%hierarchy ArrayLiteral (ByteArrayLiteral);
%hierarchy Message (UnaryMessage BinaryMessage KeywordMessage);
%hierarchy Sequence (MethodSequence);
%hierarchy Pragma (PragmaError);
%hierarchy Block (BlockError);
%hierarchy MethodPattern (ErrorPattern);
%ignore_variables leftParen rightParen leftBar rightBar leftBracket rightBracket semicolon colon period ;


%id <number> <negativeNumber> <binary> <bar> <name> <keyword> <nameAssignment>;

default literalArray <true>
	: true
	;
default literalArray <false>
	: false
	;
default literalArray <nil>
	: nil
	;
default literalArray <name>
	:  (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
default <nameAssignment>
	: <name> \:\=
	;
default <bar>
	: \|
	;
default literalArray <string>
	: ( \' [^\']* \' )+
	;
default literalArray <symbol>
	: \#{1,2} ( <name> (\:\: <name>)* | <binary> | <keyword>+ | <string> )
	;
default literalArray <character>
	: \$ .
	;
default literalArray <number>
	: \d
	;
default literalArray <negativeNumber>
	: \- <number>
	;
literalArray <literalArrayKeyword>
	: <keyword>+
	;
default <return>
	: \^
	;
default <lt>
	: \<
	;
default <gt>
	: \>
	;
default <leftBrace>
	: \{
	;
default literalArray <leftBracket>
	: \[
	;
default <colon>
	: \:
	;
default literalArray <leftParen>
	: \(
	;
default literalArray <literalArrayStart>
	: \#\(
	;
default literalArray <byteArrayStart>
	: \#\[
	;
default literalArray <rightParen>
	: \)
	;
default literalArray <rightBracket>
	: \]
	;
default <rightBrace>
	: \}
	;
literalArray <selector>
	: (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	| ((<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) * \:)+
	;
default <keyword>
	: <name> \:
	;
default literalArray <binary>
	: [\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,] +
	;
default literalArray <semicolon>
	: \;
	;
default <assign>
	: \: \=
	;
default literalArray <period>
	: \.
	;
default literalArray <comment>
	: \"" [^\""]* \""
	;
default literalArray <whitespace>
	: (\s | \x0)+
	;
<patternToken>
	: (\`  [^\`]* \`)+
	;
Method
	: MethodPattern 'pattern' MethodSequence 'body' {{}}
	;
MethodPattern
	: <name> 'selectorPart' {{}}
	| <binary> 'selectorPart' Variable 'variable' {{}}
	| KeywordPattern {{}}
	| <binary> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| (<keyword> 'selectorPart' Variable 'variable')+ <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	;
Pragmas
	: Pragma 'pragma'+
	;
Pragma
	:  <lt> 'lessThan' <name> 'selectorPart' <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' (<keyword> 'selectorPart' (Literal 'value' | Variable 'value'))+ <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' error 'smaccError' {{PragmaError}}
	| <lt> 'lessThan' error 'smaccError' <gt> 'greaterThan' {{PragmaError}}
	;
KeywordPattern
	: (<keyword> 'selectorPart' Variable 'variable')+
	;
MethodSequence
	: Pragmas Temporaries Pragmas <period> 'period'* Statements? {{}}
	| Temporaries Pragmas <period> 'period'* Statements? {{}}
	| Pragmas Temporaries? <period> 'period'* Statements? {{}}
	| Sequence
	;
Sequence
	: Temporaries? <period> 'period'* Statements? {{}}
	;
Temporaries
	:  <bar> 'leftBar' Variable 'variable'* <bar> 'rightBar'
	;
Statements
	: StatementList <period> 'period'+?
	;
StatementList
	: Statement 'statement'
	| StatementList <period> 'period'+ Statement 'statement'
	;
Statement
	: <return> 'upArrow' Assignment 'value' {{Return}}
	| Assignment
	;
Assignment
	: Variable 'variable' <assign> 'assignmentToken' Assignment 'value' {{}}
	| Cascade
	;
Cascade
	: KeywordMessageSendVars CascadedMessages {{}}
	| BinaryMessageSendVars CascadedMessages {{}}
	| UnaryMessageSendVars CascadedMessages {{}}
	| KeywordMessageSend
	;
CascadedMessages
	: (<semicolon> 'semicolon' CascadedMessage 'message')+
	;
CascadedMessage
	: KeywordMessage
	| BinaryMessage
	| UnaryMessage
	;
KeywordMessageSend
	: KeywordMessageSendVars {{MessageSend}}
	| BinaryMessageSend
	;
KeywordMessageSendVars
	: BinaryMessageSend 'receiver' KeywordMessage 'message' 
	;
KeywordMessage
	: (<keyword> 'selectorPart' BinaryMessageSend 'value')+ {{}}
	;
BinaryMessageSend
	: BinaryMessageSendVars {{MessageSend}}
	| UnaryMessageSend
	;
BinaryMessageSendVars
	: BinaryMessageSend 'receiver' BinaryMessage 'message' 
	;
BinaryMessage
	: <binary> 'selectorPart' UnaryMessageSend 'value' {{}}
	;
UnaryMessageSend
	: UnaryMessageSendVars {{MessageSend}}
	| Value
	;
UnaryMessageSendVars
	: UnaryMessageSend 'receiver' UnaryMessage 'message' 
	;
UnaryMessage
	: <name> 'selectorPart' {{}}
	;
Variable
	: <name> 'name' {{}}
	;
Value
	: Variable
	| Literal
	| Array
	| Block
	| <leftParen> 'leftParen' Assignment <rightParen> 'rightParen' {{Value}}
	| error 'smaccError' {{Error}}
	;
Array
	: <leftBrace> 'leftBrace' (Assignment 'value' (<period> 'period' Assignment 'value')*)? <period> 'period'? <rightBrace> 'rightBrace' {{}}
	;
Block
	: <leftBracket> 'leftBracket' BlockArgs Sequence 'body' <rightBracket> 'rightBracket' {{}}
	| <leftBracket> 'leftBracket' (<colon> 'colon' Variable 'variable')+ <rightBracket> 'rightBracket' {{}}
	| <leftBracket> 'leftBracket' BlockArgs Sequence 'body' error 'smaccError' {{BlockError}}
	;
BlockArgs
	: 
	| (<colon> 'colon' Variable 'variable')+ <bar> 'bar'
	;
Literal
	: StringLiteral
	| NumberLiteral
	| ArrayLiteral
	| ByteArrayLiteral
	| CharacterLiteral
	| SymbolLiteral
	| BooleanLiteral
	| NilLiteral
	;
StringLiteral
	: <string> 'value' {{}}
	;
NumberLiteral
	: <number> 'value' {{}}
	| <negativeNumber> 'value' {{}}
	;
ArrayLiteral
	: SwitchToLiteralArray <literalArrayStart> 'arrayStart' ArrayLiteralValue 'value'* EndLiteralArray <rightParen> 'arrayStop' {{}}
	;
ArrayLiteralValue
	: Literal
	| <literalArrayKeyword> 'value' {{SymbolLiteral}}
	| <name> 'value' {{SymbolLiteral}}
	| <binary> 'value' {{SymbolLiteral}}
	| <period> 'value' {{SymbolLiteral}}
	| <semicolon> 'value' {{SymbolLiteral}}
	| <leftParen> 'arrayStart' ArrayLiteralValue 'value'* <rightParen> 'arrayStop' {{ArrayLiteral}}
	| error 'smaccError' {{Error}}
	;
ByteArrayLiteral
	: <byteArrayStart> 'arrayStart' ByteArrayLiteralValue 'value'* <rightBracket> 'arrayStop' {{}}
	;
ByteArrayLiteralValue
	: NumberLiteral
	| error 'smaccError' {{Error}}
	;
CharacterLiteral
	: <character> 'value' {{}}
	;
SymbolLiteral
	: <symbol> 'value' {{}}
	;
BooleanLiteral
	: <true> 'value' {{}}
	| <false> 'value' {{}}
	;
NilLiteral
	: <nil> 'value' {{}}
	;
SwitchToLiteralArray
	: {self scope: #literalArray. #array}
	;
EndLiteralArray
	: {self endLiteralArray. nil}
	;"
]

{ #category : #generated }
GtPharoParser class >> reduceTable [
^#(
	#(45 0 #reduceActionFor_period___period__1: 3288065 false ) 
	#(92 0 #reduceActionForSwitchToLiteralArray1: 6874113 false ) 
	#(35 1 #reduceActionForMethodPattern1: 2450433 false ) 
	#(37 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 2705409 false ) 
	#(43 1 #reduceActionForKeywordPattern1: 3170305 false ) 
	#(35 1 #reduceActionForMethodPattern3: 2450435 false ) 
	#(48 0 #reduceActionFor_period___period__1: 3560449 false ) 
	#(38 1 #reduceActionForKeywordPattern1: 2820097 false ) 
	#(39 1 #reduceActionForPragma__pragma__1: 2831361 false ) 
	#(46 1 #reduceActionForSequence1: 3462145 false ) 
	#(44 1 #liftFirstValue: 3240969 false ) 
	#(90 1 #reduceActionForBooleanLiteral1: 6770689 false ) 
	#(90 1 #reduceActionForBooleanLiteral1: 6770690 false ) 
	#(91 1 #reduceActionForNilLiteral1: 6837249 false ) 
	#(70 1 #reduceActionForVariable1: 4964353 false ) 
	#(80 1 #reduceActionForStringLiteral1: 5840897 false ) 
	#(89 1 #reduceActionForSymbolLiteral1: 6727681 false ) 
	#(88 1 #reduceActionForCharacterLiteral1: 6678529 false ) 
	#(81 1 #reduceActionForNumberLiteral1: 5883905 false ) 
	#(81 1 #reduceActionForNumberLiteral1: 5883906 false ) 
	#(78 0 #reduceActionForBlockArgs1: 5614593 false ) 
	#(86 0 #reduceActionFor_period___period__1: 6535169 false ) 
	#(52 1 #liftFirstValue: 3757058 false ) 
	#(53 1 #liftFirstValue: 3837954 false ) 
	#(54 1 #liftFirstValue: 3939332 false ) 
	#(59 1 #reduceActionForKeywordMessageSend1: 4267009 false ) 
	#(59 1 #liftFirstValue: 4267010 false ) 
	#(64 1 #reduceActionForKeywordMessageSend1: 4521985 false ) 
	#(64 1 #liftFirstValue: 4521986 false ) 
	#(67 1 #reduceActionForKeywordMessageSend1: 4765697 false ) 
	#(71 1 #liftFirstValue: 4999169 false ) 
	#(67 1 #liftFirstValue: 4765698 false ) 
	#(71 1 #liftFirstValue: 4999171 false ) 
	#(71 1 #liftFirstValue: 4999172 false ) 
	#(71 1 #liftFirstValue: 4999170 false ) 
	#(79 1 #liftFirstValue: 5687297 false ) 
	#(79 1 #liftFirstValue: 5687298 false ) 
	#(79 1 #liftFirstValue: 5687299 false ) 
	#(79 1 #liftFirstValue: 5687300 false ) 
	#(79 1 #liftFirstValue: 5687301 false ) 
	#(79 1 #liftFirstValue: 5687302 false ) 
	#(79 1 #liftFirstValue: 5687303 false ) 
	#(79 1 #liftFirstValue: 5687304 false ) 
	#(71 1 #reduceActionForValue6: 4999174 false ) 
	#(36 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 2705409 false ) 
	#(35 2 #reduceActionForMethodPattern5: 2450437 false ) 
	#(35 2 #reduceActionForMethodPattern2: 2450434 false ) 
	#(35 2 #reduceActionForMethodPattern5: 2450436 false ) 
	#(34 2 #reduceActionForMethod1: 2384897 false ) 
	#(37 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 2705410 false ) 
	#(42 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 2946049 false ) 
	#(40 2 #reduceActionForPragma3: 2851843 false ) 
	#(44 2 #reduceActionForMethodSequence5: 3240965 false ) 
	#(39 2 #reduceActionForPragma__pragma__2: 2831362 false ) 
	#(45 2 #reduceActionForPragma__pragma__2: 3288066 false ) 
	#(46 2 #reduceActionForSequence2: 3462146 false ) 
	#(49 1 #reduceActionForKeywordPattern1: 3602433 false ) 
	#(51 1 #reduceActionForStatementList1: 3654657 false ) 
	#(46 2 #reduceActionForSequence3: 3462147 false ) 
	#(52 2 #reduceActionForStatement1: 3757057 false ) 
	#(72 2 #reduceActionForArray1: 5158913 false ) 
	#(74 0 #reduceActionFor__period___period__Assignment__value___1: 5213185 false ) 
	#(77 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5442561 false ) 
	#(54 2 #reduceActionForCascade1: 3939329 false ) 
	#(57 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4137985 false ) 
	#(55 1 #reduceActionForKeywordPattern1: 4117505 false ) 
	#(60 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4354049 false ) 
	#(63 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4458497 false ) 
	#(61 1 #reduceActionForKeywordMessage1: 4440065 false ) 
	#(65 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4605953 false ) 
	#(54 2 #reduceActionForCascade1: 3939330 false ) 
	#(69 1 #reduceActionForUnaryMessage1: 4917249 false ) 
	#(68 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4836353 false ) 
	#(54 2 #reduceActionForCascade1: 3939331 false ) 
	#(83 0 #reduceActionFor_period___period__1: 6032385 false ) 
	#(35 3 #reduceActionForMethodPattern6: 2450438 false ) 
	#(47 3 #reduceActionForTemporaries1: 3527681 false ) 
	#(48 2 #reduceActionForPragma__pragma__2: 3560450 false ) 
	#(40 3 #reduceActionForPragma1: 2851841 false ) 
	#(41 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 2946050 false ) 
	#(41 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 2946049 false ) 
	#(40 3 #reduceActionForPragma2: 2851842 false ) 
	#(42 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 2946050 false ) 
	#(40 3 #reduceActionForPragma4: 2851844 false ) 
	#(44 3 #reduceActionForMethodSequence6: 3240966 false ) 
	#(44 3 #reduceActionForMethodSequence7: 3240967 false ) 
	#(50 1 #reduceActionForPragma__pragma__1: 3631105 false ) 
	#(49 2 #reduceActionForStatements2: 3602434 false ) 
	#(44 3 #reduceActionForMethodSequence3: 3240963 false ) 
	#(46 3 #reduceActionForSequence4: 3462148 false ) 
	#(72 3 #reduceActionForArray2: 5158914 false ) 
	#(76 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5442561 false ) 
	#(78 2 #reduceActionForBlockArgs2: 5614594 false ) 
	#(75 3 #reduceActionForBlock2: 5310466 false ) 
	#(77 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5442562 false ) 
	#(71 3 #reduceActionForValue5: 4999173 false ) 
	#(85 3 #reduceActionForByteArrayLiteral1: 6483969 false ) 
	#(87 1 #liftFirstValue: 6602753 false ) 
	#(86 2 #reduceActionForPragma__pragma__2: 6535170 false ) 
	#(87 1 #reduceActionForValue6: 6602754 false ) 
	#(56 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4137985 false ) 
	#(58 1 #liftFirstValue: 4195329 false ) 
	#(58 1 #liftFirstValue: 4195330 false ) 
	#(58 1 #liftFirstValue: 4195331 false ) 
	#(57 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4137986 false ) 
	#(62 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4458497 false ) 
	#(66 2 #reduceActionForBinaryMessage1: 4689921 false ) 
	#(63 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4458498 false ) 
	#(53 3 #reduceActionForAssignment1: 3837953 false ) 
	#(93 0 #reduceActionForEndLiteralArray1: 6938625 false ) 
	#(44 4 #reduceActionForMethodSequence1: 3240961 false ) 
	#(44 4 #reduceActionForMethodSequence8: 3240968 false ) 
	#(50 2 #reduceActionForPragma__pragma__2: 3631106 false ) 
	#(51 3 #reduceActionForStatementList2: 3654658 false ) 
	#(44 4 #reduceActionForMethodSequence4: 3240964 false ) 
	#(72 4 #reduceActionForArray3: 5158915 false ) 
	#(74 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5213186 false ) 
	#(75 4 #reduceActionForBlock1: 5310465 false ) 
	#(75 4 #reduceActionForBlock3: 5310467 false ) 
	#(84 1 #reduceActionForSymbolLiteral1: 6110211 false ) 
	#(84 1 #reduceActionForSymbolLiteral1: 6110210 false ) 
	#(84 1 #reduceActionForSymbolLiteral1: 6110212 false ) 
	#(84 1 #reduceActionForSymbolLiteral1: 6110214 false ) 
	#(84 1 #reduceActionForSymbolLiteral1: 6110213 false ) 
	#(84 1 #liftFirstValue: 6110209 false ) 
	#(83 2 #reduceActionForPragma__pragma__2: 6032386 false ) 
	#(84 1 #reduceActionForValue6: 6110216 false ) 
	#(44 5 #reduceActionForMethodSequence2: 3240962 false ) 
	#(72 5 #reduceActionForArray4: 5158916 false ) 
	#(73 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5213185 false ) 
	#(82 5 #reduceActionForArrayLiteral1: 5960705 false ) 
	#(84 3 #reduceActionForArrayLiteralValue7: 6110215 false )
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> scannerClass [
	^GtPharoScanner
]

{ #category : #generated }
GtPharoParser class >> startingStateForMethod [
	^ 1
]

{ #category : #generated }
GtPharoParser class >> startingStateForMethodPattern [
	^ 4
]

{ #category : #generated }
GtPharoParser class >> startingStateForMethodSequence [
	^ 2
]

{ #category : #generated }
GtPharoParser class >> startingStateForStatement [
	^ 3
]

{ #category : #generated }
GtPharoParser class >> symbolNames [
	^ #('<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value''))' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value''))+' 'KeywordPattern' 'MethodSequence' '<period> ''period''*' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' '<period> ''period''+' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'Variable' 'Value' 'Array' '(<period> ''period'' Assignment ''value'')' '(<period> ''period'' Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' 'E O F' 'error')
]

{ #category : #generated }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoVariableNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoParser class >> transitionTable [
^#(
#[1 0 21 0 4 0 25 0 25 0 29 0 26 0 33 0 34 0 37 0 35 0 41 0 36 0 45 0 37 0 49 0 43] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 61 0 38 0 65 0 39 0 69 0 40 0 73 0 44 0 77 0 45 0 73 0 46 0 85 0 47 0 6 0 94 0 6 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 145 0 52 0 145 0 53 0 145 0 54 0 145 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 237 0 95] 
#[1 0 21 0 4 0 25 0 25 0 29 0 26 0 241 0 35 0 41 0 36 0 45 0 37 0 49 0 43] 
#[0 0 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[1 0 101 0 4 0 245 0 70 0 249 0 95] 
#[1 0 101 0 4 0 253 0 70 1 1 0 95] 
#[0 0 0 0 94] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 61 0 38 0 65 0 39 0 69 0 40 1 5 0 44 0 77 0 45 1 5 0 46 0 85 0 47 0 6 0 94 0 6 0 95] 
#[0 0 18 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 94 0 95] 
#[1 0 22 0 1 0 22 0 2 0 22 0 3 0 22 0 4 0 22 0 6 0 22 0 7 0 22 0 8 0 22 0 9 0 22 0 10 0 22 0 11 0 22 0 13 0 22 0 14 0 22 0 16 0 22 0 17 0 22 0 19 0 22 0 20 0 22 0 21 1 9 0 25 0 22 0 29 1 13 0 36 0 22 0 94 0 22 0 95] 
#[0 0 26 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[1 0 30 0 4 0 30 0 6 1 17 0 48] 
#[1 1 21 0 4 1 25 0 25 1 29 0 41 1 33 0 42 1 37 0 95] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 1 41 0 45 1 45 0 47 0 6 0 94 0 6 0 95] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 34 0 4 0 34 0 6 0 34 0 7 0 34 0 8 0 34 0 9 0 34 0 10 0 34 0 11 0 34 0 13 0 57 0 14 0 34 0 16 0 34 0 17 0 34 0 19 0 34 0 20 0 34 0 21 0 34 0 29 1 49 0 40 0 34 0 94 0 34 0 95] 
#[0 0 38 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 0 0 0 94] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 42 0 23 1 53 0 29 1 57 0 49 1 61 0 51 1 65 0 52 1 65 0 53 1 65 0 54 1 65 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 42 0 94 0 7 0 95] 
#[0 0 46 0 94] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 1 69 0 38 0 65 0 39 0 69 0 40 1 73 0 45 0 6 0 94 0 6 0 95] 
#[0 0 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 62 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 94 0 95] 
#[0 0 66 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 70 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 74 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 78 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 82 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 77 0 53 1 77 0 54 1 77 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 237 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 81 0 24 1 85 0 29 1 89 0 53 1 89 0 54 1 89 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 237 0 95] 
#[1 0 86 0 1 0 86 0 2 0 86 0 3 0 86 0 4 0 86 0 6 0 86 0 7 0 86 0 8 0 86 0 9 0 86 0 10 0 86 0 11 0 86 0 13 0 86 0 16 0 86 0 17 1 93 0 18 0 86 0 19 0 86 0 20 0 86 0 21 0 86 0 23 0 86 0 29 1 97 0 76 1 101 0 77 1 105 0 78 0 86 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 109 0 53 1 109 0 54 1 109 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 237 0 95] 
#[1 0 90 0 10 0 90 0 11 0 90 0 23 1 113 0 86 0 90 0 95] 
#[0 0 0 0 94] 
#[0 0 94 0 23 0 29 0 94 0 95] 
#[0 0 98 0 22 0 23 0 24 0 29 0 94 0 95] 
#[0 0 102 0 22 0 23 0 24 0 29 0 94 0 95] 
#[1 0 106 0 22 0 106 0 23 0 106 0 24 1 117 0 27 0 106 0 29 1 121 0 55 1 125 0 56 1 129 0 57 0 106 0 94 0 106 0 95] 
#[1 0 110 0 22 0 110 0 23 0 110 0 24 1 133 0 25 1 137 0 26 0 110 0 29 1 141 0 61 1 145 0 62 1 149 0 63 1 153 0 66 0 110 0 94 0 110 0 95] 
#[1 0 114 0 22 0 114 0 23 0 114 0 24 0 114 0 25 0 114 0 26 1 117 0 27 0 114 0 29 1 157 0 55 1 125 0 56 1 129 0 57 0 114 0 94 0 114 0 95] 
#[1 1 161 0 4 0 118 0 22 0 118 0 23 0 118 0 24 0 118 0 25 0 118 0 26 0 118 0 27 0 118 0 29 1 165 0 69 0 118 0 94 0 118 0 95] 
#[1 0 122 0 4 0 122 0 22 0 122 0 23 0 122 0 24 0 122 0 25 0 122 0 26 1 117 0 27 0 122 0 29 1 169 0 55 1 125 0 56 1 129 0 57 0 122 0 94 0 122 0 95] 
#[1 0 126 0 4 0 126 0 22 0 126 0 23 0 126 0 24 0 126 0 25 0 126 0 26 1 173 0 28 0 126 0 29 0 126 0 94 0 126 0 95] 
#[0 0 130 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 134 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 138 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 142 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 146 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 150 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 154 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 158 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 162 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 166 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 170 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 174 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 177 0 20] 
#[0 0 178 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 0 0 94] 
#[0 0 182 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 94 0 95] 
#[0 0 186 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 0 190 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 0 194 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 0 198 0 94] 
#[1 0 101 0 4 0 245 0 70 1 181 0 95] 
#[0 0 202 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 94 0 95] 
#[1 0 101 0 4 1 185 0 6 1 189 0 70] 
#[0 1 193 0 15] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 10 0 20 0 141 0 21 1 197 0 70 1 201 0 79 1 201 0 80 1 201 0 81 1 201 0 82 1 201 0 85 1 201 0 88 1 201 0 89 1 201 0 90 1 201 0 91 0 233 0 92] 
#[0 0 206 0 15 0 25] 
#[1 1 205 0 15 1 25 0 25 1 209 0 41] 
#[1 0 210 0 1 0 210 0 2 0 210 0 3 0 210 0 4 0 210 0 6 0 210 0 7 0 210 0 8 0 210 0 9 0 210 0 10 0 210 0 11 0 210 0 13 0 210 0 14 1 213 0 15 0 210 0 16 0 210 0 17 0 210 0 19 0 210 0 20 0 210 0 21 0 210 0 29 0 210 0 94 0 210 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 53 0 29 1 217 0 49 1 61 0 51 1 65 0 52 1 65 0 53 1 65 0 54 1 65 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 214 0 94 0 237 0 95] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 1 221 0 38 0 65 0 39 0 69 0 40 1 225 0 45 0 6 0 94 0 6 0 95] 
#[0 0 218 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 0 222 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 94 0 95] 
#[0 0 226 0 23 0 94 0 95] 
#[1 0 230 0 23 1 229 0 29 1 233 0 50 0 230 0 94 0 230 0 95] 
#[0 0 234 0 23 0 29 0 94 0 95] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 1 237 0 45 0 6 0 94 0 6 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 238 0 23 1 53 0 29 1 241 0 49 1 61 0 51 1 65 0 52 1 65 0 53 1 65 0 54 1 65 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 238 0 94 0 11 0 95] 
#[0 0 242 0 23 0 29 0 94 0 95] 
#[0 0 246 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 245 0 24] 
#[1 0 250 0 24 0 250 0 29 1 249 0 74] 
#[1 0 101 0 4 1 253 0 70] 
#[0 0 254 0 6 0 18 0 23] 
#[1 2 1 0 6 1 93 0 18 2 5 0 23 2 9 0 76] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 0 77 0 45 2 13 0 46 2 17 0 47 0 6 0 95] 
#[0 2 21 0 22] 
#[1 0 117 0 10 0 121 0 11 2 25 0 23 2 33 0 81 2 33 0 87 2 37 0 95] 
#[1 1 161 0 4 1 133 0 25 1 137 0 26 2 41 0 58 2 41 0 61 1 145 0 62 1 149 0 63 2 41 0 66 2 41 0 69] 
#[0 1 2 0 22 0 23 0 24 0 29 0 94 0 95] 
#[0 1 6 0 22 0 23 0 24 0 27 0 29 0 94 0 95] 
#[1 1 10 0 22 1 10 0 23 1 10 0 24 1 117 0 27 1 10 0 29 2 57 0 56 1 10 0 94 1 10 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 2 61 0 64 2 65 0 65 0 173 0 67 2 69 0 68 0 173 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 237 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 2 77 0 67 2 69 0 68 2 77 0 70 2 77 0 71 2 77 0 72 2 77 0 75 2 77 0 79 2 77 0 80 2 77 0 81 2 77 0 82 2 77 0 85 2 77 0 88 2 77 0 89 2 77 0 90 2 77 0 91 0 233 0 92 0 237 0 95] 
#[0 1 14 0 22 0 23 0 24 0 27 0 29 0 94 0 95] 
#[0 1 18 0 22 0 23 0 24 0 25 0 27 0 29 0 94 0 95] 
#[1 1 22 0 22 1 22 0 23 1 22 0 24 1 133 0 25 1 22 0 27 1 22 0 29 2 81 0 62 1 22 0 94 1 22 0 95] 
#[0 1 26 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 30 0 22 0 23 0 24 0 29 0 94 0 95] 
#[0 1 34 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 38 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 42 0 22 0 23 0 24 0 29 0 94 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 2 85 0 53 2 85 0 54 2 85 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 237 0 95] 
#[1 1 46 0 1 1 46 0 2 1 46 0 3 1 46 0 4 1 46 0 7 1 46 0 8 1 46 0 9 1 46 0 10 1 46 0 11 1 46 0 12 1 46 0 19 1 46 0 20 1 46 0 21 1 46 0 22 1 46 0 26 1 46 0 27 1 46 0 29 2 89 0 83 1 46 0 95] 
#[0 1 50 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 1 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 94 0 95] 
#[0 1 58 0 4 0 6] 
#[0 1 62 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 1 66 0 15 0 25] 
#[0 1 70 0 15 0 25] 
#[0 1 74 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 1 78 0 15 0 25] 
#[0 1 82 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 94 0 95] 
#[0 1 86 0 94] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 2 93 0 45 0 6 0 94 0 6 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 53 0 29 2 97 0 49 1 61 0 51 1 65 0 52 1 65 0 53 1 65 0 54 1 65 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 1 90 0 94 0 237 0 95] 
#[0 1 94 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 94 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 98 0 23 2 101 0 29 2 105 0 52 2 105 0 53 2 105 0 54 2 105 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 1 98 0 94 0 15 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 53 0 29 2 109 0 49 1 61 0 51 1 65 0 52 1 65 0 53 1 65 0 54 1 65 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 1 102 0 94 0 237 0 95] 
#[0 1 106 0 23 0 94 0 95] 
#[0 1 110 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[1 2 113 0 24 2 117 0 29 2 121 0 73] 
#[0 1 114 0 6 0 18 0 23] 
#[0 1 118 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 95] 
#[0 1 122 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 126 0 6 0 18 0 23] 
#[1 2 125 0 23 2 129 0 95] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 1 73 0 45 0 6 0 95] 
#[0 1 130 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 134 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 138 0 10 0 11 0 23 0 95] 
#[0 1 142 0 10 0 11 0 23 0 95] 
#[0 1 146 0 10 0 11 0 23 0 95] 
#[0 1 150 0 22 0 23 0 24 0 27 0 29 0 94 0 95] 
#[0 1 154 0 22 0 23 0 24 0 27 0 29 0 94 0 95] 
#[0 1 158 0 22 0 23 0 24 0 27 0 29 0 94 0 95] 
#[0 1 162 0 22 0 23 0 24 0 27 0 29 0 94 0 95] 
#[0 1 166 0 22 0 23 0 24 0 27 0 29 0 94 0 95] 
#[1 1 170 0 22 1 170 0 23 1 170 0 24 1 170 0 25 1 137 0 26 1 170 0 27 1 170 0 29 1 153 0 66 1 170 0 94 1 170 0 95] 
#[0 0 114 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 122 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 0 126 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[1 1 161 0 4 1 174 0 22 1 174 0 23 1 174 0 24 1 174 0 25 1 174 0 26 1 174 0 27 1 174 0 29 1 165 0 69 1 174 0 94 1 174 0 95] 
#[0 1 178 0 22 0 23 0 24 0 25 0 27 0 29 0 94 0 95] 
#[0 1 182 0 22 0 23 0 24 0 29 0 94 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 2 133 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 2 137 0 12 2 141 0 19 0 10 0 20 0 141 0 21 1 186 0 22 2 145 0 26 2 149 0 27 2 153 0 29 2 161 0 79 2 161 0 80 2 161 0 81 2 161 0 82 2 161 0 84 2 161 0 85 2 161 0 88 2 161 0 89 2 161 0 90 2 161 0 91 0 233 0 92 2 165 0 93 2 169 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 53 0 29 2 173 0 49 1 61 0 51 1 65 0 52 1 65 0 53 1 65 0 54 1 65 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 1 190 0 94 0 237 0 95] 
#[0 1 194 0 94] 
#[0 1 198 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 94 0 95] 
#[0 1 202 0 23 0 29 0 94 0 95] 
#[0 1 206 0 94] 
#[0 1 210 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 2 177 0 24 2 181 0 53 2 181 0 54 2 181 0 59 0 161 0 60 0 165 0 64 0 169 0 65 0 173 0 67 0 177 0 68 0 181 0 70 0 173 0 71 0 173 0 72 0 173 0 75 0 173 0 79 0 173 0 80 0 173 0 81 0 173 0 82 0 173 0 85 0 173 0 88 0 173 0 89 0 173 0 90 0 173 0 91 0 233 0 92 0 237 0 95] 
#[0 1 214 0 24 0 29] 
#[0 1 218 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 222 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 1 226 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[0 1 230 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[1 1 46 0 1 1 46 0 2 1 46 0 3 1 46 0 4 1 46 0 7 1 46 0 8 1 46 0 9 1 46 0 10 1 46 0 11 1 46 0 12 1 46 0 19 1 46 0 20 1 46 0 21 1 46 0 22 1 46 0 26 1 46 0 27 1 46 0 29 2 185 0 83 1 46 0 95] 
#[0 1 234 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[0 1 238 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[0 1 242 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[0 1 246 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[0 1 250 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[0 2 189 0 22] 
#[0 1 254 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95] 
#[0 2 2 0 94] 
#[0 2 6 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 2 10 0 24 0 29] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 2 133 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 2 137 0 12 2 141 0 19 0 10 0 20 0 141 0 21 2 193 0 22 2 145 0 26 2 149 0 27 2 153 0 29 2 161 0 79 2 161 0 80 2 161 0 81 2 161 0 82 2 161 0 84 2 161 0 85 2 161 0 88 2 161 0 89 2 161 0 90 2 161 0 91 0 233 0 92 2 169 0 95] 
#[0 2 14 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 94 0 95] 
#[0 2 18 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 95]
	).
]

{ #category : #private }
GtPharoParser >> actionsForCurrentToken [
	| actions |
	actions := super actionsForCurrentToken.
	actions isEmpty
		ifTrue: [ (currentToken ids includes: scanner binaryId)
				ifTrue: [ (#('|' '<' '>') includes: currentToken value)
						ifTrue: [ self addActionsFor: scanner binaryId to: actions ]
						ifFalse: [ (#('||' '|||') includes: currentToken value)
								ifTrue: [ currentToken := currentToken class value: '|' start: currentToken startPosition ids: (Array with: scanner barId).
									self position: currentToken startPosition.
									actions := super actionsForCurrentToken ] ] ].
			(currentToken ids includes: scanner negativeNumberId)
				ifTrue: [ self addActionsFor: scanner binaryId to: actions.
					actions notEmpty
						ifTrue: [ currentToken := currentToken class value: '-' start: currentToken startPosition ids: (Array with: scanner binaryId).
							self position: currentToken startPosition ] ].
			(currentToken ids includes: scanner nameId)
				ifTrue: [ self addActionsFor: scanner nameId to: actions ].
			(currentToken ids includes: scanner nameAssignmentId)
				ifTrue: [ self addActionsFor: scanner nameId to: actions.
					actions notEmpty
						ifTrue:
							[ currentToken := currentToken class value: (currentToken value copyFrom: 1 to: currentToken value size - 2) start: currentToken startPosition ids: (Array with: scanner nameId).
							self position: scanner position - 2 ] ] ].
	^ actions
]

{ #category : #private }
GtPharoParser >> endLiteralArray [
	(nodeStack
		inject: 0
		into: [ :sum :each | 
			sum
				+
					(each == #array
						ifTrue: [ 1 ]
						ifFalse: [ 0 ]) ]) = 1
		ifTrue: [ self scope: #default ]
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArray1: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result rightBrace: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArray2: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addToken: (nodes at: 2) to: result periods.
	result rightBrace: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArray3: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 2) to: result values.
	result addTokens: ((nodes at: 3) at: 1) to: result periods.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	result rightBrace: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArray4: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 2) to: result values.
	result addTokens: ((nodes at: 3) at: 1) to: result periods.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	result addToken: (nodes at: 4) to: result periods.
	result rightBrace: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArrayLiteral1: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 2).
	result addNodes: (nodes at: 3) to: result values.
	result arrayStop: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArrayLiteralValue7: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForAssignment1: nodes [
	| result |
	result := GtPharoAssignmentNode new.
	result variable: (nodes at: 1).
	result assignmentToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBinaryMessage1: nodes [
	| result |
	result := GtPharoBinaryMessageNode new.
	result selectorPart: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBlock1: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 3).
	result rightBracket: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBlock2: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBracket: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBlock3: nodes [
	| result |
	result := GtPharoBlockErrorNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 3).
	result smaccError: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBlockArgs1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBlockArgs2: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 1) at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBooleanLiteral1: nodes [
	| result |
	result := GtPharoBooleanLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForByteArrayLiteral1: nodes [
	| result |
	result := GtPharoByteArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForCascade1: nodes [
	| result |
	result := GtPharoCascadeNode new.
	result receiver: ((nodes at: 1) at: 1).
	result addNode: ((nodes at: 1) at: 2) to: result messages.
	result addTokens: ((nodes at: 2) at: 1) to: result semicolons.
	result addNodes: ((nodes at: 2) at: 2) to: result messages.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForCharacterLiteral1: nodes [
	| result |
	result := GtPharoCharacterLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForEndLiteralArray1: nodes [
	self endLiteralArray.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordMessage1: nodes [
	| result |
	result := GtPharoKeywordMessageNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result values.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordMessageSend1: nodes [
	| result |
	result := GtPharoMessageSendNode new.
	result receiver: ((nodes at: 1) at: 1).
	result message: ((nodes at: 1) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordPattern1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethod1: nodes [
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 1).
	result body: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern1: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern2: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern5: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern6: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addToken: (nodes at: 2) to: result selectorParts.
	result smaccError: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence1: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addTokens: (nodes at: 4) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence2: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addTokens: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addTokens: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence3: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addTokens: (nodes at: 3) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence4: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addTokens: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addTokens: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence5: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addTokens: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence6: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addTokens: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence7: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addTokens: (nodes at: 3) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence8: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addTokens: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addTokens: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForNilLiteral1: nodes [
	| result |
	result := GtPharoNilLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForNumberLiteral1: nodes [
	| result |
	result := GtPharoNumberLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma1: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addToken: (nodes at: 2) to: result selectorParts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma2: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result values.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma3: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma4: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma__pragma__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma__pragma__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence1: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addTokens: (nodes at: 1) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence2: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addTokens: (nodes at: 1) to: result periods.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addTokens: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence3: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addTokens: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence4: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addTokens: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatement1: nodes [
	| result |
	result := GtPharoReturnNode new.
	result upArrow: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatementList1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatementList2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatements2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStringLiteral1: nodes [
	| result |
	result := GtPharoStringLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSwitchToLiteralArray1: nodes [
	self scope: #literalArray.
	^ #array
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbolLiteral1: nodes [
	| result |
	result := GtPharoSymbolLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemporaries1: nodes [
	| result |
	result := Array new: 3.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: (nodes at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForUnaryMessage1: nodes [
	| result |
	result := GtPharoUnaryMessageNode new.
	result selectorPart: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForValue5: nodes [
	| result |
	result := nodes at: 2.
	result addFirstToken: (nodes at: 1) to: result leftParens.
	result addToken: (nodes at: 3) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForValue6: nodes [
	| result |
	result := GtPharoErrorNode new.
	result smaccError: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForVariable1: nodes [
	| result |
	result := GtPharoVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__keyword___selectorPart__Variable__variable__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__keyword___selectorPart__Variable__variable___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__keyword___selectorPart__Variable__variable___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__period___period__Assignment__value___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_period___period__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]
