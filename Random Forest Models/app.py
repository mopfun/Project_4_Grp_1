from flask import Flask, request, jsonify
import joblib
import pandas as pd
import numpy as np

# Load model and preprocessing objects
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

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()

        # Essential fields (must be included)
        required_fields = ['rating', 'meta_score', 'votes', 'year', 'genre', 'cast1', 'director', 'rating_label']
        for field in required_fields:
            if field not in data:
                return jsonify({'error': f'Missing required field: {field}'}), 400

        # Set defaults for optional fields
        data.setdefault('weekly_hours_viewed', 0)
        data.setdefault('cast2', 'Unknown')
        data.setdefault('cast3', 'Unknown')
        data.setdefault('cast4', 'Unknown')

        # Convert to DataFrame
        df = pd.DataFrame([data])

        # Convert rating_label to number_rating
        df['number_rating'] = df['rating_label'].map(rating_map).fillna(0)

        # Create derived columns
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

        # Combine features
        X_input = pd.concat([numeric_scaled, genre_dummies, cat_df], axis=1)

        # Align to expected feature columns
        for col in feature_columns:
            if col not in X_input.columns:
                X_input[col] = 0
        X_input = X_input[feature_columns]

        # Predict
        prediction = rf_model.predict(X_input)[0]
        result = 'Top 10' if prediction == 1 else 'Not Top 10'

        return jsonify({'prediction': result})

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
