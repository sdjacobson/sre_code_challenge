from config import Config
from flask import Flask
from flaskext.mysql import MySQL


mysql = MySQL()
app = Flask(__name__)

def create_app():
    # Allows you to get configurations
    # from the config file with the environment
    # that you require
    app.config.from_object((get_environment_config()))

mysql.init_app(app)

def get_environment_config():
    if Config.ENV == "PRODUCTION":
        return "config.ProductionConfig"
    elif Config.ENV == "DEVELOPMENT":
        return "config.DevelopmentConfig"

@app.route("/message")
def message():
    cursor = mysql.connect().cursor()
    cursor.execute("SELECT message from mytable where 1")
    return cursor.fetchone()


if __name__ == "__main__":
    app.run()
