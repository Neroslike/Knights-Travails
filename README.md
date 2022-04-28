Exercise from [The Odin Project](https://www.theodinproject.com/lessons/ruby-knights-travails)

Script to output the path a knight in chess would make to reach it's destination.

Hardest exercise I've done until now, I had a hard time wrapping my head around graphs and its similarities to a binary tree, tried
implementing an undirected graph but soon found out that would be a headache to deal with, so instead I used a directed graph and
built a tree containing all possible moves from the starting point and all it's vertices aswell (Using recursion) until i had a
tree with 64 elements, then use BFS to search for the goal square, when found it would return to it's parent until the parent was nil,
meaning it's the start of the tree (The starting point).
