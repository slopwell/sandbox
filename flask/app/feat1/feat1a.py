from typing import TypedDict, TypeVar

class Range(TypedDict):
    min: int
    max: int

class NutritionInfo(TypedDict):
    value: int
    unit: str
    confidenceRange95Percent: Range
    
class RecipeNutrition(TypedDict):
    calories: NutritionInfo
    protein: NutritionInfo
    fat: NutritionInfo
    carbohydrates: NutritionInfo

T = TypeVar('T')
def reverse(value: T) -> T:
    return value[::-1]

if __name__ == "__main__":
    nutritionInfo: RecipeNutrition = {
        'calories': {
            'value': 270,
            'unit': 'cal',
            'confidenceRange95Percent': {
                'min': 256,
                'max': 284
            }
        },
        'carbohydrates': {
            'unit': 'g',
            'confidenceRange95Percent': {
                'min': 28,
                'max': 34
            }
        }
    }

    
