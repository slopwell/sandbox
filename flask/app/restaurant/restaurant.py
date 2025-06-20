from __future__ import annotations
from restaurant import geo, operations as ops

class Restaurant:
    def __init__(self, name:str, localtion:geo.Coordinates, emploees:list[ops.Employees], inventory:list[ops.Ingredient], menu:ops.Menu, finances:ops.Finance):
        self.name = name
        self.location = localtion
        self.employees = emploees
        self.inventory = inventory
        self.menu = menu
        self.finances = finances
    
    def transfer_employee(self, employee:ops.Employee, restaurant:Restaurant):
        # 他のレストランに従業員を移動する
        return

    def order_dish(self, dish:ops.Dish):
        # メニューから料理を注文する
        return
    

class FoodTrack(Restaurant):
    def __init__(self, name:str, localtion:geo.Coordinates, emploees:list[ops.Employees], inventory:list[ops.Ingredient], menu:ops.Menu, finances:ops.Finance, foodTruckType:str):
        super().__init__(name, localtion, emploees, inventory, menu, finances)
        self.foodTruckType = foodTruckType
    
    def move(self, location:geo.Coordinates):
        # フードトラックを移動する
        return

    def park(self):
        # フードトラックを駐車する
        return

    def serve(self, dish:ops.Dish):
        # 料理を提供する
        return

    def prepare(self, dish:ops.Dish):
        # 料理を準備する
        return

    