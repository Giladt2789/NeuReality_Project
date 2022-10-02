from flask import Flask, request, render_template
import functions
import json

app = Flask(__name__)

@app.route('/reverse', methods=['GET'])
def home():
    if request.method == 'GET':
        string = request.args.get('q')
        backwords = functions.reverse_string(string)
        d = dict([ ("Result", backwords) ])
        return render_template('reverse.html', backwords = json.dumps(d))

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8182)
