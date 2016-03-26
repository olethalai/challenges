# Bowling Challenge

From [Programming Praxis](http://programmingpraxis.com/2009/08/11/uncle-bobs-bowling-game-kata/).

> A game of tenpins bowling lasts ten frames, in each of which the bowler makes one or two attempts to knock down ten pins arranged in a triangle. If the bowler knocks down all ten pins on the first attempt (that’s called a “strike”), he scores ten pins plus the number of pins knocked down on his next two rolls. If the bowler knocks down all ten pins after two attempts (that’s called a “spare”), he scores ten pins plus the number of pins knocked down on his next roll. If the bowler fails to knock down all ten pins (that’s called an “open frame”), he scores the number of pins he knocked down. The scores accumulate through all ten frames. At the last frame, if necessary, the pins are reset for one or two additional rolls to count the final bonus.

> **Your task is to write a function that calculates the score of a tenpins bowling game.**

---

`play_ball(players)` takes a positive integer number of players. A new game is created with that many players, and 10 frames are played.

Bonuses owing to previously-achieved strikes or spares are calculated on every frame after the first frame. To correctly calculate frame scores, the next two balls must be tracked in the case of a strike, which means that bonus calculations may sometimes span up to 3 frames. If a player gets a strike twice or more in a row, the score of the original strike frame (frame 1) cannot be fully calculated until two frames later (frame 3). Fortunately, this logic is finite enough that a recursive solution was not necessary. (Although it may have been advantageous!)

Frame 10 has unique logic, and therefore has its own code path. Frame 10 has a variable number of balls, not all of which contribute to the score directly. Configurations for frame 10 include two balls, taking down up to nine pins, three balls out of which the first one made a strike and two were used to calculate the strike bonus, and three balls, out of which two made a spare, and the third was used to calculate the spare bonus.

The score display was updated after each player completed their turn in the frame. Again, unique logic needed to be applied to the drawing of frame 10, owing to the variable number of balls which may be played during the final frame.
