from opentelemetry.instrumentation.flask import FlaskInstrumentor

from app import app

FlaskInstrumentor().instrument_app(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='9600')
