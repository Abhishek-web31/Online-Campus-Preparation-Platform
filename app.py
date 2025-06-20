from flask import Flask, render_template, request, redirect, session, url_for, flash
from flask_mysqldb import MySQL
import google.generativeai as genai
import markdown
import os
import pyttsx3
import requests
import json
import logging
import re
import speech_recognition as sr
import time
from werkzeug.security import generate_password_hash, check_password_hash
from urllib.parse import quote


app = Flask(__name__)
app.secret_key = 'abhi3105'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'campus_prep'

mysql = MySQL(app)
logging.basicConfig(level=logging.INFO)

genai.configure(api_key="AIzaSyCDEJERnQzBiy4A2eqxQ7NPON7fi1ZWDCc")  # Replace with your actual API key

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/about')
def about_page():
    return render_template('about.html')

@app.route('/admin')
def admin_page():
    return render_template('admin.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = generate_password_hash(request.form['password'])
        branch = request.form['branch']
        skills = request.form['skills']
        semester = request.form['semester']
        course = request.form['course']
        known_topics = request.form['known_topics']
        
        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO users(name, email, password, branch, skills, semester, course, known_topics) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", 
            (name, email, password, branch, skills, semester, course, known_topics)
        )
        mysql.connection.commit()
        cur.close()
        return redirect('/login')
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        cur = mysql.connection.cursor()
        cur.execute("SELECT id, password FROM users WHERE email=%s", (email,))
        user = cur.fetchone()
        cur.close()
        if user and check_password_hash(user[1], password):
            session['user_id'] = user[0]
            return redirect('/dashboard')
        flash("Invalid credentials. Please try again.")
    return render_template('login.html')

@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if 'user_id' not in session:
        return redirect('/login')  # If the user is not logged in, redirect to login

    user_id = session['user_id']
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT name, email, branch, skills, semester, course, known_topics
        FROM users WHERE id=%s
    """, (user_id,))
    user_data = cur.fetchone()  # Fetch the user data

    # If no user data is found, handle the case
    if not user_data:
        return "User not found", 404

    cur.close()

    # Pass the user_data variable to the template
    return render_template('dashboard.html', user_data=user_data)

@app.route('/profile')
def profile():
    if 'user_id' not in session:
        return redirect('/login')  # Redirect to login if the user is not logged in

    user_id = session['user_id']
    
    # Fetch user data from the database
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT name, email, branch, skills, semester, course, known_topics
        FROM users WHERE id=%s
    """, (user_id,))
    
    user_data = cur.fetchone()  # This fetches the first matching row
    cur.close()

    if not user_data:
        return "User data not found", 404  # If no data is found, show an error

    # Render the profile page with the user data
    return render_template('profile.html', user_data=user_data)

@app.route('/generate_roadmap')
def generate_roadmap():
    if 'user_id' in session:
        user_id = session['user_id']
        cur = mysql.connection.cursor()
        cur.execute("SELECT name, branch, skills, semester, course, known_topics FROM users WHERE id=%s", (user_id,))
        user_data = cur.fetchone()
        cur.close()
        roadmap, week_allocations = get_roadmap(user_data)
        return render_template('roadmap.html', roadmap=roadmap, week_allocations=week_allocations)
    return redirect('/login')

def get_roadmap(user_data):
    name, branch, skills, semester, course, known_topics = user_data
    model = genai.GenerativeModel("learnlm-1.5-pro-experimental")
    prompt = f"""
    The student is in semester {semester} of {course}.
    They have skills in {skills} and already know {known_topics}.
    Suggest important subjects for placements with resources, and break down a week-by-week study plan.
    """
    response = model.generate_content(prompt)
    
    if response and response.text:
        # Assuming AI gives a week-by-week breakdown
        # Example response (this will vary depending on what the AI generates)
        week_allocations = {
            "Week 1": ["Topic 1", "Topic 2"],
            "Week 2": ["Topic 3", "Topic 4"],
            # Add more weeks as necessary
        }
        # Convert AI response to markdown for the roadmap text
        roadmap = markdown.markdown(response.text) if response and response.text else "Roadmap generation failed."
        return roadmap, week_allocations
    return "Roadmap generation failed.", {}

@app.route('/practice_questions', methods=['GET', 'POST'])
def practice_questions():
    if request.method == 'POST':
        subject = request.form['subject']
        difficulty = request.form['difficulty']
        questions = get_ai_questions(subject, difficulty)
        session['current_questions'] = questions  # Store questions for validation
        return render_template('questions.html', questions=questions, subject=subject, difficulty=difficulty)
    return render_template('select_subject.html')

def get_ai_questions(subject, difficulty):
    model = genai.GenerativeModel("learnlm-1.5-pro-experimental")

    prompt = f"""
    Generate exactly **5 {difficulty}-level multiple-choice questions** for **{subject}**.
    The response must be **valid JSON format** as shown below:

    ```json
    {{
      "questions": [
        {{
          "question": "What is Python?",
          "options": {{
            "a": "A programming language",
            "b": "A snake",
            "c": "A car",
            "d": "A fruit"
          }},
          "answer": "a"
        }}
      ]
    }}
    ```
    - **Your response must be strictly valid JSON**.
    - **Options should always be labeled a, b, c, and d.**
    - **No extra text, just valid JSON output.**
    """

    try:
        response = model.generate_content(prompt)
        
        # Print raw AI response to check if it follows correct JSON format
        print("AI Response:", response.text)

        if response and response.text:
            json_match = re.search(r'```json\s*({.*})\s*```', response.text, re.DOTALL)
            if json_match:
                json_data = json_match.group(1).strip()
                try:
                    data = json.loads(json_data)  # Try parsing as JSON
                    print("Parsed JSON:", data)  # Print parsed JSON
                    return data.get("questions", [])  # Return questions list
                except json.JSONDecodeError:
                    logging.error("Invalid JSON from AI")
                    return [{"question": "⚠ Invalid JSON response", "options": {}, "answer": ""}]
            else:
                logging.error("Failed to extract valid JSON from AI response.")
                return [{"question": "⚠ Could not extract valid JSON", "options": {}, "answer": ""}]
    except Exception as e:
        logging.error(f"AI API Error: {str(e)}")
        return [{"question": "⚠ AI API Error", "options": {}, "answer": ""}]

@app.route('/submit_answers', methods=['POST'])
def submit_answers():
    if 'user_id' not in session:
        return redirect('/login')

    user_id = session['user_id']
    subject = request.form['subject']
    difficulty = request.form['difficulty']
    total_questions = len(request.form) - 2
    correct_answers = 0

    # Retrieve questions stored in session
    questions = session.get('current_questions', [])

    print("🔹 Stored Questions in Session:", questions)  # Debugging

    for index, question in enumerate(questions):
        selected_answer = request.form.get(f"answer{index + 1}", "")  # Match HTML naming

        # Check if "answer" (or "correct") exists
        if "answer" in question:
            correct_answer = question["answer"]
        elif "correct" in question:
            correct_answer = question["correct"]
        else:
            print(f"⚠ Error: Missing correct answer key in question {index + 1}")
            correct_answer = ""  # Prevent crashes

        print(f"Q{index + 1}: User Answer = {selected_answer}, Correct Answer = {correct_answer}")  # Debugging

        # Compare answers
        if selected_answer.lower().strip() == correct_answer.lower().strip():
            correct_answers += 1

    percentage = (correct_answers / total_questions) * 100 if total_questions > 0 else 0

    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO results (user_id, subject, difficulty, correct_answers, total_questions, percentage) VALUES (%s, %s, %s, %s, %s, %s)",
                (user_id, subject, difficulty, correct_answers, total_questions, percentage))
    mysql.connection.commit()
    cur.close()

    return render_template('result.html', correct_answers=correct_answers, total_questions=total_questions, percentage=percentage)


def get_ai_questions(subject, difficulty):
    model = genai.GenerativeModel("learnlm-1.5-pro-experimental")

    prompt = f"""
    Generate exactly **5 {difficulty}-level multiple-choice questions** for **{subject}**.
    The response must be **valid JSON format** as shown below:

    ```json
    {{
      "questions": [
        {{
          "question": "What is Python?",
          "options": {{
            "a": "A programming language",
            "b": "A snake",
            "c": "A car",
            "d": "A fruit"
          }},
          "answer": "a"
        }},
        {{
          "question": "What is 2 + 2?",
          "options": {{
            "a": "3",
            "b": "4",
            "c": "5",
            "d": "6"
          }},
          "answer": "b"
        }}
      ]
    }}
    ```

    **Important Instructions:**
    - Your response must be strictly valid JSON — no extra text or explanations.
    - Options should always be labeled a, b, c, and d.
    """

    try:
        response = model.generate_content(prompt)
        if response and response.text:
            # Regex pattern to capture JSON part of the response
            json_match = re.search(r'```json\s*({.*})\s*```', response.text, re.DOTALL)

            if json_match:
                json_data = json_match.group(1).strip()  # Extract the JSON part

                # Try to load the JSON data
                try:
                    data = json.loads(json_data)  # Try parsing as JSON
                    questions = data.get("questions", [])

                    if not questions:
                        return [{"question": "⚠ No questions found in AI response.", "options": {}, "answer": ""}]
                    return questions
                except json.JSONDecodeError:
                    logging.error("AI response is not valid JSON.")
                    return [{"question": "⚠ Invalid JSON response. Please try again.", "options": {}, "answer": ""}]
            else:
                logging.error("Failed to extract valid JSON from AI response.")
                return [{"question": "⚠ Could not extract valid JSON. Please try again.", "options": {}, "answer": ""}]
    
    except Exception as e:
        logging.error(f"Error calling AI API: {str(e)}")
        return [{"question": "⚠ AI API Error. Please try again.", "options": {}, "answer": ""}]


# Function to validate if a string is valid JSON
def is_valid_json(data):
    try:
        json.loads(data)
    except ValueError as e:
        return False
    return True

# ✅ Study References - Select Subject
@app.route('/study_references', methods=['GET', 'POST'])
def study_references():
    subjects = ["Computer Science", "Mathematics", "Aptitude & Reasoning", "Verbal Ability"]
    if request.method == 'POST':
        subject = request.form['subject']
        topics = get_study_topics(subject)
        return render_template('topics.html', subject=subject, topics=topics)
    return render_template('select_study.html', subjects=subjects)



@app.route('/study_topic/<string:subject>/<string:topic>')
def study_topic(subject, topic):
    topic = topic.replace('_', ' ')  # URL ke underscores ko space me convert karein
    
    try:
        with mysql.connection.cursor() as cur:
            cur.execute("SELECT study_links FROM study_references WHERE subject=%s AND topic=%s", (subject, topic))
            stored_data = cur.fetchone()
    except Exception as e:
        logging.error(f"Error fetching data from database: {e}")
        stored_data = None

    if stored_data:
        references = json.loads(stored_data[0])
    else:
        references = get_study_references_from_ai(subject, topic)
        try:
            with mysql.connection.cursor() as cur:
                cur.execute("INSERT INTO study_references (subject, topic, study_links) VALUES (%s, %s, %s)",
                            (subject, topic, json.dumps(references)))
                mysql.connection.commit()
        except Exception as e:
            logging.error(f"Error inserting data into database: {e}")

    return render_template('study_materials.html', subject=subject, topic=topic, references=references)


def format_references(references):
    formatted = []
    for category, links in references.items():
        for link in links:
            # Extract title and URL
            match = re.match(r"(.+?)\s*-\s*(https?://\S+)", link)
            if match:
                title, url = match.groups()
                formatted.append(f'<a href="{url}" target="_blank">{title}</a>')
            else:
                formatted.append(link)  # If no proper format, just add as text
    return " | ".join(formatted)  # Join links with a separator


# ✅ Fetch Topics for Selected Subject
def get_study_topics(subject):
    study_topics = {
        "Computer Science": ["Data Structures", "Algorithms", "Operating Systems", "Networking"],
        "Mathematics": ["Linear Algebra", "Probability", "Calculus"],
        "Aptitude & Reasoning": ["Quantitative Aptitude", "Logical Reasoning"],
        "Verbal Ability": ["Grammar", "Reading Comprehension"]
    }
    return study_topics.get(subject, [])


def get_study_references_from_ai(subject, topic):
    model = genai.GenerativeModel("learnlm-1.5-pro-experimental")
    prompt = f"""
    Provide study references for {topic} in {subject}.
    The response should be valid JSON:
    ```json
    {{
      "books": ["Book Name - https://example.com"],
      "articles": ["Article Title - https://example.com"],
      "videos": ["Video Title - https://youtube.com"],
      "websites": ["Website Name - https://example.com"]
    }}
    ```
    """
    try:
        response = model.generate_content(prompt)
        if response and response.text:
            json_match = re.search(r'```json\s*({.*})\s*```', response.text, re.DOTALL)
            if json_match:
                return json.loads(json_match.group(1).strip())
    except Exception as e:
        logging.error(f"Error fetching study materials: {e}")
    
    return {"books": [], "articles": [], "videos": [], "websites": []}


@app.route('/submit', methods=['GET', 'POST'])
def submit():
    if request.method == 'POST':
        # Handle POST request
        return "POST request handled"
    return "GET request handled"

@app.route("/topics", methods=['GET'])
def select_topic():
    cur = mysql.connection.cursor()
    cur.execute('SHOW TABLES')
    tables = [row[0] for row in cur.fetchall() if row[0].endswith('_questions')]
    topics = [table[:-9] for table in tables]  # Remove '_questions' to get topic names
    cur.close()
    return render_template('topics1.html', topics1=topics)

import cv2
import threading
import time
from flask import Flask, render_template, Response, flash, redirect, url_for, request

# Global variables
cap = None
motion_detected = False

def generate_frames():
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        print("Error: Camera could not be opened.")
        return "Error: Camera could not be opened"
    
    while True:
        ret, frame = cap.read()
        
        if not ret:
            print("Error: Failed to capture frame.")
            break
        _, buffer = cv2.imencode('.jpg', frame)
        frame_bytes = buffer.tobytes()
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n\r\n')
    
    cap.release()  # Release the camera when done


# Route to start the video feed
@app.route('/video_feed')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

# Route for starting the camera and video feed
@app.route("/start_camera")
def start_camera():
    global cap
    cap = cv2.VideoCapture(0)
    
    if not cap.isOpened():
        return "Error: Camera could not be opened"
    
    return render_template('index.html')  # HTML page where video feed will be shown

# Route to stop the camera
@app.route("/stop_camera")
def stop_camera():
    global cap
    if cap and cap.isOpened():
        cap.release()
    return "Camera stopped"

# Function to start motion detection in a background thread
def capture_video_and_detect_motion(callback):
    global cap, motion_detected
    cap = cv2.VideoCapture(0)
    
    if not cap.isOpened():
        print("Error: Camera could not be opened.")
        return

    ret, frame1 = cap.read()
    ret, frame2 = cap.read()

    if not ret or frame1 is None or frame2 is None:
        print("Error: Failed to capture frames from the camera.")
        cap.release()
        return

    while cap.isOpened():
        diff = cv2.absdiff(frame1, frame2)
        gray = cv2.cvtColor(diff, cv2.COLOR_BGR2GRAY)
        blur = cv2.GaussianBlur(gray, (5, 5), 0)
        _, thresh = cv2.threshold(blur, 25, 255, cv2.THRESH_BINARY)
        contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        motion_detected = False
        for contour in contours:
            if cv2.contourArea(contour) > 5000:
                motion_detected = True
                break

        if motion_detected:
            callback(True)
            break

        frame1 = frame2
        ret, frame2 = cap.read()

        if not ret or frame2 is None:
            print("Error: Failed to capture new frame.")
            break

    cap.release()

# Route to start the interview with motion detection
@app.route("/start_interview/<string:selected_topic>", methods=['GET'])
def start_interview(selected_topic):
    global motion_detected

    # Replace underscores in the topic for better display
    display_topic = selected_topic.strip('_').replace('_', ' ')

    def motion_callback(detected):
        global motion_detected
        motion_detected = detected

    # Start the motion detection thread
    motion_thread = threading.Thread(target=capture_video_and_detect_motion, args=(motion_callback,))
    motion_thread.daemon = True
    motion_thread.start()

    # Wait for motion detection to run for a moment
    time.sleep(2)

    if motion_detected:
        flash("Motion detected! Interview can begin.")
    else:
        flash("No motion detected. Please make sure you're in front of the camera.")

    return render_template('start_interview.html', topic=display_topic)

# Route to stop the interview and shut down the camera
@app.route("/end_interview")
def end_interview():
    global cap
    if cap is not None and cap.isOpened():
        cap.release()  # Properly release the camera
        flash("Interview ended. Camera is now off.")
    return redirect(url_for('start_interview', selected_topic='Interview_Ended'))

# Route to handle the interview questions
@app.route("/interview", methods=['POST'])
def interview():
    selected_topic = request.form.get('topic')
    table_name = f"{selected_topic}_questions"

    # Connect to MySQL and get the questions for the selected topic
    cur = mysql.connection.cursor()
    try:
        cur.execute(f"SHOW TABLES LIKE '{table_name}'")
        if not cur.fetchone():
            flash("Selected topic does not exist.")
            return redirect(url_for('select_topic'))

        query = f'SELECT question_text, correct_answer FROM {table_name}'
        cur.execute(query)
        data = cur.fetchall()

        total_questions = len(data)
        correct_count = 0

        engine = pyttsx3.init()

        for question_text, correct_answer in data:
            engine.say(question_text)
            engine.runAndWait()

            answer = recognize_speech_from_mic()

            if answer.lower() in ["quit", "stop"]:
                engine.say("Interview stopped.")
                engine.runAndWait()
                flash("Interview stopped by user.")
                return redirect(url_for('select_topic'))

            if is_correct(answer, correct_answer):
                correct_count += 1

        percentage_correct = (correct_count / total_questions) * 100 if total_questions > 0 else 0
        return redirect(url_for('show_results', percentage=percentage_correct, correct_count=correct_count, total_questions=total_questions))
    
    except Exception as e:
        flash(f"An error occurred during the interview: {e}")
        return redirect(url_for('select_topic'))
    
    finally:
        cur.close()

@app.route('/result')
def show_results():
    return render_template('result.html', percentage=request.args.get('percentage', type=float), correct_count=request.args.get('correct_count', type=int), total_questions=request.args.get('total_questions', type=int))

def recognize_speech_from_mic():
    recognizer = sr.Recognizer()
    mic = sr.Microphone()
     # Adjust silence detection parameters
    try:
        with mic as source:
            recognizer.adjust_for_ambient_noise(source)
            print("Listening for your answer...")
            audio = recognizer.listen(source, timeout=5)
            response = recognizer.recognize_google(audio)
            print(f"Recognized: {response}")
            return response
    except sr.WaitTimeoutError:
        logging.error("Listening timed out while waiting for phrase to start")
        return "Listening timed out"
    except sr.RequestError as e:
        logging.error(f"API request error: {e}")
        return "API unavailable"
    except sr.UnknownValueError:
        logging.error("Google Speech Recognition could not understand audio")
        return "Sorry, I could not understand the audio"
    except Exception as e:
        logging.error(f"Unexpected error: {e}")
        return "An unexpected error occurred"

def extract_keywords(text):
    return set(re.findall(r'\b\w+\b', text.lower()))

def contains_keyword(user_answer, keywords):
    user_words = set(re.findall(r'\b\w+\b', user_answer.lower()))
    return not user_words.isdisjoint(keywords)

def is_correct(answer, correct_answer):
    keywords = extract_keywords(correct_answer)
    return contains_keyword(answer, keywords)

@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect('/login')

if __name__ == '__main__':


    app.run(debug=True)
