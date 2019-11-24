--Example realization for Toki Lili decoder in Lua
--See LICENSE for licensing infromation

local cs="jklmnpstw" --consonants
local vs="aeiou" --vowels
local function toSyl(ch,skipc,cap)
 v=ch%5+1--vowel code
 c=skipc and 0 or (ch//5+1)--consonant code
 c=cs:sub(c,c)
 v=vs:sub(v,v)
 if cap then
  c=c:upper()
 end
 return c..v
end

local s=io.read()
local out,ch="",0
local skipc=false --skip consonant
local esc=false --escape char(w)
local cap=false --capitalized(x)

while s~="" do
 --print(s)
 ch=s:sub(1,1):byte()
 --print(ch)
 if esc then
  ch=string.char(ch)
  esc=false
 elseif not (ch < 65 or ch > 90) then --Syllable byte (Caps)
  ch=toSyl(ch-65,skipc,cap)
  skipc,cap=false,false
 elseif not (ch < 97 or ch > 118) then --Syllable byte (Non-Caps)
  ch=toSyl(ch-71,skipc,cap)
  skipc,cap=false,false
 elseif ch==119 then --ESC-byte
  ch=""
  esc=true
 elseif ch==120 then --NCC-byte
  ch=""
  cap=true 
 elseif ch==121 then --N-byte
  ch="n"
 elseif ch==122 then --SRC-byte
  if out:len()>0 then
   ch=" "
  else
   ch=""
  end
  skipc=true
 else
  ch=string.char(ch)
 end
 s=s:sub(2) --Remove last character
 out=out..ch
end
print(out)
