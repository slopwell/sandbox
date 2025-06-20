from __future__ import annotations
from typing import Protocol

class SplitTable(Protocol):
    cost: int
    name: str

    def split_in_half(self) -> tuple[SplitTable, SplitTable]:
        """実装不要"""

class BLTSandwich:
    def __init__(self) -> None:
        self.cost = 6.25
        self.name = "BLT"

    def split_in_half(self) -> tuple[BLTSandwich, BLTSandwich]:
        return self, BLTSandwich(self.cost, self.name)
    
    def split_dish(dish: SplitTable) -> tuple[SplitTable, SplitTable]:
        pass
