" Problem https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3685/ "

OrderedCollection extend [
    wordSubsetsWith: words [
        |N count freqMax result|
        N := 26.
        count := [:word|
            |freq|
            freq := Array new: N withAll: 0.
            word do: [:c|
                |idx|
                idx := 1 + (c codePoint - $a codePoint).
                freq at: idx put: (1 + (freq at: idx)).
            ].
            freq
        ].

        freqMax := Array new: N withAll: 0.
        words do: [:word|
            |freqW|
            freqW := count value: word.
            1 to: N do: [:i|
                freqMax at: i put: ( (freqW at: i) max: (freqMax at: i) ).
            ].
        ].
        
        result := OrderedCollection new.
        self do: [:elt|
            |universalWord freqElt idx|
            universalWord := true.
            freqElt := count value: elt.

            idx := 1.
            [(idx <= N) & universalWord]
                            whileTrue: [
                                |mulElt mulMax|
                                mulElt := freqElt at: idx.
                                mulMax := freqMax at: idx.
                                (mulElt < mulMax) ifTrue: [universalWord := false].
                                idx := idx + 1.
                            ].
            (universalWord) ifTrue: [result add: elt].
        ].
        ^result
    ]
]

" Tests "

True extend [
    Object >> should: aBlock [ aBlock value assert ]
    assert [ 'passed' printNl ]
]

False extend [
    Object >> shouldnt: aBlock [ aBlock value not assert ]
    assert [ self error: 'failed' ]
]


Eval [
    |wordsA wordsB result|

    wordsA := OrderedCollection from: #('amazon' 'apple' 'facebook' 'google' 'leetcode').
    wordsB := OrderedCollection from: #('e' 'o').
    result := OrderedCollection from: #('facebook' 'google' 'leetcode').
    self should: [(wordsA wordSubsetsWith: wordsB) = result].

    wordsA := OrderedCollection from: #('amazon' 'apple' 'facebook' 'google' 'leetcode').
    wordsB := OrderedCollection from: #('e' 'oo').
    result := OrderedCollection from: #('facebook' 'google').
    self should: [(wordsA wordSubsetsWith: wordsB) = result].

    wordsA := OrderedCollection from: #('amazon' 'apple' 'facebook' 'google' 'leetcode').
    wordsB := (OrderedCollection from: #('lo' 'eo')).
    result := OrderedCollection from: #('google' 'leetcode').
    self should: [(wordsA wordSubsetsWith: wordsB) = result].

    wordsA := OrderedCollection from: #('amazon' 'apple' 'facebook' 'google' 'leetcode').
    wordsB := OrderedCollection from: #('ec' 'oc' 'ceo').
    result := OrderedCollection from: #('facebook' 'leetcode').
    self should: [(wordsA wordSubsetsWith: wordsB) = result].

]    
