**Toki Lili** is a coding/compression algorithm for [Toki Pona](http://tokipona.org), representing one CV (consonant+vowel) syllable as one byte. Additionally it has bytes for escape characters (ESC), next character capitalization (CAP), finale 'N' (N) and removing the following consonant (SRC) that let to code V and (C)VC syllables and ASCII characters as well.  
# How Does It Work?
1. A Toki Pona word divides into syllables according to the syllable rules of the language  
2. Each syllable are converted by the following rules:
- If the syllable is **CVC** or **VC**, it's converted as a **(C)V** syllabe with appending an N-byte  
- If the syllable is **V**, it's converted as a **CV** syllable with any C and a SRC-byte instead of the space before it  
- If the syllable is **CV**, it's converted into a numeral code `i` from this table:  
  
| Initiale | -a | -e | -i | -o | -u |  
| :------- | :--: | :--: | :--: | :--: | :--: |   
| j- | 0 | 1 | 2' | 3 | 4 |  
| k- | 5 | 6 | 7 | 8 | 9 |  
| l- | 10 | 11 | 12 | 13 | 14 |  
| m- | 15 | 16 | 17 | 18 | 19 |  
| n- | 20 | 21 | 22 | 23 | 24 |  
| p- | 25 | 26 | 27 | 28 | 29 |  
| s- | 30 | 31 | 32 | 33 | 34 |  
| t- | 35 | 36 | 37' | 38 | 39 |  
| w- | 40 | 41 | 42 | 43' | 44'|  

*NOTE: The forbidden syllables (') are also included to the specification to provide faster decoding*  
Then `i` and the ASCII code of `'A'` (`i < 26`) or `'a'`(`i >= 26`) are sumed into a code, that's repesented as a ASCII character  
3. Decoding is made by vice versa operation: the code converts into a CV syllable that changes accoring to the near control character  
4. Non-TP character are not affected by the coding/decoding process (except '\' and spaces before `SRC`)
# Control Characters  
- `ESC` (Escape character, ID:0x77(w)) - interpret next character as a usual ASCII character (i.e. "wY" is decoded as 'Y', not "pu")  
- `CAP` (Capitalizion, ID:0x78(x)) - the next character will be capitalized (i.e. "xD" is decoded as "Jo", not "jo")  
- `N` (Finale 'N', ID:0x79(y)) - represents the finale "N" in CVC syllables (i.e. "Ly" is decoded as "len", not "le")  
- `SRC` (Space & remove next character,ID:0x7A(z)) - replace the first character of the following syllable with a space (or just remove it if it's first in the line). Always is placed instead of the space. (i.e. "zL" is decoded as "e", not "le")
# Where can it be used?  
The primary property of the algorithm is data compression. Using Toki Lili may save you up to 50% of the text file size, that's useful for storing & sending long texts in Toki Pona. The code use only the visible ASCII characters, so you can store and represent the compressed text as a usual text.  
Additionally, it can used as a primative word cipher. Not for confedence or top secret documents, of course, but it's enough to encrypt something from not sufficiently curious persons or just for fun.
# Credits  
The algorithm is created & tested by AlexanDDOS. You can freely use it for anything (but evil deeds, of course) without permession or obligatory credits, but it'll be better if you mention me anyway.
