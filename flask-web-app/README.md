# Flask Web Application

This is a simple web application built using Flask, a lightweight WSGI web application framework in Python. The application demonstrates basic features such as routing, templates, and static file handling.

## Project Structure

```
flask-web-app
├── app
│   ├── __init__.py          # Initializes the Flask application
│   ├── routes.py            # Defines the application routes
│   ├── models.py            # Contains data models
│   ├── static
│   │   └── styles.css       # CSS styles for the application
│   └── templates
│       ├── base.html        # Base HTML template
│       ├── index.html       # Main landing page
│       └── about.html       # About page
├── tests
│   └── test_app.py          # Unit tests for the application
├── .gitignore                # Specifies files to ignore in version control
├── requirements.txt          # Lists project dependencies
├── config.py                 # Configuration settings for the application
├── run.py                    # Entry point for running the application
└── README.md                 # Project documentation
```

## Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   cd flask-web-app
   ```

2. Create a virtual environment:
   ```
   python -m venv venv
   ```

3. Activate the virtual environment:
   - On Windows:
     ```
     venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```
     source venv/bin/activate
     ```

4. Install the required dependencies:
   ```
   pip install -r requirements.txt
   ```

## Running the Application

To run the application, execute the following command:
```
python run.py
```

The application will be accessible at `http://127.0.0.1:5000`.

## Testing

To run the tests, use the following command:
```
python -m unittest discover -s tests
```

## License

This project is licensed under the MIT License.