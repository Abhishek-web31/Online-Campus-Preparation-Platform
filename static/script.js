function fetchQuestions() {
    fetch('/api/practice_questions')
        .then(response => response.json())
        .then(data => {
            let questionsDiv = document.getElementById('questions');
            questionsDiv.innerHTML = "";
            data.forEach(q => {
                let p = document.createElement('p');
                p.innerText = q;
                questionsDiv.appendChild(p);
            });
        });
}
