grammar Euporia;
options { tokenVocab=EuporiaLexer; }

start: titleAndEditor
        identifiers
        summary
        support
        layout
        handScriptAndDecoration
        history
        language
        textClass?
        facsimile
        diplomaticEdition?
        interpretativeEdition
        translation?
        apparatus?
        commentary?
        onomastics?
        bibliography;

// value
value: (WORD|CHARSEQ|NUM|COMMA|LPAR|RPAR)+;

//titleAndEditor
titleAndEditor: TITLE_AND_EDITOR NL
        WORD editionIdno NL? editor NL NL;
editionIdno: EDITION_IDNO;
editor: WORD+;

//identifiers
identifiers: IDENTIFIERS NL
        settlement? NL
        (institutionInfo
            altInstitutionInfo*)*
        (MS_NAME msName)?
        (TRISMEGISTOS_ID altIdentifierTM (COMMA? altIdentifierTM)* NL)?
        (TRADITIONAL_ID altIdentifierTID (COMMA? altIdentifierTID)* NL)?
        NL;

settlement: PLACE_NAME QUOT value QUOT;
institutionInfo: institution (NL? IDNO? idno)? NL;
altInstitutionInfo: institution (NL? IDNO? idno)? NL;
institution: INSTITUTION QUOT value QUOT;
idno: (NUM|WORD|CHARSEQ|COMMA);
msName: (WORD|CHARSEQ|COMMA)+ NL;

altIdentifierTM: QUOT value QUOT;
altIdentifierTID: QUOT value QUOT;

//summary
summary: SUMMARY NL
        p NL;

p: (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR|refInP)+ NL;
refInP: OPEN_REF rfRef (RF_SCLN rfRef)* RF_CLOSE_REF;

//support
support: SUPPORT NL
        (objectType (objectShape)?)? material? dimensions NL
        rsReuse condition NL NL;
	
objectType: QUOT value QUOT;
objectShape: LPAR (WORD|CHARSEQ|COMMA|NUM)+ RPAR;
material: QUOT value QUOT;

dimensions:
        (H height)? (W width)? (D depthx)? (DIA diameter)? dimensionsNote?;

height: NUM;
width: NUM;
depthx: NUM;
diameter: NUM;

dimensionsNote: LPAR (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR)+ RPAR;

rsReuse: RS_REUSE;
condition: CONDITION conditionNote?;
conditionNote: LPAR (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR)+ RPAR;

//layout
layout: LAYOUT NL
        COLUMNS columns WRITTEN_LINES writtenLines NL
        execution opistography layoutNotes? 
        ((ALL_LINES EQ allLineDimensions NL)?|singleLineDimensions*) NL NL;

columns: NUM;
writtenLines: NUM;
execution: EXECUTION QUOT value QUOT; 
opistography: OPISTOGRAPHY;
layoutNotes: (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR)+ NL?;
allLineDimensions: (H height)? (W width)?;
singleLineDimensions: (LINE lineNum (EQ lineDimensions)? NL);
lineNum: NUM;
lineDimensions: (H height)? (W width)?;

//handScriptAndDecoration
handScriptAndDecoration: HAND_SCRIPT_AND_DECORATION NL
        (PALAEOGRAPHIC_NOTES paleographicNotes NL)? 
        (CHARACTER_DIMENSION (characterDimension|(singleCharacterDimension singleCharacterDimension*) NL) NL)?
        alphabet NL
        wordDivision NL
        ((noSyllabicPunctuation NL)|(SYLLABIC_PUNCTUATION syllabicPunctuationSimplification syllabicPunctuationApplication NL))?
        (DECO_NOTE decoNote)? NL;

paleographicNotes: (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR|refInP)+;
singleCharacterDimension: corresp EQ characterDimension;
corresp: CHARSEQ|COMMA;
characterDimension: NUM;
alphabet: ALPHABET QUOT value QUOT;
wordDivision: WORD_DIVISION;
noSyllabicPunctuation: NO_SYLLABIC_PUNCTUATION;
syllabicPunctuationSimplification: SYLLABIC_PUNCTUATION_SIMPLIFICATION;
syllabicPunctuationApplication: SYLLABIC_PUNCTUATION_APPLICATION;
decoNote: (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR|refInP)+ NL;

//history
history: HISTORY NL
        (COMPOSITION composition origDate? (NL|DT_NL))?
        FINDING finding findingYear? findingNote? NL
        provenance detailedProvenance? NL
        (BY findingResp (AND findingResp)* findingYear NL)?
        (OBSERVATION observation (observationResp observationYear? observationNote?)? NL)* 
        NL;
composition : ancientPlaceName (LPAR modernPlaceName RPAR)?;
ancientPlaceName: QUOT value QUOT;
modernPlaceName: QUOT value QUOT;
origDate: DT_KEY date (DT_COMMA date)* DT_POP?;
findingNote: LPAR (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR)+ RPAR;
observationNote: LPAR (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR)+ RPAR;

//date: date_num DT_NUM_SFX DT_CENTURY timeline;
//date_num: DT_NUM;
//timeline: DT_TIMELINE;

date: century | centuryRange | centuryPart | centuryPartRange | year | yearRange | yearOpenRange;
century: dt_num DT_NUM_SFX (DT_CENTURY timeline)?;
dt_num: DT_NUM;
timeline: DT_TIMELINE;
centuryRange: century DT_ALT_SEP century;
centuryPart: dt_part century;
dt_part: DT_PART;
centuryPartRange: centuryPart DT_ALT_SEP centuryPart;
year: dt_num timeline? circa?;
yearRange: year DT_RANGE_SEP year;
yearOpenRange: timeDirection year;
timeDirection: DT_BEFORE|DT_AFTER|DT_NOT_BEFORE|DT_NOT_AFTER;
circa: DT_CIRCA;
//century (4th century BC)
//centuryRange (4th/3rd century BC | 1st century BC/1st century AD)
//centuryPart (first half of the 4th century BC | second half of the 4th century BC | middle of the 4th century BC | end of the 4th century BC | beginning of the 3rd century BC | 2nd quarter of the 4th century BC | 3rd quarter of the 4th century BC)
//centuryPartRange (end of the 4th century BC/beginning of the 3rd century BC | ...)
//year (212 BC | 212 BC circa)
//yearRange (212-211 BC | 212 BC-211 AD | 212-211 BC circa | 212 BC-211 AD circa)
//yearOpenRange (after 212 BC | before 212 BC)

finding: FINDING_TYPE;
provenance: PLACE_NAME|PLACE_NAME_ANCIENT|ancientPlaceName LPAR modernPlaceName RPAR;
detailedProvenance: (CHARSEQ|COMMA|WORD|NUM|LPAR|RPAR)+;
findingResp: WORD+;
findingYear: NUM|DT_KEY date DT_POP;
observationYear: NUM|DT_KEY date DT_POP;
observation: observationType observationSubtype?;
observationType: OBSERVATION_TYPE;
observationSubtype: OBSERVATION_SUBTYPE;
observationResp: WORD+;

//language
language: LANGUAGE NL
        languageTag languageType (LPAR languageSubtype RPAR)? NL NL; 

languageTag: LANGUAGE_TAG;
languageType: QUOT value QUOT;
languageSubtype: QUOT value QUOT;

//text class
textClass: TEXT_CLASS NL
        textClassTerm+ NL NL;

textClassTerm: QUOT value QUOT;

//facsimile
facsimile: FACSIMILE NL
        (singleFacsimile)* NL;

singleFacsimile: facsimileNum url EQ facsimileDesc;

facsimileNum: NUM;
url: URL;
facsimileDesc: (WORD|CHARSEQ|COMMA|NUM|LPAR|RPAR|EQ|url|xml)+ NL;
xml: XML;

//diplomaticEdition
diplomaticEdition: DIPLOMATIC_EDITION DE_NL+ deFaceData+ DE_3_STAR;

deFaceData: deMetadata deText;

deMetadata: deFace DE_BAR deTextDirection DE_BAR deTextVerse DE_NL+;

deFace: DE_HASHTAG;
deTextDirection: DE_HASHTAG;
deTextVerse: DE_HASHTAG;

deText: deTextLine+ DE_NL+;

deTextLine: deLang? deLineNum deLineText DE_NL;

deLang: DE_LANG;
deLineNum: DE_NUM;
deLineText: (DE_CHARSEQ|DE_CLN|DE_SCLN|DE_DOT|DE_COMMA)+;



//interpretativeEdtion
interpretativeEdition: INTERPRETATIVE_EDITION IE_NL+ ieFaceData+ IE_3_STAR NL*; //IE_3_STAR può essere opzionale?

ieFaceData: ieMetadata ieText ieApparatus;

ieMetadata: ieFace IE_BAR ieTextDirection IE_BAR ieTextVerse IE_NL+;

ieFace: IE_HASHTAG;
ieTextDirection: IE_HASHTAG;
ieTextVerse: IE_HASHTAG;

ieText: ieTextLine+ IE_NL+;

ieTextLine: ieLang? ieLineNum ieLineText IE_NL;

ieLang: IE_LANG;
ieLineNum: IE_NUM;
ieLineText: ieToken+;
//ieToken: IE_STAR|(IE_CHARSEQ|IE_CLN|IE_SCLN|IE_DOT|IE_NUM|IE_COMMA)+;
ieToken: IE_STAR|IE_CHARSEQ|IE_CLN|IE_SCLN|IE_DOT|IE_NUM|IE_COMMA;
//ieToken: IE_STAR|IE_CHARSEQ|IE_CLN|IE_SCLN|IE_NUM|IE_COMMA;

ieApparatus: ieLineBlock+;

ieLineBlock: ieLineHeader ieItemDesc+ IE_NL* IE_3_EQL? IE_NL*;

ieLineHeader: IE_LINE ieLineNum IE_NL;
ieItemDesc: (ieTokenNum|ieLineTokenNum|ieTokenSet) ieToken? IE_EQL ieItemValue IE_NL;
ieTokenNum: IE_NUM;
ieLineTokenNum: ieLineNum IE_DOT ieTokenNum;
ieTokenSet: (ieTokenNum|ieLineTokenNum) (IE_SCLN (ieTokenNum|ieLineTokenNum))+;
ieItemValue: (IE_HASHTAG|IE_MACRO);


//translation
translation: TRANSLATION TR_NL+ trItaTranslation TR_NL trEngTranslation? TR_NL* TR_3_STAR NL*;
trItaTranslation: trP TR_NL trPersName (TR_SCLN trPersName)* TR_NL;
trEngTranslation: trP TR_NL trPersName (TR_SCLN trPersName)*  TR_NL*;
trP: (TR_NUM|TR_WORD|TR_DOT|TR_CLN|TR_SCLN|TR_COMMA|TR_EQL|TR_STAR|TR_QMARK|TR_PARS)+;
trPersName: TR_WORD+;

//apparatus
apparatus: APPARATUS AP_NL+ apLineBlock+ apPersName (AP_SCLN apPersName)* AP_3_STAR NL*;
apLineBlock: apLineHeader apItemDesc+ AP_NL*;
apLineHeader: AP_LINE apLineNum AP_NL;
apItemDesc: (apTokenNum|apLineTokenNum|apTokenSet) apToken? AP_EQL apItemValue (apRef (AP_COMMA? apRef)*)? AP_NL;
apLineNum: AP_NUM;
apTokenNum: AP_NUM;
apLineTokenNum: apLineNum AP_DOT apTokenNum; 
apTokenSet: (apTokenNum|apLineTokenNum) (AP_SCLN (apTokenNum|apLineTokenNum))+; 
apItemValue: (AP_CHARSEQ|AP_CLN|AP_SCLN|AP_DOT|AP_COMMA|AP_STAR);
apToken: (AP_STAR|AP_CHARSEQ);
apRef: AP_OPEN_REF rfRef (RF_SCLN? rfRef)* RF_CLOSE_REF;
apPersName: AP_CHARSEQ+;

//reference ****
rfRef: rfAuthor rfYear rfLetter? (RF_CLN (rfPage|rfPageRange) (RF_COMMA (rfPage|rfPageRange))*)?;
rfAuthor: (RF_ALPHASEQ|RF_DASH)+;
rfYear: RF_NUM;
rfLetter: RF_ALPHASEQ;
rfPage: RF_NUM;
rfPageRange: rfPage RF_DASH rfPage;


//commentary
commentary: COMMENTARY NL ntNote;
ntNote: NOTES NT_NL+ note+ ntPersName (NT_SCLN ntPersName)*  NT_NL* NT_3_STAR NL*;
note: ntTarget NT_CLN ntP  NT_NL; //da buttare via!!!
ntTarget: NT_AT ntNum (NT_DOT ntNum)*;
ntInternalRef: NT_AT ntNum (NT_DOT ntNum)*;
ntP: (ntRs|ntInternalRef|NT_HASH|NT_NUM|NT_WORD|NT_DOT|NT_CLN|NT_SCLN|NT_COMMA|NT_EQL|NT_STAR|NT_QMARK|NT_LPAR|NT_RPAR|NT_QUOT|ntRef|NT_LBRAK|NT_RBRAK)+;
ntRs: (ntRsType NT_CLN ntRsText ntRsCorresp)| (ntRsLang NT_CLN ntRsText);
ntRsType: NT_NAME|NT_W|NT_PHR|NT_S;
ntRsLang: NT_LANG NT_EQL ntLang;
ntRsText: NT_QUOT ntText NT_QUOT;
ntText: (ntRef|NT_HASH|NT_NUM|NT_WORD|NT_DOT|NT_CLN|NT_SCLN|NT_COMMA|NT_EQL|NT_STAR|NT_QMARK|NT_LPAR|NT_RPAR|NT_QUOT|NT_LBRAK|NT_RBRAK)+;
ntRsCorresp: NT_AT ntNum (NT_DOT ntNum)*;
ntNum: NT_NUM;
ntLang: NT_WORD;
ntPersName: NT_WORD+;
ntRef: NT_OPEN_REF rfRef (RF_SCLN rfRef)* RF_CLOSE_REF;

//onomastics
onomastics: ONOMASTICS ON_NL+ onPerson+ ON_3_STAR NL*;
onPerson: onPersonId ON_CLN onPersonRef (ON_COMMA onPersonRef)* ON_NL*;
onPersonId: ON_PERSON_ID;
onPersonRef: ON_PERSON_REF;

//bibliography
bibliography: BIBLIOGRAPHY BG_NL+ bgItem+ BG_3_STAR NL*;
bgItem: bgRef (bgEntry|bgPages) BG_NL*;
bgRef: BG_OPEN_REF rfRef (RF_SCLN rfRef)* RF_CLOSE_REF;
bgEntry: BG_ENTRY bgValue;
bgPages: BG_PAGES bgValue;
bgValue: BG_TOKEN+;

//bgPlaceholder: BG_TOKEN+; //da buttare via!!!
