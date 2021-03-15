Class {
	#name : #GtPharoParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 42 1 9] 
#[ 1 9 1 10] 
#[ 1 9 1 126]
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2021-03-14T12:56:32.515751+01:00'
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
%hierarchy Variable (SelfVariable SuperVariable ThisContextVariable NamedVariable);

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
default literalArray <self>
	: self
	;
default literalArray <super>
	: super
	;
default literalArray <thisContext>
	: thisContext
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
	: SelfVariable
	| SuperVariable
	| ThisContextVariable
	| NamedVariable
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
	;
SelfVariable
	: <self> 'name' {{}}
	;
SuperVariable
	: <super> 'name' {{}}
	;
NamedVariable
	: <name> 'name' {{}}
	;
ThisContextVariable
	: <thisContext> 'name' {{}}
	;"
]

{ #category : #generated }
GtPharoParser class >> reduceTable [
^#(
	#(48 0 #reduceActionFor_period___period__1: 3510273 false ) 
	#(95 0 #reduceActionForSwitchToLiteralArray1: 7148545 false ) 
	#(38 1 #reduceActionForMethodPattern1: 2672641 false ) 
	#(40 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 2927617 false ) 
	#(46 1 #reduceActionForKeywordPattern1: 3392513 false ) 
	#(38 1 #reduceActionForMethodPattern3: 2672643 false ) 
	#(51 0 #reduceActionFor_period___period__1: 3782657 false ) 
	#(41 1 #reduceActionForKeywordPattern1: 3042305 false ) 
	#(42 1 #reduceActionForPragma__pragma__1: 3053569 false ) 
	#(49 1 #reduceActionForSequence1: 3684353 false ) 
	#(47 1 #liftFirstValue: 3463177 false ) 
	#(93 1 #reduceActionForBooleanLiteral1: 7045121 false ) 
	#(93 1 #reduceActionForBooleanLiteral1: 7045122 false ) 
	#(94 1 #reduceActionForNilLiteral1: 7111681 false ) 
	#(99 1 #reduceActionForNamedVariable1: 7344129 false ) 
	#(83 1 #reduceActionForStringLiteral1: 6115329 false ) 
	#(92 1 #reduceActionForSymbolLiteral1: 7002113 false ) 
	#(91 1 #reduceActionForCharacterLiteral1: 6952961 false ) 
	#(84 1 #reduceActionForNumberLiteral1: 6158337 false ) 
	#(84 1 #reduceActionForNumberLiteral1: 6158338 false ) 
	#(81 0 #reduceActionForBlockArgs1: 5889025 false ) 
	#(89 0 #reduceActionFor_period___period__1: 6809601 false ) 
	#(97 1 #reduceActionForSelfVariable1: 7264257 false ) 
	#(98 1 #reduceActionForSuperVariable1: 7303169 false ) 
	#(100 1 #reduceActionForThisContextVariable1: 7384065 false ) 
	#(55 1 #liftFirstValue: 3979266 false ) 
	#(56 1 #liftFirstValue: 4060162 false ) 
	#(57 1 #liftFirstValue: 4161540 false ) 
	#(62 1 #reduceActionForKeywordMessageSend1: 4489217 false ) 
	#(62 1 #liftFirstValue: 4489218 false ) 
	#(67 1 #reduceActionForKeywordMessageSend1: 4744193 false ) 
	#(67 1 #liftFirstValue: 4744194 false ) 
	#(70 1 #reduceActionForKeywordMessageSend1: 4987905 false ) 
	#(74 1 #liftFirstValue: 5273601 false ) 
	#(70 1 #liftFirstValue: 4987906 false ) 
	#(74 1 #liftFirstValue: 5273603 false ) 
	#(74 1 #liftFirstValue: 5273604 false ) 
	#(74 1 #liftFirstValue: 5273602 false ) 
	#(82 1 #liftFirstValue: 5961729 false ) 
	#(82 1 #liftFirstValue: 5961730 false ) 
	#(82 1 #liftFirstValue: 5961731 false ) 
	#(82 1 #liftFirstValue: 5961732 false ) 
	#(82 1 #liftFirstValue: 5961733 false ) 
	#(82 1 #liftFirstValue: 5961734 false ) 
	#(82 1 #liftFirstValue: 5961735 false ) 
	#(82 1 #liftFirstValue: 5961736 false ) 
	#(73 1 #liftFirstValue: 5186561 false ) 
	#(73 1 #liftFirstValue: 5186562 false ) 
	#(73 1 #liftFirstValue: 5186564 false ) 
	#(73 1 #liftFirstValue: 5186563 false ) 
	#(74 1 #reduceActionForValue6: 5273606 false ) 
	#(39 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 2927617 false ) 
	#(38 2 #reduceActionForMethodPattern5: 2672645 false ) 
	#(38 2 #reduceActionForMethodPattern2: 2672642 false ) 
	#(38 2 #reduceActionForMethodPattern5: 2672644 false ) 
	#(37 2 #reduceActionForMethod1: 2607105 false ) 
	#(40 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 2927618 false ) 
	#(45 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3168257 false ) 
	#(43 2 #reduceActionForPragma3: 3074051 false ) 
	#(47 2 #reduceActionForMethodSequence5: 3463173 false ) 
	#(42 2 #reduceActionForPragma__pragma__2: 3053570 false ) 
	#(48 2 #reduceActionForPragma__pragma__2: 3510274 false ) 
	#(49 2 #reduceActionForSequence2: 3684354 false ) 
	#(52 1 #reduceActionForKeywordPattern1: 3824641 false ) 
	#(54 1 #reduceActionForStatementList1: 3876865 false ) 
	#(49 2 #reduceActionForSequence3: 3684355 false ) 
	#(55 2 #reduceActionForStatement1: 3979265 false ) 
	#(75 2 #reduceActionForArray1: 5433345 false ) 
	#(77 0 #reduceActionFor__period___period__Assignment__value___1: 5487617 false ) 
	#(80 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5716993 false ) 
	#(57 2 #reduceActionForCascade1: 4161537 false ) 
	#(60 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4360193 false ) 
	#(58 1 #reduceActionForKeywordPattern1: 4339713 false ) 
	#(63 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4576257 false ) 
	#(66 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4680705 false ) 
	#(64 1 #reduceActionForKeywordMessage1: 4662273 false ) 
	#(68 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4828161 false ) 
	#(57 2 #reduceActionForCascade1: 4161538 false ) 
	#(72 1 #reduceActionForUnaryMessage1: 5139457 false ) 
	#(71 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5058561 false ) 
	#(57 2 #reduceActionForCascade1: 4161539 false ) 
	#(86 0 #reduceActionFor_period___period__1: 6306817 false ) 
	#(38 3 #reduceActionForMethodPattern6: 2672646 false ) 
	#(50 3 #reduceActionForTemporaries1: 3749889 false ) 
	#(51 2 #reduceActionForPragma__pragma__2: 3782658 false ) 
	#(43 3 #reduceActionForPragma1: 3074049 false ) 
	#(44 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3168258 false ) 
	#(44 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3168257 false ) 
	#(43 3 #reduceActionForPragma2: 3074050 false ) 
	#(45 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3168258 false ) 
	#(43 3 #reduceActionForPragma4: 3074052 false ) 
	#(47 3 #reduceActionForMethodSequence6: 3463174 false ) 
	#(47 3 #reduceActionForMethodSequence7: 3463175 false ) 
	#(53 1 #reduceActionForPragma__pragma__1: 3853313 false ) 
	#(52 2 #reduceActionForStatements2: 3824642 false ) 
	#(47 3 #reduceActionForMethodSequence3: 3463171 false ) 
	#(49 3 #reduceActionForSequence4: 3684356 false ) 
	#(75 3 #reduceActionForArray2: 5433346 false ) 
	#(79 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5716993 false ) 
	#(81 2 #reduceActionForBlockArgs2: 5889026 false ) 
	#(78 3 #reduceActionForBlock2: 5584898 false ) 
	#(80 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5716994 false ) 
	#(74 3 #reduceActionForValue5: 5273605 false ) 
	#(88 3 #reduceActionForByteArrayLiteral1: 6758401 false ) 
	#(90 1 #liftFirstValue: 6877185 false ) 
	#(89 2 #reduceActionForPragma__pragma__2: 6809602 false ) 
	#(90 1 #reduceActionForValue6: 6877186 false ) 
	#(59 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4360193 false ) 
	#(61 1 #liftFirstValue: 4417537 false ) 
	#(61 1 #liftFirstValue: 4417538 false ) 
	#(61 1 #liftFirstValue: 4417539 false ) 
	#(60 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4360194 false ) 
	#(65 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4680705 false ) 
	#(69 2 #reduceActionForBinaryMessage1: 4912129 false ) 
	#(66 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4680706 false ) 
	#(56 3 #reduceActionForAssignment1: 4060161 false ) 
	#(96 0 #reduceActionForEndLiteralArray1: 7213057 false ) 
	#(47 4 #reduceActionForMethodSequence1: 3463169 false ) 
	#(47 4 #reduceActionForMethodSequence8: 3463176 false ) 
	#(53 2 #reduceActionForPragma__pragma__2: 3853314 false ) 
	#(54 3 #reduceActionForStatementList2: 3876866 false ) 
	#(47 4 #reduceActionForMethodSequence4: 3463172 false ) 
	#(75 4 #reduceActionForArray3: 5433347 false ) 
	#(77 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5487618 false ) 
	#(78 4 #reduceActionForBlock1: 5584897 false ) 
	#(78 4 #reduceActionForBlock3: 5584899 false ) 
	#(87 1 #reduceActionForSymbolLiteral1: 6384643 false ) 
	#(87 1 #reduceActionForSymbolLiteral1: 6384642 false ) 
	#(87 1 #reduceActionForSymbolLiteral1: 6384644 false ) 
	#(87 1 #reduceActionForSymbolLiteral1: 6384646 false ) 
	#(87 1 #reduceActionForSymbolLiteral1: 6384645 false ) 
	#(87 1 #liftFirstValue: 6384641 false ) 
	#(86 2 #reduceActionForPragma__pragma__2: 6306818 false ) 
	#(87 1 #reduceActionForValue6: 6384648 false ) 
	#(47 5 #reduceActionForMethodSequence2: 3463170 false ) 
	#(75 5 #reduceActionForArray4: 5433348 false ) 
	#(76 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5487617 false ) 
	#(85 5 #reduceActionForArrayLiteral1: 6235137 false ) 
	#(87 3 #reduceActionForArrayLiteralValue7: 6384647 false )
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
	^ #('<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' '<self>' '<super>' '<thisContext>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value''))' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value''))+' 'KeywordPattern' 'MethodSequence' '<period> ''period''*' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' '<period> ''period''+' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'Variable' 'Value' 'Array' '(<period> ''period'' Assignment ''value'')' '(<period> ''period'' Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' 'SelfVariable' 'SuperVariable' 'NamedVariable' 'ThisContextVariable' 'E O F' 'error')
]

{ #category : #generated }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoVariableNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #GtPharoSelfVariableNode #GtPharoSuperVariableNode #GtPharoNamedVariableNode #GtPharoThisContextVariableNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoParser class >> transitionTable [
^#(
#[1 0 21 0 4 0 25 0 25 0 29 0 26 0 33 0 37 0 37 0 38 0 41 0 39 0 45 0 40 0 49 0 46] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 61 0 41 0 65 0 42 0 69 0 43 0 73 0 47 0 77 0 48 0 73 0 49 0 85 0 50 0 6 0 101 0 6 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 145 0 33 0 149 0 34 0 153 0 35 0 157 0 55 0 157 0 56 0 157 0 57 0 157 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 9 0 102] 
#[1 0 21 0 4 0 25 0 25 0 29 0 26 1 13 0 38 0 41 0 39 0 45 0 40 0 49 0 46] 
#[0 0 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[1 0 101 0 4 0 145 0 33 0 149 0 34 0 153 0 35 1 17 0 73 1 17 0 97 1 17 0 98 1 17 0 99 1 17 0 100 1 21 0 102] 
#[1 0 101 0 4 0 145 0 33 0 149 0 34 0 153 0 35 1 25 0 73 1 25 0 97 1 25 0 98 1 25 0 99 1 25 0 100 1 29 0 102] 
#[0 0 0 0 101] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 61 0 41 0 65 0 42 0 69 0 43 1 33 0 47 0 77 0 48 1 33 0 49 0 85 0 50 0 6 0 101 0 6 0 102] 
#[0 0 18 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 33 0 34 0 35 0 101 0 102] 
#[1 0 22 0 1 0 22 0 2 0 22 0 3 0 22 0 4 0 22 0 6 0 22 0 7 0 22 0 8 0 22 0 9 0 22 0 10 0 22 0 11 0 22 0 13 0 22 0 14 0 22 0 16 0 22 0 17 0 22 0 19 0 22 0 20 0 22 0 21 1 37 0 25 0 22 0 29 0 22 0 33 0 22 0 34 0 22 0 35 1 41 0 39 0 22 0 101 0 22 0 102] 
#[0 0 26 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[1 0 30 0 4 0 30 0 6 0 30 0 33 0 30 0 34 0 30 0 35 1 45 0 51] 
#[1 1 49 0 4 1 53 0 25 1 57 0 44 1 61 0 45 1 65 0 102] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 1 69 0 48 1 73 0 50 0 6 0 101 0 6 0 102] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 34 0 4 0 34 0 6 0 34 0 7 0 34 0 8 0 34 0 9 0 34 0 10 0 34 0 11 0 34 0 13 0 57 0 14 0 34 0 16 0 34 0 17 0 34 0 19 0 34 0 20 0 34 0 21 0 34 0 29 0 34 0 33 0 34 0 34 0 34 0 35 1 77 0 43 0 34 0 101 0 34 0 102] 
#[0 0 38 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 0 0 101] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 42 0 23 1 81 0 29 0 145 0 33 0 149 0 34 0 153 0 35 1 85 0 52 1 89 0 54 1 93 0 55 1 93 0 56 1 93 0 57 1 93 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 0 42 0 101 0 7 0 102] 
#[0 0 46 0 101] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 1 97 0 41 0 65 0 42 0 69 0 43 1 101 0 48 0 6 0 101 0 6 0 102] 
#[0 0 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 62 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 66 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 70 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 74 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 78 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 82 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 145 0 33 0 149 0 34 0 153 0 35 1 105 0 56 1 105 0 57 1 105 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 9 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 109 0 24 1 113 0 29 0 145 0 33 0 149 0 34 0 153 0 35 1 117 0 56 1 117 0 57 1 117 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 9 0 102] 
#[1 0 86 0 1 0 86 0 2 0 86 0 3 0 86 0 4 0 86 0 6 0 86 0 7 0 86 0 8 0 86 0 9 0 86 0 10 0 86 0 11 0 86 0 13 0 86 0 16 0 86 0 17 1 121 0 18 0 86 0 19 0 86 0 20 0 86 0 21 0 86 0 23 0 86 0 29 0 86 0 33 0 86 0 34 0 86 0 35 1 125 0 79 1 129 0 80 1 133 0 81 0 86 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 145 0 33 0 149 0 34 0 153 0 35 1 137 0 56 1 137 0 57 1 137 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 9 0 102] 
#[1 0 90 0 10 0 90 0 11 0 90 0 23 1 141 0 89 0 90 0 102] 
#[0 0 94 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 98 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 102 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 0 0 101] 
#[0 0 106 0 23 0 29 0 101 0 102] 
#[0 0 110 0 22 0 23 0 24 0 29 0 101 0 102] 
#[0 0 114 0 22 0 23 0 24 0 29 0 101 0 102] 
#[1 0 118 0 22 0 118 0 23 0 118 0 24 1 145 0 27 0 118 0 29 1 149 0 58 1 153 0 59 1 157 0 60 0 118 0 101 0 118 0 102] 
#[1 0 122 0 22 0 122 0 23 0 122 0 24 1 161 0 25 1 165 0 26 0 122 0 29 1 169 0 64 1 173 0 65 1 177 0 66 1 181 0 69 0 122 0 101 0 122 0 102] 
#[1 0 126 0 22 0 126 0 23 0 126 0 24 0 126 0 25 0 126 0 26 1 145 0 27 0 126 0 29 1 185 0 58 1 153 0 59 1 157 0 60 0 126 0 101 0 126 0 102] 
#[1 1 189 0 4 0 130 0 22 0 130 0 23 0 130 0 24 0 130 0 25 0 130 0 26 0 130 0 27 0 130 0 29 1 193 0 72 0 130 0 101 0 130 0 102] 
#[1 0 134 0 4 0 134 0 22 0 134 0 23 0 134 0 24 0 134 0 25 0 134 0 26 1 145 0 27 0 134 0 29 1 197 0 58 1 153 0 59 1 157 0 60 0 134 0 101 0 134 0 102] 
#[1 0 138 0 4 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 1 201 0 28 0 138 0 29 0 138 0 101 0 138 0 102] 
#[0 0 142 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 146 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 150 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 154 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 158 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 162 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 166 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 170 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 174 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 178 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 186 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 205 0 20] 
#[0 0 190 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 194 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 198 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 202 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 206 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 0 0 101] 
#[0 0 210 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 214 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 218 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 222 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 226 0 101] 
#[1 0 101 0 4 0 145 0 33 0 149 0 34 0 153 0 35 1 17 0 73 1 17 0 97 1 17 0 98 1 17 0 99 1 17 0 100 1 209 0 102] 
#[0 0 230 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 33 0 34 0 35 0 101 0 102] 
#[1 0 101 0 4 1 213 0 6 0 145 0 33 0 149 0 34 0 153 0 35 1 217 0 73 1 217 0 97 1 217 0 98 1 217 0 99 1 217 0 100] 
#[0 1 221 0 15] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 10 0 20 0 141 0 21 0 145 0 33 0 149 0 34 0 153 0 35 1 225 0 73 1 229 0 82 1 229 0 83 1 229 0 84 1 229 0 85 1 229 0 88 1 229 0 91 1 229 0 92 1 229 0 93 1 229 0 94 0 245 0 95 1 225 0 97 1 225 0 98 1 225 0 99 1 225 0 100] 
#[0 0 234 0 15 0 25] 
#[1 1 233 0 15 1 53 0 25 1 237 0 44] 
#[1 0 238 0 1 0 238 0 2 0 238 0 3 0 238 0 4 0 238 0 6 0 238 0 7 0 238 0 8 0 238 0 9 0 238 0 10 0 238 0 11 0 238 0 13 0 238 0 14 1 241 0 15 0 238 0 16 0 238 0 17 0 238 0 19 0 238 0 20 0 238 0 21 0 238 0 29 0 238 0 33 0 238 0 34 0 238 0 35 0 238 0 101 0 238 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 81 0 29 0 145 0 33 0 149 0 34 0 153 0 35 1 245 0 52 1 89 0 54 1 93 0 55 1 93 0 56 1 93 0 57 1 93 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 0 242 0 101 1 9 0 102] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 57 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 1 249 0 41 0 65 0 42 0 69 0 43 1 253 0 48 0 6 0 101 0 6 0 102] 
#[0 0 246 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 250 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 0 254 0 23 0 101 0 102] 
#[1 1 2 0 23 2 1 0 29 2 5 0 53 1 2 0 101 1 2 0 102] 
#[0 1 6 0 23 0 29 0 101 0 102] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 2 9 0 48 0 6 0 101 0 6 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 10 0 23 1 81 0 29 0 145 0 33 0 149 0 34 0 153 0 35 2 13 0 52 1 89 0 54 1 93 0 55 1 93 0 56 1 93 0 57 1 93 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 10 0 101 0 11 0 102] 
#[0 1 14 0 23 0 29 0 101 0 102] 
#[0 1 18 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 2 17 0 24] 
#[1 1 22 0 24 1 22 0 29 2 21 0 77] 
#[1 0 101 0 4 0 145 0 33 0 149 0 34 0 153 0 35 2 25 0 73 2 25 0 97 2 25 0 98 2 25 0 99 2 25 0 100] 
#[0 1 26 0 6 0 18 0 23] 
#[1 2 29 0 6 1 121 0 18 2 33 0 23 2 37 0 79] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 53 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 77 0 48 2 41 0 49 2 45 0 50 0 6 0 102] 
#[0 2 49 0 22] 
#[1 0 117 0 10 0 121 0 11 2 53 0 23 2 61 0 84 2 61 0 90 2 65 0 102] 
#[1 1 189 0 4 1 161 0 25 1 165 0 26 2 69 0 61 2 69 0 64 1 173 0 65 1 177 0 66 2 69 0 69 2 69 0 72] 
#[0 1 30 0 22 0 23 0 24 0 29 0 101 0 102] 
#[0 1 34 0 22 0 23 0 24 0 27 0 29 0 101 0 102] 
#[1 1 38 0 22 1 38 0 23 1 38 0 24 1 145 0 27 1 38 0 29 2 85 0 59 1 38 0 101 1 38 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 145 0 33 0 149 0 34 0 153 0 35 2 89 0 67 2 93 0 68 0 185 0 70 2 97 0 71 0 185 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 185 0 97 0 185 0 98 0 185 0 99 0 185 0 100 1 9 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 145 0 33 0 149 0 34 0 153 0 35 2 105 0 70 2 97 0 71 2 105 0 73 2 105 0 74 2 105 0 75 2 105 0 78 2 105 0 82 2 105 0 83 2 105 0 84 2 105 0 85 2 105 0 88 2 105 0 91 2 105 0 92 2 105 0 93 2 105 0 94 0 245 0 95 2 105 0 97 2 105 0 98 2 105 0 99 2 105 0 100 1 9 0 102] 
#[0 1 42 0 22 0 23 0 24 0 27 0 29 0 101 0 102] 
#[0 1 46 0 22 0 23 0 24 0 25 0 27 0 29 0 101 0 102] 
#[1 1 50 0 22 1 50 0 23 1 50 0 24 1 161 0 25 1 50 0 27 1 50 0 29 2 109 0 65 1 50 0 101 1 50 0 102] 
#[0 1 54 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 58 0 22 0 23 0 24 0 29 0 101 0 102] 
#[0 1 62 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 66 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 70 0 22 0 23 0 24 0 29 0 101 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 0 145 0 33 0 149 0 34 0 153 0 35 2 113 0 56 2 113 0 57 2 113 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 9 0 102] 
#[1 1 74 0 1 1 74 0 2 1 74 0 3 1 74 0 4 1 74 0 7 1 74 0 8 1 74 0 9 1 74 0 10 1 74 0 11 1 74 0 12 1 74 0 19 1 74 0 20 1 74 0 21 1 74 0 22 1 74 0 26 1 74 0 27 1 74 0 29 2 117 0 86 1 74 0 102] 
#[0 1 78 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 1 82 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 1 86 0 4 0 6 0 33 0 34 0 35] 
#[0 1 90 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 1 94 0 15 0 25] 
#[0 1 98 0 15 0 25] 
#[0 1 102 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 1 106 0 15 0 25] 
#[0 1 110 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 1 114 0 101] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 2 121 0 48 0 6 0 101 0 6 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 81 0 29 0 145 0 33 0 149 0 34 0 153 0 35 2 125 0 52 1 89 0 54 1 93 0 55 1 93 0 56 1 93 0 57 1 93 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 118 0 101 1 9 0 102] 
#[0 1 122 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 101 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 126 0 23 2 129 0 29 0 145 0 33 0 149 0 34 0 153 0 35 2 133 0 55 2 133 0 56 2 133 0 57 2 133 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 126 0 101 0 15 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 81 0 29 0 145 0 33 0 149 0 34 0 153 0 35 2 137 0 52 1 89 0 54 1 93 0 55 1 93 0 56 1 93 0 57 1 93 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 130 0 101 1 9 0 102] 
#[0 1 134 0 23 0 101 0 102] 
#[0 1 138 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[1 2 141 0 24 2 145 0 29 2 149 0 76] 
#[0 1 142 0 6 0 18 0 23] 
#[0 1 146 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 102] 
#[0 1 150 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 154 0 6 0 18 0 23] 
#[1 2 153 0 23 2 157 0 102] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 1 101 0 48 0 6 0 102] 
#[0 1 158 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 162 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 166 0 10 0 11 0 23 0 102] 
#[0 1 170 0 10 0 11 0 23 0 102] 
#[0 1 174 0 10 0 11 0 23 0 102] 
#[0 1 178 0 22 0 23 0 24 0 27 0 29 0 101 0 102] 
#[0 1 182 0 22 0 23 0 24 0 27 0 29 0 101 0 102] 
#[0 1 186 0 22 0 23 0 24 0 27 0 29 0 101 0 102] 
#[0 1 190 0 22 0 23 0 24 0 27 0 29 0 101 0 102] 
#[0 1 194 0 22 0 23 0 24 0 27 0 29 0 101 0 102] 
#[1 1 198 0 22 1 198 0 23 1 198 0 24 1 198 0 25 1 165 0 26 1 198 0 27 1 198 0 29 1 181 0 69 1 198 0 101 1 198 0 102] 
#[0 0 126 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 134 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 0 138 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[1 1 189 0 4 1 202 0 22 1 202 0 23 1 202 0 24 1 202 0 25 1 202 0 26 1 202 0 27 1 202 0 29 1 193 0 72 1 202 0 101 1 202 0 102] 
#[0 1 206 0 22 0 23 0 24 0 25 0 27 0 29 0 101 0 102] 
#[0 1 210 0 22 0 23 0 24 0 29 0 101 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 2 161 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 2 165 0 12 2 169 0 19 0 10 0 20 0 141 0 21 1 214 0 22 2 173 0 26 2 177 0 27 2 181 0 29 2 189 0 82 2 189 0 83 2 189 0 84 2 189 0 85 2 189 0 87 2 189 0 88 2 189 0 91 2 189 0 92 2 189 0 93 2 189 0 94 0 245 0 95 2 193 0 96 2 197 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 125 0 13 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 1 81 0 29 0 145 0 33 0 149 0 34 0 153 0 35 2 201 0 52 1 89 0 54 1 93 0 55 1 93 0 56 1 93 0 57 1 93 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 218 0 101 1 9 0 102] 
#[0 1 222 0 101] 
#[0 1 226 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 101 0 102] 
#[0 1 230 0 23 0 29 0 101 0 102] 
#[0 1 234 0 101] 
#[0 1 238 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 0 101 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 0 129 0 16 0 133 0 17 0 137 0 19 0 10 0 20 0 141 0 21 2 205 0 24 0 145 0 33 0 149 0 34 0 153 0 35 2 209 0 56 2 209 0 57 2 209 0 62 0 173 0 63 0 177 0 67 0 181 0 68 0 185 0 70 0 189 0 71 0 193 0 73 0 185 0 74 0 185 0 75 0 185 0 78 0 185 0 82 0 185 0 83 0 185 0 84 0 185 0 85 0 185 0 88 0 185 0 91 0 185 0 92 0 185 0 93 0 185 0 94 0 245 0 95 0 193 0 97 0 193 0 98 0 193 0 99 0 193 0 100 1 9 0 102] 
#[0 1 242 0 24 0 29] 
#[0 1 246 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 250 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 1 254 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[0 2 2 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[1 1 74 0 1 1 74 0 2 1 74 0 3 1 74 0 4 1 74 0 7 1 74 0 8 1 74 0 9 1 74 0 10 1 74 0 11 1 74 0 12 1 74 0 19 1 74 0 20 1 74 0 21 1 74 0 22 1 74 0 26 1 74 0 27 1 74 0 29 2 213 0 86 1 74 0 102] 
#[0 2 6 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[0 2 10 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[0 2 14 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[0 2 18 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[0 2 22 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[0 2 217 0 22] 
#[0 2 26 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102] 
#[0 2 30 0 101] 
#[0 2 34 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 2 38 0 24 0 29] 
#[1 0 89 0 1 0 93 0 2 0 97 0 3 2 161 0 4 0 105 0 7 0 109 0 8 0 113 0 9 0 117 0 10 0 121 0 11 2 165 0 12 2 169 0 19 0 10 0 20 0 141 0 21 2 221 0 22 2 173 0 26 2 177 0 27 2 181 0 29 2 189 0 82 2 189 0 83 2 189 0 84 2 189 0 85 2 189 0 87 2 189 0 88 2 189 0 91 2 189 0 92 2 189 0 93 2 189 0 94 0 245 0 95 2 197 0 102] 
#[0 2 42 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 101 0 102] 
#[0 2 46 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 102]
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
GtPharoParser >> reduceActionForNamedVariable1: nodes [
	| result |
	result := GtPharoNamedVariableNode new.
	result name: (nodes at: 1).
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
GtPharoParser >> reduceActionForSelfVariable1: nodes [
	| result |
	result := GtPharoSelfVariableNode new.
	result name: (nodes at: 1).
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
GtPharoParser >> reduceActionForSuperVariable1: nodes [
	| result |
	result := GtPharoSuperVariableNode new.
	result name: (nodes at: 1).
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
GtPharoParser >> reduceActionForThisContextVariable1: nodes [
	| result |
	result := GtPharoThisContextVariableNode new.
	result name: (nodes at: 1).
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
