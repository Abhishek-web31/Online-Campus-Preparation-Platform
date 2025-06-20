-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2025 at 02:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: campus_prep
--

-- --------------------------------------------------------

--
-- Table structure for table ai_questions
--

CREATE TABLE ai_questions (
  id INTEGER NOT NULL,
  subject varchar(255) DEFAULT NULL,
  difficulty varchar(50) DEFAULT NULL,
  questions text DEFAULT NULL
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table ai_questions
--

INSERT INTO ai_questions (id, subject, difficulty, questions) VALUES
(1, 'Verbal Ability', 'Easy', '[{\"question\": \"Choose the word that is most similar in meaning to \\\"Happy\\\":\", \"options\": {\"a\": \"Sad\", \"b\": \"Joyful\", \"c\": \"Angry\", \"d\": \"Tired\"}, \"answer\": \"b\"}, {\"question\": \"Which word is the opposite of \\\"Big\\\"?\", \"options\": {\"a\": \"Large\", \"b\": \"Huge\", \"c\": \"Small\", \"d\": \"Giant\"}, \"answer\": \"c\"}, {\"question\": \"Complete the sentence: The cat sat ___ the mat.\", \"options\": {\"a\": \"Under\", \"b\": \"Above\", \"c\": \"On\", \"d\": \"Beside\"}, \"answer\": \"c\"}, {\"question\": \"Which word is spelled correctly?\", \"options\": {\"a\": \"Recieve\", \"b\": \"Receive\", \"c\": \"Reiceve\", \"d\": \"Receeve\"}, \"answer\": \"b\"}, {\"question\": \"What is the plural of \\\"Child\\\"?\", \"options\": {\"a\": \"Childs\", \"b\": \"Childes\", \"c\": \"Children\", \"d\": \"Childrin\"}, \"answer\": \"c\"}]');

-- --------------------------------------------------------

--
-- Table structure for table c_questions
--

CREATE TABLE c_questions (
  id INTEGER NOT NULL,
  question_text text NOT NULL,
  correct_answer text NOT NULL
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table c_questions
--

INSERT INTO c_questions (id, question_text, correct_answer) VALUES
(1, 'What is the difference between C++ and C?', 'C++ supports object-oriented programming while C does not.'),
(2, 'What is a pointer in C++?', 'A pointer in C++ is a variable that stores the memory address of another variable.'),
(3, 'Explain what is a constructor in C++?', 'A constructor is a special member function of a class that initializes objects of the class.'),
(4, 'What is the purpose of the virtual keyword in C++?', 'The virtual keyword is used to declare a function as virtual, allowing for dynamic dispatch of method calls in inheritance.'),
(5, 'What are the types of inheritance in C++?', 'The main types of inheritance are single, multiple, multilevel, hierarchical, hybrid, and hierarchical inheritance.'),
(6, 'What is a destructor in C++?', 'A destructor is a special member function that is called when an object goes out of scope or is explicitly deleted to clean up resources.'),
(7, 'Explain the difference between new and malloc in C++?', 'new is an operator that allocates memory for an object and also calls its constructor, whereas malloc is a standard C library function that only allocates memory without initialization.'),
(8, 'What is a class in C++?', 'A class is a blueprint for creating objects that defines data and methods associated with those objects.'),
(9, 'What is the purpose of the friend function in C++?', 'A friend function allows a function or class to access private and protected members of another class.'),
(10, 'What are the different access specifiers in C++?', 'The three primary access specifiers in C++ are public, protected, and private.');

-- --------------------------------------------------------

--
-- Table structure for table general_questions
--

CREATE TABLE general_questions (
  id INTEGER NOT NULL,
  question_text text NOT NULL,
  correct_answer text NOT NULL
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table general_questions
--

INSERT INTO general_questions (id, question_text, correct_answer) VALUES
(1, 'tell me about your self', 'my name is'),
(2, 'what is your age', 'my age is'),
(5, 'why do want to work here', 'employe development'),
(6, 'What are your strengths and weaknesses?', 'strengths weaknesses'),
(9, 'Where do you see yourself in five years?', 'reputed company');

-- --------------------------------------------------------

--
-- Table structure for table oops_questions
--

CREATE TABLE oops_questions (
  id INTEGER NOT NULL,
  question_text text NOT NULL,
  correct_answer text NOT NULL
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table oops_questions
--

INSERT INTO oops_questions (id, question_text, correct_answer) VALUES
(1, 'What is Object-Oriented Programming (OOP)?', 'OOP is a programming paradigm'),
(2, 'What are the key features of OOP?', 'The four key features are Encapsulation, Abstraction, Inheritance, and Polymorphism.'),
(3, 'What is a class and an object in OOP?', 'A class is a blueprint, while an object is an instance of a class.'),
(4, 'What is inheritance?', 'Inheritance is a feature of OOP where a new class inherits properties and behaviors from an existing class.'),
(5, 'What is encapsulation in OOP?', ' hiding the internal representation from the outside world.');

-- --------------------------------------------------------

--
-- Table structure for table python_questions
--

CREATE TABLE python_questions (
  id INTEGER NOT NULL,
  question_text text NOT NULL,
  correct_answer text NOT NULL
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table python_questions
--

INSERT INTO python_questions (id, question_text, correct_answer) VALUES
(1, 'What is Python?', 'Python is an interpreted, high-level, general-purpose programming language.'),
(2, 'What are Python key features?', 'Easy to learn, Interpreted, Cross-platform, Dynamically typed, Object-oriented, Extensive libraries'),
(3, 'What is the difference between a list and a tuple?', 'A list is mutable while a tuple is immutable.');

-- --------------------------------------------------------

--
-- Table structure for table questions
--

CREATE TABLE questions (
  id INTEGER NOT NULL,
  topic varchar(255) NOT NULL,
  question_text text NOT NULL,
  correct_answer text NOT NULL
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table questions
--

INSERT INTO questions (id, topic, question_text, correct_answer) VALUES
(1, 'Python', 'What is a Python decorator?', 'A decorator is a function that takes another function and extends its behavior without explicitly modifying it.'),
(2, 'Python', 'What is a lambda function in Python?', 'A lambda function is an anonymous function expressed as a single statement.'),
(3, 'JavaScript', 'What is a closure?', 'A closure is a function that retains access to its lexical scope even when the function is executed outside that scope.');

-- --------------------------------------------------------

--
-- Table structure for table results
--

CREATE TABLE results (
  id INTEGER NOT NULL,
  user_id INTEGER DEFAULT NULL,
  subject varchar(50) DEFAULT NULL,
  difficulty varchar(10) DEFAULT NULL,
  correct_answers INTEGER DEFAULT NULL,
  total_questions INTEGER DEFAULT NULL,
  percentage float DEFAULT NULL,
  created_at timestamp NOT NULL DEFAULT current_timestamp()
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table results
--

INSERT INTO results (id, user_id, subject, difficulty, correct_answers, total_questions, percentage, created_at) VALUES
(1, 4, 'Aptitude', 'Easy', 0, 1, 0, '2025-02-27 05:41:40'),
(2, 4, 'Verbal Ability', 'Easy', 0, 5, 0, '2025-02-27 10:57:56'),
(3, 5, 'Computer Science', 'Easy', 0, 5, 0, '2025-02-28 07:29:05'),
(4, 5, 'Computer Science', 'Easy', 0, 5, 0, '2025-02-28 07:29:37'),
(5, 5, 'Aptitude & Reasoning', 'Easy', 0, 5, 0, '2025-02-28 07:38:59'),
(6, 5, 'Mathematics', 'Easy', 5, 5, 100, '2025-02-28 07:48:12'),
(7, 5, 'Aptitude & Reasoning', 'Medium', 1, 5, 20, '2025-02-28 08:47:14'),
(8, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 12:40:14'),
(9, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 12:41:56'),
(10, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 12:43:38'),
(11, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 12:45:19'),
(12, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 12:45:23'),
(13, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 12:46:59'),
(14, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 13:10:26'),
(15, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 13:10:46'),
(16, 5, 'Computer Science', 'Easy', 2, 5, 40, '2025-03-19 13:11:36'),
(17, 5, 'Mathematics', 'Hard', 1, 5, 20, '2025-04-01 09:54:52');

-- --------------------------------------------------------

--
-- Table structure for table study_references
--

CREATE TABLE study_references (
  id INTEGER NOT NULL,
  subject varchar(255) NOT NULL,
  topic varchar(255) NOT NULL,
  study_links text NOT NULL,
  created_at timestamp NOT NULL DEFAULT current_timestamp()
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table study_references
--

INSERT INTO study_references (id, subject, topic, study_links, created_at) VALUES
(1, 'Aptitude & Reasoning', 'Quantitative Aptitude', '{\"books\": [\"Quantitative Aptitude for Competitive Examinations by R.S. Aggarwal - https://www.amazon.in/Quantitative-Aptitude-Competitive-Examinations-Aggarwal/dp/9352860061\", \"How to Prepare for Quantitative Aptitude for the CAT by Arun Sharma - https://www.amazon.in/How-Prepare-Quantitative-Aptitude-CAT/dp/9351766317\", \"Fast Track Objective Arithmetic by Rajesh Verma - https://www.amazon.in/Fast-Track-Objective-Arithmetic-Rajesh/dp/9386298460\"], \"articles\": [\"Quantitative Aptitude Shortcuts and Tricks for Competitive Exams - https://www.hitbullseye.com/Quant-Shortcuts-Tricks.php\", \"Data Interpretation Tricks & Tips - https://www.ibpsguide.com/data-interpretation-tricks-tips/\", \"Aptitude Preparation: Tips and Tricks to Crack Aptitude Questions - https://www.indiabix.com/aptitude/preparation/\"], \"videos\": [\"Quantitative Aptitude - Complete Course - https://www.youtube.com/watch?v=t7qBvRWVyyU\", \"Number System - Introduction | Quantitative Aptitude | CAT, SSC, Bank, RBI, SBI, LIC, Railways - https://www.youtube.com/watch?v=XGbOiYhHY2c\", \"Percentages Made Easy - Basic Concepts and Tricks - https://www.youtube.com/watch?v=JeVSmq1Nrpw\"], \"websites\": [\"IndiaBIX - Aptitude Questions and Answers - https://www.indiabix.com/\", \"Hitbullseye - Aptitude Preparation for Competitive Exams - https://www.hitbullseye.com/\", \"Testbook - Online Test Series for Government Exams - https://testbook.com/\", \"Khan Academy - Math - https://www.khanacademy.org/math\"]}', '2025-02-27 11:51:59'),
(2, 'Computer Science', 'Data Structures', '{\"books\": [\"Introduction to Algorithms by Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, and Clifford Stein - https://mitpress.mit.edu/books/introduction-algorithms-third-edition\", \"Data Structures and Algorithm Analysis in C++ by Mark Allen Weiss - https://www.pearson.com/us/higher-education/program/Weiss-Data-Structures-and-Algorithm-Analysis-in-C-4th-Edition/PGM334926.html\", \"Data Structures and Algorithms in Java by Robert Lafore - https://www.amazon.com/Data-Structures-Algorithms-Java-2nd/dp/0672324539\", \"Grokking Algorithms: An illustrated guide for programmers and other curious people by Aditya Bhargava - https://www.manning.com/books/grokking-algorithms\"], \"articles\": [\"Data Structures - GeeksforGeeks - https://www.geeksforgeeks.org/data-structures/\", \"Basic Data Structures - Tutorialspoint - https://www.tutorialspoint.com/data_structures_algorithms/data_structures_basics.htm\", \"What is a Data Structure? - Scaler Topics - https://www.scaler.com/topics/data-structures/what-is-a-data-structure/\"], \"videos\": [\"Data Structures Easy to Advanced Course - freeCodeCamp.org - https://www.youtube.com/watch?v=RBSGKlAvoiM\", \"Data Structures and Algorithm Tutorials - mycodeschool - https://www.youtube.com/playlist?list=PL2_aWCzGMAwI3W_JlcBbtYTwiQSsOTa6P\", \"Abdul Bari: Data Structures and Algorithms in C++ - https://www.youtube.com/watch?v=0IAPZzGSbME&list=PLDN4rrl48XKpZkf03iYFl-O29szjTrs_O\"], \"websites\": [\"GeeksforGeeks - https://www.geeksforgeeks.org/\", \"VisuAlgo - https://visualgo.net/en\", \"HackerRank - https://www.hackerrank.com/\", \"LeetCode - https://leetcode.com/\"]}', '2025-02-27 19:00:04'),
(3, 'Computer Science', 'Data Structures', '{\"books\": [\"Data Structures Book - https://example.com\"]}', '2025-02-27 19:06:45'),
(4, 'Mathematics', 'Probability', '{\"books\": [\"Introduction to Probability - https://www.amazon.com/Introduction-Probability-2nd-Dimitri-Bertsekas/dp/188652923X\", \"A First Course in Probability - https://www.amazon.com/First-Course-Probability-Sheldon-Ross/dp/032179477X\", \"Probability and Statistics for Engineers and Scientists - https://www.amazon.com/Probability-Statistics-Engineers-Scientists-9th/dp/0321629116\", \"All of Statistics: A Concise Course in Statistical Inference - https://www.amazon.com/All-Statistics-Concise-Statistical-Inference/dp/0387402721\", \"Probability: Theory and Examples - https://services.math.duke.edu/~rtd/PTE/PTE5_011119.pdf\"], \"articles\": [\"What is Probability? - https://www.britannica.com/science/probability\", \"Probability Theory - https://en.wikipedia.org/wiki/Probability_theory\", \"An Introduction to Probability Theory - https://www.dartmouth.edu/~chance/teaching_aids/books_articles/probability_book/Chapter1.pdf\", \"The Monty Hall Problem - https://www.montyhallproblem.com/\"], \"videos\": [\"Probability: Basic Concepts & Discrete Random Variables - https://www.youtube.com/watch?v=uzkc-qNVoOk\", \"Introduction to Probability and Statistics - https://www.youtube.com/watch?v=j9WZyLZCBzs&list=PL1328115D3D8A2566\", \"Khan Academy Probability - https://www.khanacademy.org/math/statistics-probability\"], \"websites\": [\"Khan Academy - https://www.khanacademy.org/math/statistics-probability\", \"MIT OpenCourseWare Probability and Statistics - https://ocw.mit.edu/courses/18-05-introduction-to-probability-and-statistics-spring-2014/\", \"Stat Trek: Teach yourself statistics - https://stattrek.com/\"]}', '2025-02-28 02:04:25'),
(5, 'Mathematics', 'Calculus', '{\"books\": [\"Calculus: Early Transcendentals - https://www.amazon.com/Calculus-Early-Transcendentals-James-Stewart/dp/1285741552\", \"Calculus: Single and Multivariable - https://www.amazon.com/Calculus-Single-Multivariable-Hughes-Hallett/dp/0470888619\", \"Calculus - https://ocw.mit.edu/resources/res-18-001-calculus-online-textbook-spring-2005/textbook/\", \"Thomas\' Calculus: Early Transcendentals - https://www.pearson.com/us/higher-education/program/Thomas-Thomas-Calculus-Early-Transcendentals-14th-Edition/PGM186214.html\"], \"articles\": [\"Visual Calculus - https://archives.math.utk.edu/visual.calculus/\", \"Understanding Calculus - https://betterexplained.com/calculus/\", \"Introduction to Calculus -  https://www.khanacademy.org/math/calculus-1\"], \"videos\": [\"Essence of Calculus - https://www.youtube.com/playlist?list=PLZHQObOWTQDMsr9K-rj53DwVRMYO3tvaa\", \"Calculus 1 - Full College Course - https://www.youtube.com/watch?v=HfACrKJ_Y2w\", \"MIT Calculus - https://www.youtube.com/playlist?list=PLUl4u3cNGP61OqZx6xFyE5k-t-rT9D3eB\"], \"websites\": [\"Khan Academy Calculus - https://www.khanacademy.org/math/calculus-1\", \"Paul\'s Online Math Notes - https://tutorial.math.lamar.edu/\", \"MIT OpenCourseWare Calculus - https://ocw.mit.edu/courses/mathematics/18-01sc-single-variable-calculus-fall-2010/\", \"BetterExplained Calculus - https://betterexplained.com/calculus/\"]}', '2025-02-28 02:08:05'),
(6, 'Mathematics', 'Linear Algebra', '{\"books\": [\"Linear Algebra and Its Applications by David C. Lay - https://www.pearson.com/us/higher-education/product/Lay-Linear-Algebra-and-Its-Applications-5th-Edition/9780321982384.html\", \"Introduction to Linear Algebra by Gilbert Strang - https://math.mit.edu/~gs/linearalgebra/\", \"Linear Algebra Done Right by Sheldon Axler - https://link.springer.com/book/10.1007/978-3-319-11080-6\", \"3,000 Solved Problems in Linear Algebra by Seymour Lipschutz - https://www.mheducation.com/highered/product/3000-solved-problems-linear-algebra-lipschutz/9780071635035.html\"], \"articles\": [\"Linear Algebra by Jim Hefferon - http://joshua.smcvt.edu/linearalgebra/\", \"The Essence of Linear Algebra by 3Blue1Brown (Series of Articles accompanying the videos) - https://www.3blue1brown.com/topics/linear-algebra\"], \"videos\": [\"Essence of Linear Algebra by 3Blue1Brown - https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzMebbnJcehpFWYVH\", \"Linear Algebra by Khan Academy - https://www.khanacademy.org/math/linear-algebra\", \"MIT 18.06SC Linear Algebra by Gilbert Strang - https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/\"], \"websites\": [\"Khan Academy - https://www.khanacademy.org/math/linear-algebra\", \"MIT OpenCourseWare - https://ocw.mit.edu/courses/mathematics/\", \"Paul\'s Online Math Notes - https://tutorial.math.lamar.edu/classes/linAlg/linAlg.aspx\", \"3Blue1Brown - https://www.3blue1brown.com/topics/linear-algebra\"]}', '2025-02-28 03:13:25'),
(7, 'Mathematics', 'Linear Algebra', '{\"books\": [\"Linear Algebra and Its Applications by David C. Lay - https://www.pearson.com/us/higher-education/program/Lay-Linear-Algebra-and-Its-Applications-5th-Edition/PGM334331.html\", \"Introduction to Linear Algebra by Gilbert Strang - https://math.mit.edu/~gs/linearalgebra/\", \"Linear Algebra Done Right by Sheldon Axler - https://link.springer.com/book/10.1007/978-3-319-11080-6\", \"3,000 Solved Problems in Linear Algebra by Seymour Lipschutz - https://www.mheducation.com/highered/product/3000-solved-problems-linear-algebra-lipschutz/9780071635056.html\", \"Linear Algebra with Applications by Steven J. Leon - https://www.pearson.com/us/higher-education/program/Leon-Linear-Algebra-with-Applications-10th-Edition/PGM100001614789.html\"], \"articles\": [\"Linear Algebra by Jim Hefferon - http://joshua.smcvt.edu/linearalgebra/\", \"The Fundamental Theorem of Linear Algebra by Gilbert Strang - https://www.jstor.org/stable/2324660\", \"Down with Determinants! by Sheldon Axler - https://www.maa.org/sites/default/files/pdf/awards/Axler-Ford-1996.pdf\"], \"videos\": [\"Essence of Linear Algebra by 3Blue1Brown - https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab\", \"MIT 18.06 Linear Algebra by Gilbert Strang - https://www.youtube.com/playlist?list=PLE7DDD91010BC51F8\", \"Khan Academy Linear Algebra - https://www.khanacademy.org/math/linear-algebra\"], \"websites\": [\"MIT OpenCourseWare Linear Algebra - https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/\", \"Khan Academy Linear Algebra - https://www.khanacademy.org/math/linear-algebra\", \"Paul\'s Online Math Notes - Linear Algebra - https://tutorial.math.lamar.edu/classes/linalg/linalg.aspx\"]}', '2025-02-28 03:13:27'),
(8, 'Computer Science', 'Networking', '{\"books\": [\"Computer Networking: A Top-Down Approach - https://www.amazon.com/Computer-Networking-Top-Down-Approach-7th/dp/0133594149\", \"TCP/IP Illustrated, Volume 1: The Protocols - https://www.amazon.com/TCP-Illustrated-Vol-Addison-Wesley-Professional/dp/0201633469\", \"Network Warrior - https://www.amazon.com/Network-Warrior-2nd-Gary-Donahue/dp/0596521856\"], \"articles\": [\"Ethernet: A Local Area Network - https://ieeexplore.ieee.org/document/6329132\", \"A Survey on Network Function Virtualization (NFV): Architecture, Enabling Technologies and Open Challenges - https://ieeexplore.ieee.org/document/7966106\", \"The TCP/IP Guide - https://www.tcpipguide.com/free/t_toc.htm\"], \"videos\": [\"Computer Networking Course - https://www.youtube.com/playlist?list=PL3143D67F0DEC509C\", \"Networking Fundamentals - https://www.youtube.com/watch?v=IPvYjXCsTg8\", \"What is the Internet? - https://www.youtube.com/watch?v=Dxcc6ycZ7uM&list=PLSQl0a2vh4HC5feHa6Rc5c0wbRTx56nF7&index=1\"], \"websites\": [\"GeeksforGeeks - Computer Network Tutorials - https://www.geeksforgeeks.org/computer-network-tutorials/\", \"Khan Academy - Computer Networking - https://www.khanacademy.org/computing/computer-science/internet-intro\", \"IETF - Internet Engineering Task Force - https://www.ietf.org/\"]}', '2025-02-28 04:41:53'),
(9, 'Computer Science', 'Networking', '{\"books\": [\"Computer Networking: A Top-Down Approach - https://www.amazon.com/Computer-Networking-Top-Down-Approach-7th/dp/0133594149\", \"Data Communications and Networking - https://www.amazon.com/Data-Communications-Networking-Behrouz-Forouzan/dp/0073376220\", \"TCP/IP Illustrated, Volume 1: The Protocols - https://www.amazon.com/TCP-Illustrated-Vol-Addison-Wesley-Professional/dp/0201633469\"], \"articles\": [\"Ethernet: A Local Area Network - https://ieeexplore.ieee.org/document/6302794\", \"A Survey of Wireless Security - https://www.mdpi.com/1424-8220/7/7/1878/htm\", \"The Internet Protocol (IP) - https://www.rfc-editor.org/rfc/rfc791\"], \"videos\": [\"Computer Networking Course - https://www.youtube.com/playlist?list=PLUl4u3cNGP61ysd2jKUEK0aUEdjXF0rQ8\", \"Networking Fundamentals - https://www.youtube.com/watch?v=fv4RZtlKLEY\", \"What is the Internet? - https://www.youtube.com/watch?v=Dxcc6ycZ73M&ab_channel=Code.org\"], \"websites\": [\"GeeksforGeeks - Computer Networking - https://www.geeksforgeeks.org/computer-network/\", \"Tutorialspoint - Computer Networking - https://www.tutorialspoint.com/computer_fundamentals/computer_networking.htm\", \"Khan Academy - Computer Networking - https://www.khanacademy.org/computing/computers-and-internet/xcae6f4a7ff04aa8a:the-internet/xcae6f4a7ff04aa8a:introduction-to-the-internet-and-the-world-wide-web/a/the-internet\"]}', '2025-02-28 04:41:55'),
(10, 'Computer Science', 'Operating Systems', '{\"books\": [\"Operating System Concepts (Silberschatz, Galvin, Gagne) - https://www.amazon.com/Operating-System-Concepts-10th-Abraham-Silberschatz/dp/1119576426\", \"Modern Operating Systems (Andrew S. Tanenbaum) - https://www.amazon.com/Modern-Operating-Systems-Andrew-Tanenbaum/dp/013359162X\", \"Understanding the Linux Kernel (Daniel P. Bovet, Marco Cesati) - https://www.oreilly.com/library/view/understanding-the-linux/0596005652/\", \"Three Easy Pieces - https://github.com/remzi-arpacidusseau/ostep-projects\", \"Operating Systems: Design and Implementation (Andrew S. Tanenbaum, Albert S. Woodhull)- https://www.pearson.com/us/higher-education/program/Tanenbaum-Operating-Systems-Design-and-Implementation-3rd-Edition/PGM53437.html\"], \"articles\": [\"The UNIX Time-Sharing System - https://dl.acm.org/doi/10.1145/361011.361061\", \"An Introduction to Multiprocessing - https://www.cs.cornell.edu/courses/cs4414/2016fa/lectures/18-multiprocessing.pdf\", \"Threads and Concurrency - https://www.cs.cornell.edu/courses/cs4410/2014fa/lectures/lec24-concurrency.pdf\"], \"videos\": [\"Operating Systems Course - CS162 (UC Berkeley) - https://www.youtube.com/playlist?list=PL-XXv-KvnDIL39z-oBtqYd7osnzs0P4j9\", \"Introduction to Operating Systems - https://www.youtube.com/watch?v=QZwneRb-zqA\", \"What is an Operating System? - Computerphile - https://www.youtube.com/watch?v=26QPDBe-NB8\"], \"websites\": [\"OSDev Wiki - https://wiki.osdev.org/\", \"Linux Kernel Documentation - https://www.kernel.org/doc/html/latest/\", \"The Linux Foundation - https://www.linuxfoundation.org/\"]}', '2025-03-20 05:23:04'),
(11, 'Computer Science', 'Algorithms', '{\"books\": [\"Introduction to Algorithms (CLRS) by Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, and Clifford Stein - https://mitpress.mit.edu/books/introduction-algorithms\", \"Algorithms by Robert Sedgewick and Kevin Wayne - https://algs4.cs.princeton.edu/books/\", \"The Algorithm Design Manual by Steven S Skiena - https://www.algorist.com/\", \"Grokking Algorithms by Aditya Bhargava - https://www.manning.com/books/grokking-algorithms\"], \"articles\": [\"Dynamic Programming \\u2013 From Novice to Advanced by TopCoder - https://www.topcoder.com/thrive/articles/Dynamic%20Programming%20-%20From%20Novice%20to%20Advanced\", \"A* Search Algorithm - GeeksforGeeks - https://www.geeksforgeeks.org/a-search-algorithm/\", \"Dijkstra\'s Algorithm - Brilliant.org - https://brilliant.org/wiki/dijkstras-short-path-finder/\"], \"videos\": [\"CS50: Introduction to Computer Science - Harvard University - https://www.youtube.com/playlist?list=PLhQjrBD2T380Xnsk1T0AQRS0rdxQl_2w-\", \"Algorithms - MIT OpenCourseWare - https://www.youtube.com/playlist?list=PLUl4u3cNGP61Oq3tWYp6V_xp-hI4ux_wk\", \"Abdul Bari: Algorithms - https://www.youtube.com/c/abdulbari\"], \"websites\": [\"GeeksforGeeks - https://www.geeksforgeeks.org/\", \"LeetCode - https://leetcode.com/\", \"HackerRank - https://www.hackerrank.com/\", \"VisuAlgo - https://visualgo.net/en\"]}', '2025-03-20 05:29:51');

-- --------------------------------------------------------

--
-- Table structure for table topic_week_allocation
--

CREATE TABLE topic_week_allocation (
  id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  topic varchar(255) NOT NULL,
  weeks INTEGER NOT NULL,
  start_week INTEGER NOT NULL
)   COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table users
--

CREATE TABLE users (
  id INTEGER NOT NULL,
  name varchar(100) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  branch varchar(50) DEFAULT NULL,
  skills text DEFAULT NULL,
  semester varchar(10) DEFAULT NULL,
  course varchar(50) DEFAULT NULL,
  known_topics text DEFAULT NULL,
  face_encoding text DEFAULT NULL,
  profile_photo varchar(255) DEFAULT NULL
)   COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table users
--

INSERT INTO users (id, name, email, password, branch, skills, semester, course, known_topics, face_encoding, profile_photo) VALUES
(1, 'Abhishek Rajput ', 'abhishekrajput3105@gmail.com', '123456', 'CSE', 'python', NULL, NULL, NULL, NULL, NULL),
(3, 'Abhi', 'abhishekrajput@gmail.com', '123456', 'mca', 'python', '4', 'mca', 'easy coding,general aptitude', NULL, NULL),
(4, 'Abhi', 'abhi@gmail.com', 'scrypt:32768:8:1$IF2iXYfA0Z9vIGPj$f117c76b27c8c3390593da58fd5c2172459694b3fcfeb85ed991dabda7120dee88ee29f099fe6bd6432243007c7af73fb662a60fe2bdbea843968edab60c148a', 'mca', 'python', '4', 'mca', 'easy coding,general aptitude', NULL, NULL),
(5, 'Abhi', 'abhishek@gmail.com', 'scrypt:32768:8:1$4BSZGhmO2fLQSjf3$786bec0a67f45968ff4bbfa66fb8a79e248d6eed0aa3d1b23d0d3340cd89b2dd2a6531f330295ce188a7f0146a102e7907d39b67b65c735f1b8333e9c69c171b', 'mca', 'python', '4', 'mca', 'easy coding,general aptitude', NULL, NULL),
(6, 'shweta', 'shweta@gmail.com', 'scrypt:32768:8:1$dzDmECCQzZ2LIIdX$adc4067b1727eee1eef6d1f7e315291bf7dbc04b8ac0c2d1f5cf64af740ab69aff4a1f0ca13d534a7b301e9bf6a4b1796f3854e24c6425697b3896030f0af689', 'mca', 'c++', '4', 'mca', 'c++', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table ai_questions
--
ALTER TABLE ai_questions
  ADD PRIMARY KEY (id);

--
-- Indexes for table results
--
ALTER TABLE results
  ADD PRIMARY KEY (id),
  ADD KEY user_id (user_id);

--
-- Indexes for table study_references
--
ALTER TABLE study_references
  ADD PRIMARY KEY (id);

--
-- Indexes for table topic_week_allocation
--
ALTER TABLE topic_week_allocation
  ADD PRIMARY KEY (id),
  ADD KEY user_id (user_id);

--
-- Indexes for table users
--
ALTER TABLE users
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY email (email);

--
-- SERIAL for dumped tables
--

--
-- SERIAL for table ai_questions
--
ALTER TABLE ai_questions
  MODIFY id INTEGER NOT NULL SERIAL, SERIAL=2;

--
-- SERIAL for table results
--
ALTER TABLE results
  MODIFY id INTEGER NOT NULL SERIAL, SERIAL=18;

--
-- SERIAL for table study_references
--
ALTER TABLE study_references
  MODIFY id INTEGER NOT NULL SERIAL, SERIAL=12;

--
-- SERIAL for table topic_week_allocation
--
ALTER TABLE topic_week_allocation
  MODIFY id INTEGER NOT NULL SERIAL;

--
-- SERIAL for table users
--
ALTER TABLE users
  MODIFY id INTEGER NOT NULL SERIAL, SERIAL=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table results
--
ALTER TABLE results
  ADD CONSTRAINT results_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id);

--
-- Constraints for table topic_week_allocation
--
ALTER TABLE topic_week_allocation
  ADD CONSTRAINT topic_week_allocation_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
