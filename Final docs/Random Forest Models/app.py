from flask import Flask, request, render_template
import joblib
import pandas as pd
import numpy as np

# Load model and preprocessors
rf_model = joblib.load('rf_model.pkl')
mlb = joblib.load('mlb.pkl')
scaler = joblib.load('scaler.pkl')
feature_columns = joblib.load('feature_columns.pkl')

# Expected numeric features
numeric_columns = ['rating', 'meta_score', 'number_rating', 'weekly_hours_viewed', 'log_votes', 'movie_age']

# Rating mapping
rating_map = {
    'G': 1,
    'PG': 2,
    'PG-13': 3,
    'R': 4,
    'NC-17': 5,
    'NR': 0,
    'Unrated': 0
}

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get form data
        data = request.form.to_dict()

        # Set default values for optional fields
        data.setdefault('weekly_hours_viewed', 0)
        data.setdefault('cast2', 'Unknown')
        data.setdefault('cast3', 'Unknown')
        data.setdefault('cast4', 'Unknown')

        # Convert numeric fields
        data['rating'] = float(data['rating'])
        data['meta_score'] = int(data['meta_score'])
        data['votes'] = int(data['votes'])
        data['year'] = int(data['year'])
        data['weekly_hours_viewed'] = float(data['weekly_hours_viewed'])
        data['number_rating'] = rating_map.get(data['rating_label'], 0)

        # Create DataFrame
        df = pd.DataFrame([data])
        df['log_votes'] = np.log(df['votes'])
        df['movie_age'] = 2025 - df['year']
        df['all_genres'] = df['genre'].apply(lambda x: x.split(', '))

        # Scale numeric features
        numeric_df = df[numeric_columns]
        numeric_scaled = pd.DataFrame(scaler.transform(numeric_df), columns=numeric_columns)

        # Encode genres
        genre_dummies = pd.DataFrame(
            mlb.transform(df['all_genres']),
            columns=[f"genre_{g}" for g in mlb.classes_]
        )

        # Encode categorical
        cat_df = pd.get_dummies(df[['cast1', 'cast2', 'cast3', 'cast4', 'director']])

        # Combine all features
        X_input = pd.concat([numeric_scaled, genre_dummies, cat_df], axis=1)

        # Align columns to match training
        for col in feature_columns:
            if col not in X_input.columns:
                X_input[col] = 0
        X_input = X_input[feature_columns]

        # Predict
        prediction = rf_model.predict(X_input)[0]
        result = 'Yes, it will be in the Netflix Top 10!' if prediction == 1 else 'Sorry, this movie will not make the cut.'

        return render_template('index.html', prediction_result=result)

    except Exception as e:
        print("Error during prediction:", e)
        return render_template('index.html', prediction_result=f'Error: {str(e)}')

if __name__ == '__main__':
    app.run(debug=True, port=5001)