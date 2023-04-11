from hypercorn.middleware import AsyncioWSGIMiddleware
from opentelemetry.instrumentation.flask import FlaskInstrumentor

import app import Gpt4AllWebUI, app, args

bot = Gpt4AllWebUI(app, args)

FlaskInstrumentor().instrument_app(wsgi_app.app)

asyncio_app = AsyncioWSGIMiddleware(wsgi_app.app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='9600')
