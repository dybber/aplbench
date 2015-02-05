#!/usr/local/bin/mapl -script
⍝ From http://aplwiki.com/CsvToApl

∇r←PartitionRecordsWithDyalog string;masked;cr;lf;bool
⍝ Takes a string and partitions records.
⍝ Can deal with Mac/Unix/Windows files.
⍝ For that, CR+LF as well as single LFs are converted into CR.
⍝ CR is then used to partition "string".
 ⎕IO←1 ⋄ ⎕ML←3
 (cr lf)←⎕UCS 10 13                         ⍝ <CarriageReturn> and <LineFeed>
 :If 0<+/bool←(cr,lf)⍷string                ⍝ are there any cr+lf in "string"?
     string←(~bool)/string                  ⍝ Let only the cr survive
 :EndIf
 :If 0<+/bool←cr=string                     ⍝ Are there still any cr's?
     (bool/string)←lf                       ⍝ Convert them to lf
 :EndIf
⍝ In the remaining string, there might be lf's inside text, Those
⍝ need to be masked before we decide where records really start.
 masked←~{⍵∨≠\⍵}'"'=string                  ⍝ what is not escaped (between "")
 :If 1∊bool←lf=masked/string                ⍝ are there any unmasked lf in "string"?
     r←(~masked\bool)⊂string
 :Else ⍝ so it's a single record
     r←⊂string
 :EndIf
∇

∇r←{ignore}Csv2Numeric r;buffer
⍝ Transform cells that contain digits into numeric values, BUT:
⍝ * Commas are ignored.
⍝ * "$£€¥" are ignored because the left argument "ignore" defaults to those.
⍝ * Blanks are removed
⍝ Example:
⍝ (¯10 3 4 1234.5 12 1000  '1A')←Csv2Numeric '-10' '3' '4' '123,4.5' '£12' '1E3' '1A'
 ignore←{0<⎕NC ⍵:⍎⍵ ⋄ '$£€¥'}'ignore'
 buffer←{0=+/bool←'-'=w←⍵:⍵ ⋄ (bool/w)←'¯' ⋄ w}¨r  ⍝ "buffer" is a copy of r with "¯" for "-"
 r←buffer{(0∊⍴⍵):'' ⋄ ,↑1⊃v←⎕VFI ⍺~' ,',ignore:↑2⊃v ⋄ ⍵}¨r ⍝ make fields with appropriate content numeric
∇

∇r←{sep}Csv2MatrixWithDyalog csv;bool;⎕IO
⍝ Convert vector-of-text-vectors "csv" that is assumed to
⍝ come from  a *.csv file and which got already partitioned
⍝ into an APL matrix. Takes care of escaped stuff.
⍝ "sep" defaults to a comma but that can be changed by specifying a left argument.
 ⎕IO←1 ⋄ ⎕ML←3
 sep←{2=⎕NC ⍵:⍎⍵ ⋄ ','}'sep'
 r←(⌽∨\0≠⌽↑∘⍴¨csv)/csv          ⍝ remove empty stuff from the end if any
 bool←{~{⍵∨≠\⍵}'"'=⍵}¨r         ⍝ prepare booleans useful to mask escaped stuff
 r←⊃r{⍺⊂⍨⍵≠sep}¨bool{⍺\⍺/⍵}¨r   ⍝ partition fields by unmasked commas
 r←{'"'≠1⍴⍵:⍵ ⋄ ¯1↓1↓⍵}¨r       ⍝ remove leading and trailing "
 r←Csv2Numeric r                ⍝ Convert numeric cells
 r←(~'""'∘⍷¨r)/¨r               ⍝ double-" into a single one
∇

∇r←{sep} DealWithCsv filename;data
⍝ Read "filename" which is assumed to be a *.csv file
⍝ and convert it into a matrix
 sep←{2=⎕NC ⍵:⍎⍵ ⋄ ','}'sep'
⍝ data←FileRead filename
 tie ← filename ⎕NTIE 0
 data ← ⎕NREAD tie 80 (⎕NSIZE tie) 0
 data ← PartitionRecordsWithDyalog data
 r←sep Csv2MatrixWithDyalog data
∇
