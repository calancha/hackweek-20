" Problem: https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3682/
"

OrderedCollection extend [

    threeSumMulti: target [
        |freq freqKeys ans|
        " Frequencies per each element in self "
        freq := LookupTable new.
        self do: [:elt |
            (freq includesKey: elt)
                                ifTrue: [freq at: elt put: (freq at: elt) + 1]
                                ifFalse: [freq at: elt put: 1].
        ].

        ans := 0.
        freqKeys := freq keys.
        " The three numbers are different. "
        1 to: (freqKeys size - 1) do: [:i |
            i + 1 to: freqKeys size do: [:j |
                (i < j & j < (target - i - j) & (freq includesKey: target - i - j))
                             ifTrue: [ans := ans + ((freq at: i) * (freq at: j) * (freq at: target - i - j))].
            ].
            
        ].

        freqKeys do: [:key |
            |value thirdKey|
            value := freq at: key.
            thirdKey := target - (2 * key).
            (3 * key ~= target)
                " Two numbers are the same. "
                       ifTrue: [(freq includesKey: thirdKey)
                                 ifTrue: [ans := ans + ((value * (value - 1) * (freq at: thirdKey)) // 2)].
                       ]
                " The three numbers are equal. "
                       ifFalse: [ans := ans + ((value * (value - 1) * (value - 2)) // 6)].
        ].
        ^ans \\ ((10 raisedTo: 9) + 7)
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
    |result expected arr target|
    arr := OrderedCollection from: #(1 1 2 2 3 3 4 4 5 5).
    target := 8.
    result := arr threeSumMulti: target.
    expected := 20.
    self should: [result = expected].

    arr := OrderedCollection from: #(1 1 2 2 2 2).
    target := 5.
    result := arr threeSumMulti: target.
    expected := 12.
    self should: [result = expected].


]    
