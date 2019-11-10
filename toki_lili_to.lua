--Example realization for Toki Lili encoder in Lua
--See LICENSE for licensing infromation
--WARNING: escape markers '\' are placed manually and converted to 'w' in the output

local cs="jklmnpstw" --consonants
local vs="aeiou" --vowels
local function fromSyl(syl)
 local code=""
 local first=syl:sub(1,1)
 local c,v=0,0
 local n=syl:sub(-1)=="n"
 local cap=false
 local skipc=true
 if first:match("%u") then
  cap=true
  syl,first=syl:lower(),first:lower()
 end
 if cs:find(first) then
  c=cs:find(first)-1
  v=vs:find(syl:sub(2,2))-1
  code=c*5+v
  skipc=false
 else
  v=vs:find(first)
  code=9+v
 end
 if code < 26 then
  code=code+65 --(A)
 elseif code~=120 then
  code=code+71 --97(a) - 26
 end
 return (skipc and 'z' or '')..(cap and 'x' or '')..string.char(code)..(n and 'y' or '')
end

local s=io.read().." "
local out,ch="",""
local esc=false

while s~="" do
 ch=s:sub(1,3)
 print(ch)
 if vs:find(ch:sub(1,1)) then
  ch=ch:sub(1,-2)--Remove last char
 end
 if ch:sub(-1)=='n' then
  local next=ch:len()+1
  if vs:find(s:sub(next,next)) then --n is prevowel
   ch=ch:sub(1,-2)--Remove last char
  end
 elseif not vs:find(ch:sub(-1)) then
   ch=ch:sub(1,-2)--Remove last char
 end
 local chl=ch:len()
 if ch:match("^%w?%wn?") and not esc then --If ch is valid
  ch=fromSyl(ch)
  if ch:find('z') and out:sub(-1)==" " then
   out=out:sub(1,-2)--Remove last char
  end
  out=out..ch
 else
  chl=1
  ch=ch:sub(1,1)
  esc=false
  if ch=='\\' then
   esc=true
   out=out..'w'
  else
   out=out..ch
  end
 end
 s=s:sub(chl+1)
end
print(out)
