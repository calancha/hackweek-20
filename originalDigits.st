" Problem https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3687/ "

OrderedCollection extend [
    originalDigits [
        |freq number2Word number2Target multiplicities result res|
        freq := LookupTable new: self size.
        self do: [:ch |
            (freq includesKey: ch)
                ifTrue: [freq at: ch put: (freq at: ch) + 1]
                ifFalse: [freq at: ch put: 1].
        ].
        number2Word := LookupTable new: 10.
        number2Word at: 0 put: 'zero'.
        number2Word at: 1 put: 'one'.
        number2Word at: 2 put: 'two'.
        number2Word at: 3 put: 'three'.
        number2Word at: 4 put: 'four'.

        number2Word at: 5 put: 'five'.
        number2Word at: 6 put: 'six'.
        number2Word at: 7 put: 'seven'.
        number2Word at: 8 put: 'eight'.
        number2Word at: 9 put: 'nine'.
        " Letter to uniquely select each number. "
        number2Target := LookupTable new: 10.
        number2Target at: 0 put: $z.
        number2Target at: 2 put: $w.
        number2Target at: 4 put: $u.
        number2Target at: 6 put: $x.
        number2Target at: 8 put: $g.

        number2Target at: 1 put: $o.
        number2Target at: 3 put: $t.
        number2Target at: 5 put: $f.
        number2Target at: 7 put: $s.
        number2Target at: 9 put: $i.

        multiplicities := Array new: 10 withAll: 0.
        " Remove them in the right order.          "
        #(0 2 4 6 8 1 3 5 7 9) do: [:number|
            |idx word targetLetter|
            idx := number + 1.
            word := number2Word at: number.
            targetLetter := number2Target at: number.
            (freq includesKey: targetLetter)
                " At this point, the targetLetter is unique for word; thus, we "
                " can use it to obtain the number of times that word appears in counter. "
                ifTrue: [
                    |mult|
                    mult := freq at: targetLetter.
                    multiplicities at: idx put: mult.
                    word do: [:ch|
                        (freq includesKey: ch)
                        ifTrue: [freq at: ch put: ((freq at: ch) - mult)]
                    ].
                ].
        ].
        result := OrderedCollection new.
        0 to: 9 do: [:i |
            |mult|
            mult := (multiplicities at: (i + 1)).
            (mult > 0) ifTrue: [result add: (Array new: mult withAll: i asString)]
        ].
        ^result join join.
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
    |col|
    col :=  OrderedCollection from: 'nnei'.
    self should: [(col originalDigits = '9')].

    col :=  OrderedCollection from: 'zerozero'.
    self should: [col originalDigits = '00'].

    col :=  OrderedCollection from: 'owoztneoer'.
    self should: [col originalDigits = '012'].

    col :=  OrderedCollection from: 'fviefuro'.
    self should: [col originalDigits = '45'].

    col :=  OrderedCollection from: 'zeroonetwothreefourfivesixseveneightnine'.
    self should: [col originalDigits = '0123456789'].
]    
