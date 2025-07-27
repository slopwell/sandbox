from strands import Agent
from strands_tools import http_request
from typing import Dict, Any

# Define a weather-focused system prompt
WEATHER_SYSTEM_PROMPT =  """あなたはHTTP機能を持つ天気アシスタントです。以下のことができます：

アメリカ国立気象局 (National Weather Service) APIへのHTTPリクエストの実行

天気予報データの処理と表示

米国内の場所の天気情報の提供

天気情報を取得する際は：

まず、https://api.weather.gov/points/{latitude},{longitude} または https://api.weather.gov/points/{zipcode} を使用して、座標またはグリッド情報を取得します。

次に、返された予報URLを使用して、実際の予報を取得します。

応答を表示する際は：

天気データを人間が読みやすい形式で整形します

気温、降水量、警報などの重要な情報を強調します

エラーを適切に処理します

専門用語をユーザーフレンドリーな言葉に変換します

常に気象状況を明確に説明し、予報に文脈を提供してください。
"""

# The handler function signature `def handler(event, context)` is what Lambda
# looks for when invoking your function.
def handler(event: Dict[str, Any], _context) -> str:
    weather_agent = Agent(
        model="amazon.nova-lite-v1:0",
        system_prompt=WEATHER_SYSTEM_PROMPT,
        tools=[http_request],
    )

    response = weather_agent(event.get('prompt'))
    return str(response)
