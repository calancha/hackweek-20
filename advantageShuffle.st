" https://leetcode.com/explore/challenge/card/march-leetcoding-challenge-2021/591/week-4-march-22nd-march-28th/3683/ "

advantageCount := [:A :B |
  |sortedA sortedB assigned remaining idx result|
  sortedA := A sorted.
  sortedB := B sorted.

  assigned := Dictionary new.
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
  result.
].


" Tests "

" (advantageCount value: #(2 7 11 15) value: #(1 10 4 11)) printNl. "
" => OrderedCollection (2 11 7 15 ) "

" (advantageCount value: #(12 24 8 32)  value: #(13 25 32 11)) printNl. "
" => OrderedCollection (24 32 8 12 ) "

" (advantageCount value: #(2 0 4 1 2)  value: #(1 3 0 0 2)) printNl. "
" => OrderedCollection (2 0 2 1 4 ) "
