lexer grammar EuporiaLexer;



TITLE_AND_EDITOR: 'TITLE AND EDITOR';
IDENTIFIERS: 'IDENTIFIERS';
SUMMARY: 'SUMMARY';
SUPPORT: 'SUPPORT';
LAYOUT: 'LAYOUT';
HAND_SCRIPT_AND_DECORATION: 'HAND, SCRIPT, AND DECORATION';
HISTORY: 'HISTORY';
LANGUAGE: 'LANGUAGE';
TEXT_CLASS: 'TEXT CLASS';
FACSIMILE: 'FACSIMILE';
DIPLOMATIC_EDITION: 'DIPLOMATIC EDITION' ->pushMode(DE);
INTERPRETATIVE_EDITION: 'INTERPRETATIVE EDITION' ->pushMode(IE);
TRANSLATION: 'TRANSLATION' ->pushMode(TR);
APPARATUS: 'APPARATUS' ->pushMode(AP);
COMMENTARY: 'COMMENTARY';
NOTES: 'NOTES' ->pushMode(NT);
ONOMASTICS: 'ONOMASTICS' ->pushMode(ON);
BIBLIOGRAPHY: 'BIBLIOGRAPHY' ->pushMode(BG);

XML: '<!--'.+?'-->';
URL: 'http''s'?'://'('www.')?[-a-zA-Z0-9@:%._+~#=]+'.'[a-zA-Z0-9()][-a-zA-Z0-9()@:%_+.~#?&/=]*;

EDITION_IDNO: 'ItAnt_'('Faliscan'|'Oscan'|'Venetic'|'CisalpineCeltic')'_'[0-9]+;
MS_NAME: '#msName:';
H: 'h:'|'#h'':'?;
W: 'w:'|'#w'':'?;
D: 'd:'|'#d'':'?;
DIA: 'dia:'|'#dia'':'?;
V_BAR: '|';
B_BAR: '¦';
LPAR: '(';
RPAR: ')'[.,;:!?]?;
COMMA: ',';
QUOT: '"';
AND: '&';
STAR: '*';
NUM: [0-9]+('.'[0-9]+)*;
WORD: [A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D’]+[.,;:!?]?;
CHARSEQ: [A-Za-zàáâäèéêëìíïòóôöùúüýç.0-9\u002D‘_/<\u005c>:;,]+;
PLACE_NAME: '#place:';
PLACE_NAME_ANCIENT: '#ancientPlace:'|'#ancPlace:';
INSTITUTION: '#institution:'|'#inst:';
TRISMEGISTOS_ID: '#tm:';
TRADITIONAL_ID: '#tradId:'|'#trad:';
OBJECT_TYPE: '#object:'|'#obj:';

MATERIAL: '#material:'|'#mat:';

RS_REUSE: '#re-used'|'#not'(' #r'|[ _]'r'|'R')'e-used';
CONDITION: '#well-preserved'|'#fragmentary'|'#very'(' #f'|[ _]'f'|'F')'ragmentary'|'#lost'(' #i'|[ _]'i'|'I')'nscription';

COLUMNS: '#columns:';
WRITTEN_LINES: '#writtenLines:';

EXECUTION: '#execution:'|'#exec:';

OPISTOGRAPHY: '#opistograph'|'#notOpistograph';

LINE: '#line:';
ALL_LINES: '#allLines';

PALAEOGRAPHIC_NOTES: '#palaeographicNotes:';
CHARACTER_DIMENSION: '#characterDimension:';
ALPHABET: '#alphabet:'|'#alph:';
WORD_DIVISION: '#scriptioContinua'|'#punctuation'|'#blankSpaces'|'#mixed';
NO_SYLLABIC_PUNCTUATION: '#noSyllabicPunctuation';
SYLLABIC_PUNCTUATION: '#syllabicPunctuation:';
SYLLABIC_PUNCTUATION_SIMPLIFICATION: '#simplified'|'#unsimplified';
SYLLABIC_PUNCTUATION_APPLICATION: '#properlyApplied'|'#unproperlyApplied';
DECO_NOTE: '#decoNote:';

LANGUAGE_SUBTYPE: '#lsub:'|'#langSub:';
LANGUAGE_TYPE: '#lang:';
LANGUAGE_TAG: '#l1:'|'#l2:'|'#l3:'|'#l4:';

COMPOSITION: '#composition:';
FINDING: '#finding:';
FINDING_TYPE: '#discovered'|'#re-discovered'|'#firstRecorded';
BY: '#by:';
OBSERVATION: '#observation:';
OBSERVATION_TYPE: '#seen'|'#autopsied'|'#lost'|'#stolen'|'#destroyed'|'#observed';
DT_KEY: ('#date:"'|'#date: "') -> pushMode(DT);
EQ: '=';

NL: '\n';
WS: ' '->skip;

mode DT;

DT_NUM: [0-9]+;
DT_NUM_SFX: 'st'|'nd'|'rd'|'th';
DT_CENTURY: 'century';
DT_TIMELINE: 'BC'|'AD';
DT_ALT_SEP: '/';
DT_PART: 'first half of the'|'second half of the'|'middle of the'|'end of the'|'beginning of the'|'1st quarter of the'|'2nd quarter of the';
DT_RANGE_SEP: '-';
DT_CIRCA: 'circa';
DT_AFTER: 'after';
DT_BEFORE: 'before';
DT_COMMA: ',';

DT_WS: ' '->skip;
DT_NL: '"\n' -> popMode;
DT_POP: '"' -> popMode;


mode DE;
DE_LANG: '#l1:'|'#l2:'|'#l3:';
DE_NL: '\n';
DE_WS: ' '->skip;
DE_LINE: '#line:';
DE_MACRO: '@'[a-z0-9_]+;
DE_HASHTAG: '#'[a-z_0-9]+;
DE_BAR: '|';
DE_NUM: [0-9]+;
DE_DOT: '.';
DE_CLN: ':';
DE_SCLN: ';';
DE_COMMA: ',';
DE_EQL: '=';
DE_STAR: '*';
DE_3_EQL: '===';
DE_CHARSEQ: ([0-9A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D‘_/—()\u0323!]|'['|']')+;
DE_3_STAR: '\n'?'***\n\n\n' -> popMode;

mode IE;
IE_LANG: '#l1:'|'#l2:'|'#l3:';
IE_NL: '\n';
IE_WS: ' '->skip;
IE_LINE: '#line:';
IE_MACRO: '@'[a-z0-9_]+;
IE_HASHTAG: '#'[a-z_0-9]+;
IE_BAR: '|';
IE_NUM: [0-9]+;
IE_DOT: '.';
IE_CLN: ':';
IE_SCLN: ';';
IE_COMMA: ',';
IE_EQL: '=';
IE_STAR: '*';
IE_3_EQL: '===';
IE_CHARSEQ: ([0-9A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D‘_/—()\u0323!]|'['|']')+;
IE_3_STAR: '\n'?'***' -> popMode;


mode TR;
TR_NL: '\n';
TR_WS: ' '->skip;
TR_NUM: [0-9]+;
TR_WORD: [A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D’_/—+]+;
TR_DOT: '.';
TR_CLN: ':';
TR_SCLN: ';';
TR_COMMA: ',';
TR_EQL: '=';
TR_STAR: '*';
TR_QMARK: '?';
TR_PARS: ([()]|'['|']')+;

TR_3_STAR: '\n'?'***' -> popMode;

mode AP;
AP_OPEN_REF: '«' ->pushMode(RF);
AP_LANG: '#l1:'|'#l2:'|'#l3:';
AP_NL: '\n';
AP_WS: ' '->skip;
AP_LINE: '#line:';
AP_MACRO: '@'[a-z0-9_]+;
AP_HASHTAG: '#'[a-z_0-9]+;
AP_BAR: '|';
AP_NUM: [0-9]+;
AP_DOT: '.';
AP_CLN: ':';
AP_SCLN: ';';
AP_COMMA: ',';
AP_EQL: '=';
AP_STAR: '*';
AP_3_EQL: '===';
AP_CHARSEQ: ([0-9A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D‘_/—()\u0323!]|'['|']')+;
AP_3_STAR: '\n'?'***' -> popMode;


mode NT;
NT_NL: '\n';
NT_WS: ' '->skip;
//NT_TOKEN: ([0-9A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D‘_/—()\u0323.,;:=]|'['|']')+|'*'; //DA MODIFICARE!!!
NT_AT: '@';
NT_NAME: '#name'|'#n';
NT_W: '#word'|'#w';
NT_PHR: '#phr';
NT_S: '#s';
NT_LANG: '#lang'|'#l';
NT_HASH: '#';
NT_NUM: [0-9]+;
NT_WORD: [A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D’_/—\u00AF+]+;
NT_DOT: '.';
NT_CLN: ':';
NT_SCLN: ';';
NT_COMMA: ',';
NT_EQL: '=';
NT_STAR: '*';
NT_QMARK: '?';
NT_LPAR: '(';
NT_RPAR: ')';
NT_QUOT: '"';
NT_OPEN_REF: '«' ->pushMode(RF);
NT_LBRAK: '[';
NT_RBRAK: ']';
NT_3_STAR: '\n'?'***' -> popMode;

mode ON;
ON_NL: '\n';
ON_WS: ' '->skip;
ON_PERSON_ID: '#'([a-zA-Z_0-9]+);
ON_CLN: ':';
ON_PERSON_REF: '@'([a-zA-Z_0-9]+);
ON_COMMA: ',';
ON_TOKEN: ([0-9A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D‘_/—()\u0323!.,;:=]|'['|']')+|'*';  //DA MODIFICARE!!!
ON_3_STAR: '\n'?'***' -> popMode;

mode BG;
BG_OPEN_REF: '«' -> pushMode(RF);
BG_ENTRY: '#entry'':'?;
BG_PAGES: '#page''s'?':'?;
BG_COMMA: ',';
BG_CLN: ':';
BG_SCLN: ';';
BG_NL: '\n';
BG_WS: ' '->skip;
BG_TOKEN: ([0-9A-Za-zàáâäèéêëìíïòóôöùúüýç\u002D‘_/—()\u0323!.,;:=]|'['|']')+|'*';  //DA MODIFICARE!!!
BG_3_STAR: '\n'?'***' -> popMode;

mode RF;
RF_WS: ' '->skip;
RF_NUM: [0-9]+;
RF_DOT: '.';
RF_CLN: ':';
RF_SCLN: ';';
RF_COMMA: ',';
RF_EQL: '=';
RF_STAR: '*';
RF_DASH: '-'|'—';
RF_ALPHASEQ: [A-Za-zàáâäèéêëìíïòóôöùúüýç‘’_/—']+;
RF_CLOSE_REF: '»' -> popMode;
