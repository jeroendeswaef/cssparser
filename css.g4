grammar css;

cssRules: (cssRule | mediaQuery)* ;

mediaQuery: '@media' (~'{')* '{' cssRule* '}';

cssRule: selector (',' selector)* '{' simple_rule* '}' ;

// f.e. #myid p
selector: (selector_item ('>'|'+')?)+ ;

// f.e. #myid
selector_item
  : selector_name attribute_selector? quantifier*
  | '#' selector_name attribute_selector? quantifier*
  | '.' selector_name attribute_selector? quantifier*
  | '*' quantifier*
  ;

element_selector
	: ID
	| '#' ID
	| '.' ID
	| ':' ID
	;

selector_name: '@'? ID ;

// f.e. #lockScreen.round input[type="password"]
attribute_selector: '[' ID '=' ('"' ID '"' | '\'' ID '\'' | ID) ']';

// f.e. #lockScreen.round input[type="password"]::-webkit-input-placeholder
quantifier: ':' ':'? (ID | 'not' '(' (element_selector | attribute_selector) ')' | POSITION_QUANTIFIER);

simple_rule
	: keyframe_key (~'}')*? '}'
	| (rulename ':' rulebody) 
	;
rulename: ID ;
rulebody
	: rulebodyline
	;

rulebodyline: (ID|','|'('|')'|'%'|'#'|'.'|'!'|'\''|'"'|'\\'|'/'|PERCENTAGE_KEY|URL)* ';' ;

keyframe_key: PERCENTAGE_KEY '{' ;
URL: 'url' '(' (~')')*? ')' ;
POSITION_QUANTIFIER: 'nth-last-child' '(' [0-9]+ ')';
ANIM_BODY: ('from {'|'to {') .*? '}' -> skip ;



ID: [a-zA-Z0-9_-]+ ;
WS : [ \t\r\n]+ -> skip ; // Define whitespace rule, toss it out

PERCENTAGE_KEY: [0-9]+ '%';

// Single-line comments
SL_COMMENT
  :  '//'
    (~('\n'|'\r'))* ('\n'|'\r'('\n')?) -> skip
  ;


// multiple-line comments
COMMENT
  :  '/*' .*? '*/' -> skip
  ;