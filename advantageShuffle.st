" https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3683/ "

OrderedCollection extend [
    advantageCountAgainst: B [
        |sortedA sortedB assigned remaining idx result|
        sortedA := self sorted.
        sortedB := B sorted.

        assigned := LookupTable new.
        B do: [:b | (assigned includesKey: b)
               ifFalse: [assigned at: b put: OrderedCollection new.].
        ].

        remaining := OrderedCollection new.

        idx := 1.
        sortedA do: [:a |
            |elt|
            elt := sortedB at: idx.
            (a > elt)
                  ifTrue: [(assigned at: elt) addLast: a. idx := idx + 1]
                  ifFalse: [remaining addLast: a].
        ].

        result := OrderedCollection new.
        B do: [:b |
            |cand|
            ((assigned includesKey: b) & ((assigned at: b) size > 0))
           ifTrue: [cand := (assigned at: b) removeLast.]
           ifFalse: [cand := remaining removeLast.].
            result addLast: cand.

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
    A := OrderedCollection from: #(2 7 11 15).
    B := OrderedCollection from: #(1 10 4 11).
    result := A advantageCountAgainst: B.
    expected := (OrderedCollection from: #(2 11 7 15)).
    self should: [result = expected].

    A := OrderedCollection from: #(12 24 8 32).
    B := OrderedCollection from: #(13 25 32 11).
    result := A advantageCountAgainst: B.
    expected := (OrderedCollection from: #(24 32 8 12)).
    self should: [result = expected].

    A := OrderedCollection from: #(2 0 4 1 2).
    B := OrderedCollection from: #(1 3 0 0 2).
    result := A advantageCountAgainst: B.
    expected := (OrderedCollection from: #(2 0 2 1 4)).
    self should: [result = expected].

]
