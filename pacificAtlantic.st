" Problem https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3684/ "


OrderedCollection extend [
    pacificAtlantic [
        |numRows numCols pacificQueue atlanticQueue bfs pacificReachable atlanticReachable|
        (self isEmpty)
            ifTrue: [^ OrderedCollection new].

        numRows := self size.
        numCols := (self at: 1) size.

        " Setup each queue with cells adjacent to their respective ocean "
        pacificQueue := SharedQueue new.
        atlanticQueue := SharedQueue new.

        1 to: numRows do: [:i |
            |pacificPair atlanticPair|
            pacificPair := OrderedCollection new.
            pacificPair add: i.
            pacificPair add: 1.
            pacificQueue nextPut: pacificPair.

            atlanticPair := OrderedCollection new.
            atlanticPair add: i.
            atlanticPair add: numCols.
            atlanticQueue nextPut: atlanticPair.

        ].

        1 to: numCols do: [:i |
            |pacificPair atlanticPair|
            pacificPair := OrderedCollection new.
            pacificPair add: 1.
            pacificPair add: i.
            pacificQueue nextPut: pacificPair.

            atlanticPair := OrderedCollection new.
            atlanticPair add: numRows.
            atlanticPair add: i.
            atlanticQueue nextPut: atlanticPair.

        ].

        " BFS algorithm "
        bfs := [:queue |
            |reachable|
            reachable := Set new.
            [queue isEmpty]
                whileFalse: [
                    |curCell row col pair|
                    curCell := queue next.
                    row := curCell at: 1.
                    col := curCell at: 2.
                    reachable add: curCell.

                    #(#(1 0) #(-1 0) #(0 1) #(0 -1)) do: [:move |
                        |newRow newCol|
                        newRow := row + (move at: 1).
                        newCol := col + (move at: 2).
                        " Check if the new cell is within bounds "
                        (newRow < 1 | (newRow > numRows) | (newCol < 1) | (newCol > numCols))
                                          ifFalse: [
                                              " Check that the new cell hasn't already been visited "
                                              pair := OrderedCollection new.
                                              pair add: newRow.
                                              pair add: newCol.
                                              (reachable includes: pair)
                                               ifFalse: [
                                                   " Check that the new cell has a higher or equal height, "
                                                   " So that water can flow from the new cell to the old cell "
                                                   (((self at: newRow) at: newCol) < ((self at: row) at: col))
                                                   ifFalse: [queue nextPut: pair].
                                               ].
                                          ].
                    ].

                ].
            reachable
        ].

        pacificReachable := (bfs value: pacificQueue).
        atlanticReachable := (bfs value: atlanticQueue).

        " The solution is the interseciton of the two sets. "
        ^pacificReachable & atlanticReachable

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
    |expected matrix result|
    expected := Set new.
    expected add: (OrderedCollection from: #(4 1)).
    expected add: (OrderedCollection from: #(5 1)).
    expected add: (OrderedCollection from: #(4 2)).
    expected add: (OrderedCollection from: #(1 5)).
    expected add: (OrderedCollection from: #(2 4)).
    expected add: (OrderedCollection from: #(2 5)).
    expected add: (OrderedCollection from: #(3 3)).

    matrix := OrderedCollection new.
    matrix add: (OrderedCollection from: #(1 2 2 3 5)).
    matrix add: (OrderedCollection from: #(3 2 3 4 4)).
    matrix add: (OrderedCollection from: #(2 4 5 3 1)).
    matrix add: (OrderedCollection from: #(6 7 1 4 5)).
    matrix add: (OrderedCollection from: #(5 1 1 2 4)).

    result := matrix pacificAtlantic.
    self should: [((result <= expected) & (expected <= result))].
]    
