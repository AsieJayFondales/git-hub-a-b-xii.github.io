import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Quiz',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<String> questions = [
    'Cats are obligate carnivores, meaning they must eat meat to survive.',
    'Dogs belong to the feline family.',
    'Coffee is made from coffee beans.',
    'The Maine Coon is a breed of dog.',
    'The Dachshund is also known as a wiener dog.',
    'Caffeine is a natural stimulant found in coffee.',
    'Cats have retractable claws.',
    'Labrador Retrievers are known for their love of swimming.',
    'Espresso is a type of coffee.',
    'The Pomeranian is a large breed of cat.'
  ];

  List<bool> answers = [
    true,
    false,
    true,
    false,
    true,
    true,
    true,
    true,
    true,
    false
  ];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = answers[currentQuestionIndex];
    String feedback =
        userAnswer == correctAnswer ? 'Your answer is Correct!' : 'Awe, Wrong!';
    if (userAnswer == correctAnswer) {
      score++;
    }
    showFeedbackDialog(feedback);
  }

  void showFeedbackDialog(String feedback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(feedback),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                nextQuestion();
              },
              child: Text('Next Question'),
            ),
          ],
        );
      },
    );
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Quiz completed
      String resultMessage = getResultMessage();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content: Text(resultMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetQuiz();
                },
                child: Text('Start Over'),
              ),
            ],
          );
        },
      );
    }
  }

  String getResultMessage() {
    if (score == 10) {
      return "Good Job! You're so Perfect!";
    } else if (score == 9) {
      return 'Almost! Wanna play again?';
    } else {
      return 'Learn More by Starting Over!';
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Quiz by jaefurr'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}:',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
            ),
            SizedBox(height: 9),
            Text(
              questions[currentQuestionIndex],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () => checkAnswer(true),
              child: Text('True'),
            ),
            ElevatedButton(
              onPressed: () => checkAnswer(false),
              child: Text('False'),
            ),
          ],
        ),
      ),
    );
  }
}
