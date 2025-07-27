from strands import Agent, tool
from strands_tools import calculator, current_time, python_repl
import json

# Define a custom tool as a Python function using the @tool decorator
@tool
def letter_counter(word: str, letter: str) -> int:
    """
    Count occurrences of a specific letter in a word.

    Args:
        word (str): The input word to search in
        letter (str): The specific letter to count

    Returns:
        int: The number of occurrences of the letter in the word
    """
    if not isinstance(word, str) or not isinstance(letter, str):
        return 0

    if len(letter) != 1:
        raise ValueError("The 'letter' parameter must be a single character")

    return word.lower().count(letter.lower())


# Create an agent with tools from the strands-tools example tools package
# as well as our custom letter_counter tool
agent = Agent(
    model="amazon.nova-lite-v1:0",
    tools=[calculator, current_time, python_repl, letter_counter]
)

def handler(event, context):
    """
    AWS Lambda handler function
    """
    try:
        # Extract message from event
        message = event.get('message', '')

        if not message:
            # Default message if none provided
            message = """
ご要望が4点ございます。

1. 現在の時刻は何時ですか？
2. 3111696/74088 を計算してください。
3. "strawberry" 🍓という単語に文字 'r' はいくつ含まれていますか？
4. 今話した内容を実行するスクリプトを出力してください。
    出力する前に、Pythonツールを使用してスクリプトが動作することを確認してください。
"""

        # Run the agent
        response = agent(message)

        return {
            'statusCode': 200,
            'body': json.dumps({
                'response': str(response),
                'message': 'Agent executed successfully'
            })
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e),
                'message': 'Error executing agent'
            })
        }

# Original code for direct execution
if __name__ == "__main__":
    message = """
ご要望が4点ございます。

1. 現在の時刻は何時ですか？
2. 3111696/74088 を計算してください。
3. "strawberry" 🍓という単語に文字 'r' はいくつ含まれていますか？
4. 今話した内容を実行するスクリプトを出力してください。
    出力する前に、Pythonツールを使用してスクリプトが動作することを確認してください。


"""
    agent(message)
