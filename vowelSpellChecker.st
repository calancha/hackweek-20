" Problem: https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3681/ "

OrderedCollection extend [
    spellChecker: queries [
        |mask wordSet wordDictCase wordDictMask result|
        mask := [:word |
            |key|
            key := OrderedCollection new.
            word asLowercase do: [:c |
                c isVowel
                               ifTrue: [key add: $*]
                               ifFalse: [key add: c].
            ].
            key asString.
        ].

        " Set with the exact matches. "
        wordSet := self asSet.

        " Dictionary with matches upto case. "
        wordDictCase := LookupTable new.
        self reverse do: [:w | wordDictCase add: w asLowercase -> w].
        
        " Matches upto vowel differences. "
        wordDictMask := LookupTable new.
        self reverse do: [:w | wordDictMask add: (mask value: w )-> w ].

        result := OrderedCollection new.
        " Process all queries. "
        queries do: [:q |
            (wordSet includes: q)
                " Exact match. "
            ifTrue: [ result add: q]

            ifFalse: [ |target maskTarget|
                        target := q asLowercase.
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
        ^result
    ]
]


" Tests "

True extend [
    Object >> should: aBlock [ aBlock value assert ]
    assert [ 'passed' printNl ]
].

False extend [
    Object >> shouldnt: aBlock [ aBlock value not assert ]
    assert [ self error: 'failed' ]
].

Eval [
    |result expected A B|
    wordlist := OrderedCollection from: #('ae' 'aa').
    queries := OrderedCollection from: #('UU' 'aA' 'fo' 'io').
    result := wordlist spellChecker: queries.
    expected := OrderedCollection from: #('ae' 'aa' '' 'ae' ).
    self should: [result = expected].

    wordlist := OrderedCollection from: #('KiTe' 'kite' 'hare' 'Hare').
    queries := OrderedCollection from: #('kite' 'Kite' 'KiTe' 'Hare' 'HARE' 'Hear' 'hear' 'keti' 'keet' 'keto').
    result := wordlist spellChecker: queries.
    expected := OrderedCollection from: #('kite' 'kite' 'KiTe' 'Hare' 'hare' '' '' 'KiTe' '' 'KiTe').
    self should: [result = expected].


]
