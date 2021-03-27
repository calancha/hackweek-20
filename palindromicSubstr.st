" Problem https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3686 "

OrderedCollection extend [
    countPalindromicSubstr [
        |N table count start|
        N := self size.
        table := OrderedCollection new: N.
        1 to: N do: [:i| table add: (Array new: N withAll: false)].
        count := 0.

        start := N.
        [start > 0] whileTrue: [
            start to: N do: [:last|
                |length row sidesMatch|
                length := last - start + 1.
                row := table at: start.
                sidesMatch := (self at: start) = (self at: last).
                
                ((length = 1) | ((length = 2) & sidesMatch))
                  ifTrue: [row at: last put: true].
                 ((length > 2) & sidesMatch)
                  ifTrue: [
                      |around|
                      around := (table at: (start + 1)) at: (last - 1).
                      row at: last put: around.
                  ].
                 ((table at: start) at: last)
                  ifTrue: [count := count + 1].
            ].
            start := start - 1.
        ].
        ^count.
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
    |str ksets|
    str := OrderedCollection from: #($a $b $c).
    self should: [str countPalindromicSubstr = 3].

    str := OrderedCollection from: (Array new: 100 withAll: $a).
    self should: [str countPalindromicSubstr = 5050].
    
    str := OrderedCollection from: #($a $a $a).
    self should: [str countPalindromicSubstr = 6].

]    
