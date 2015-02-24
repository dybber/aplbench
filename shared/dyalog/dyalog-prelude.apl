⍝ Make sure we are 1-indexing
⎕IO ← 1

csv←import'../../shared/dyalog/csv.apl'
ReadCSVDouble ← csv.read
ReadCSVInt ← csv.read

w ← 32 ⍝ word size
dec2bin ← {(w⍴2)⊤⍵}
bin2dec ← {(w⍴2)⊥⍵}

⍝ Bitwise operations
sll ← {bin2dec (⍵↓dec2bin ⍺),⍵⍴0}
srl ← {bin2dec (⍵⍴0),(-⍵)↓dec2bin ⍺}
xor ← {bin2dec (dec2bin ⍺) ≠ dec2bin ⍵}
testBit ← {(dec2bin ⍵)[w-⍺-1]} ⍝ Does not work for other than scalar arguments!

days←{                                      ⍝ Days since 1899-12-31 (Meeus).
    ⍺←17520902                              ⍝ start of Gregorian calendar.
    yy mm dd h m s ms←7↑⊂[⍳¯1+⍴⍴⍵]⍵         ⍝ ⎕ts-style 7-item date-time.   <V>
    D←dd+(0 60 60 1000⊥↑h m s ms)÷86400000  ⍝ day with fractional part.
    Y M←yy mm+¯1 12×⊂mm≤2                   ⍝ Jan, Feb → month 13 14.
    A←⌊Y÷100                                ⍝ century number.
    B←(⍺<0 100 100⊥↑yy mm dd)×(2-A)+⌊A÷4    ⍝ Gregorian calendar correction.
    ¯2416544+D+B+⊃+/⌊365.25 30.6×Y M+4716 1 ⍝ (fractional) days.
}

unix_time_ms ← 86400000∘×∘(-∘25568)∘days

now ← { unix_time_ms ⎕TS }
