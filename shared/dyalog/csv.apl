#!/usr/bin/env rundyalog

⍝ CSV file reading originally from http://aplwiki.com/CsvToApl
⍝ converted to dfns-notation by Martin Dybdal

⍝ Make sure we are using 1-indexing
⎕IO ← 1

⍝ <LineFeed> and <CarriageReturn>
(lf cr)←⎕UCS 10 13                         


⍝ Takes a string and partitions records.
⍝ Can deal with Mac/Unix/Windows files.
⍝ For that, CR+LF as well as single LFs are converted into CR.
⍝ CR is then used to partition "string".
PartitionRecordsWithDyalog ← {
 string ← ⍵
 ⎕ML←3
 bool←(cr,lf)⍷string                ⍝ are there any cr+lf in sequence ("\r\n") in "string"?
 0<+/bool : string←(~bool)/string   ⍝ Let only the cr ("\r") survive
 bool←cr=string                     ⍝ Are there still any cr's?
 0<+/bool : ((bool/string)←lf)      ⍝ Convert them to lf

⍝ In the remaining string, there might be lf's inside text, Those
⍝ need to be masked before we decide where records really start.
 masked←~{⍵∨≠\⍵}'"'=string          ⍝ what is not escaped (between "")
 bool←lf=masked/string              ⍝ are there any unmasked lf in "string"?
 1∊bool : r←(~masked\bool)⊂string
 ⊂string  ⍝ so it's a single record
}

⍝ Transform cells that contain digits into numeric values, BUT:
⍝ * Commas are ignored.
⍝ * "$£€¥" are ignored because the left argument "ignore" defaults to those.
⍝ * Blanks are removed
⍝ Example:
⍝ (¯10 3 4 1234.5 12 1000  '1A')←Csv2Numeric '-10' '3' '4' '123,4.5' '£12' '1E3' '1A'
Csv2Numeric ← {
 r ← ⍵
 ignore← {0<⎕NC ⍵:⍎⍵ ⋄ '$£€¥'}'ignore'
 buffer←{0=+/bool←'-'=w←⍵:⍵ ⋄ (bool/w)←'¯' ⋄ w}¨r  ⍝ "buffer" is a copy of r with "¯" for "-"
 buffer{(0∊⍴⍵):'' ⋄ ,↑1⊃v←⎕VFI ⍺~' ,',ignore:↑2⊃v ⋄ ⍵}¨r ⍝ make fields with appropriate content numeric
}

⍝ Convert vector-of-text-vectors "csv" that is assumed to
⍝ come from  a *.csv file and which got already partitioned
⍝ into an APL matrix. Takes care of escaped stuff.
⍝ "sep" defaults to a comma but that can be changed by specifying a left argument.
Csv2MatrixWithDyalog ← {
 ⍺ ← ','
 csvdata ← ⍵
 sep ← ⍺
 ⎕ML←3
 r←(⌽∨\0≠⌽↑∘⍴¨csvdata)/csvdata   ⍝ remove empty stuff from the end if any
 bool←{~{⍵∨≠\⍵}'"'=⍵}¨r         ⍝ prepare booleans useful to mask escaped stuff
 r←⊃r{⍺⊂⍨⍵≠sep}¨bool{⍺\⍺/⍵}¨r   ⍝ partition fields by unmasked commas
 r←{'"'≠1⍴⍵:⍵ ⋄ ¯1↓1↓⍵}¨r       ⍝ remove leading and trailing "
 r←Csv2Numeric r                ⍝ Convert numeric cells
 r←(~'""'∘⍷¨r)/¨r               ⍝ double-" into a single one
 r
}

⍝ Read "filename" which is assumed to be a *.csv file
⍝ and convert it into a matrix
read ← {
 filename ← ⍵
 ⍺ ← ',' ⍝ default seperator
 tie ← filename ⎕NTIE 0
 data ← ⎕NREAD tie 80 (⎕NSIZE tie) 0
 data ← PartitionRecordsWithDyalog data
 ⊃ ¨ ⍺ Csv2MatrixWithDyalog data
}
