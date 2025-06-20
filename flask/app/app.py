#Flaskとrender_template（HTMLを表示させるための関数）をインポート
from flask import Flask, render_template
from app.feat1 import feat1


#Flaskオブジェクトの生成
app = Flask(__name__)


#「/」へアクセスがあった場合に、"Hello World"の文字列を返す
@app.route("/")
def hello():
    return "Hello World"

@app.route("/feat1")
def execFeat1():
    f1 = feat1.Feat1()
    f1.print_test("my","-test")
    return

#「/index」へアクセスがあった場合に、「index.html」を返す
@app.route("/index")
def index():
    return render_template("index.html")
