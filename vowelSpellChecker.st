" Problem: https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3681/ "

mask := [:word |
         key := OrderedCollection new.
          word asLowercase do: [:c |
                             c isVowel
                               ifTrue: [key add: $*]
                               ifFalse: [key add: c].
          ].
  key asString.
].

spellChecker := [ :wordlist :queries |
  " Set with the exact matches. "
  wordSet := wordlist asSet.

  " Dictionary with matches upto case. "
  wordDictCase := LookupTable new.
  wordlist reverse do: [:w | wordDictCase add: w asLowercase -> w].
  
  " Matches upto vowel differences. "
  wordDictMask := LookupTable new.
  wordlist reverse do: [:w | wordDictMask add: (mask value: w )-> w ].

  result := OrderedCollection new.
  " Process all queries. "
  queries do: [:q |
    (wordSet includes: q)
            " Exact match. "
            ifTrue: [ result add: q]

            ifFalse: [ target := q asLowercase.
                       (wordDictCase includesKey: target)
                                    " Match upto case. "
                                    ifTrue: [result add: target]

                                    ifFalse: [maskTarget := mask value: target.
                                              (wordDictMask includesKey: maskTarget)
                                               " Match upto vowel. "
                                               ifTrue: [result add: (wordDictMask at: maskTarget)]
                                               " No match. "
                                               ifFalse: [result add: ''].
                                    ].
            ].
  ].
  result
]



" Tests "

" (spellChecker value: #('ae' 'aa') value: #('UU' 'aA' 'fo' 'io')) printNl. "
" => OrderedCollection ('ae' 'aa' '' 'ae' ) "


" (spellChecker value: #('KiTe' 'kite' 'hare' 'Hare') value: #('kite' 'Kite' 'KiTe' 'Hare' 'HARE' 'Hear' 'hear' 'keti' 'keet' 'keto')) printNl. "
" => OrderedCollection ('kite' 'kite' 'KiTe' 'Hare' 'hare' '' '' 'KiTe' '' 'KiTe' ) "
