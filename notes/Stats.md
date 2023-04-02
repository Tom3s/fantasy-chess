# Trackable stats

## Player Stats

### Overall Stats

> - XP / Levels
> - Matches won
> - Matches lost
> - Matches Drawn
> - win lost ratio
> - number of times first player (who started match)
> - hours played
> - number of moves
> - number of actual attacks
> - number of possible attacks
> - Kills/Match
> - Average response time (how long it took to think)
> - average match time (useful after implementing chess like timer)
> - average match length

### Per Piece Stats

> - times dead
> - killed `<insert piece name here>` # times
> - passive ability used (ex. pawn promotion)
> - times selected
> - times survived
> - times won with piece selected
> - times won without piece selected
> - KD
> - tiles moved

### Ranked

> - ELO duh

## Combat Logging

### Pre Combat

> - selected pieces by players
> - selected positions by players
> - player colors
> - player ELOs

### Per Round

> - Round `nr` - player `name`
> - Player moved piece `pieceName` from `pre` to `post` - attacking piece `pieceName` with `dmg` - `kill`|`no kill`
> - Player used `ability` with `piece`
> - remaining pieces `piece1`,..

### Post Combat

> - Player `name` - won | Draw
> - `nr` rounds played
> - `player1` survivors: `piece1(hp/max)`,.. | `none`
> - `player2` survivors: `piece1(hp/max)`,.. | `none`
> - `winner` gained `x` ELO, `loser` lost `y` ELO
