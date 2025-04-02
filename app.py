from flask import Flask

app_name = 'cardif-poc'
app = Flask(app_name)

@app.route('/')
def hello_world():
    return f'Hello World from {app_name}!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)