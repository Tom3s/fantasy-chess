# Knight Attack Positions explained

## General attack position

```TypeScript
    function targetTileAfterAttack(localPosition: Vector2i, targetPosition: Vector2i,..) -> Vector2i:
    var normalizedDirection = (localPosition - targetPosition).sign()
    return targetPosition + normalizedDirection
```

> `normalizedDirection` will calculate neighbor position from `targetPosition` towards `localPosition` (relative)

## Knight's attack pattern

> | K |   |   |
> |---|---|---|
> |   |   | T |
>
> K - knight
> T - target

### Positions to check if occupied

> | K | 1 |   |
> |---|---|---|
> |   |   | T |
>
> - `targetPosition + normalizedDirection`
>
> | K | x |   |
> |---|---|---|
> |   | 2 | T |
>
> - `targetPosition + (normalizedDirection.x, 0)`
>
> | K | x | 3 |
> |---|---|---|
> |   | x | T |
>
> - `targetPosition + (0, normalizedDirection.y)`
>
> | K | x | x |
> |---|---|---|
> | 4 | x | T |
>
> - `finalPosition = (relativePosition + normalizedDirection) * -2`
>   - `relativePosition` = Vector pointing from Knight to Target
>   - `normalizedDirection` = Unit Vector Pointing from Target to Knight
>   - `relativePosition + normalizedDirection` = cancels shorter distance, and leaves 1 in longer
>   - `... * -2` -> flip direction, and get length of 2 back
>   - `return targetPosition + finalPosition`
>
> | K | x | x |
> |---|---|---|
> | x | x | T |
>
> - Knight stays in place