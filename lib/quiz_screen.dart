import 'package:flutter/material.dart';
import 'package:dice_app/gradient.dart';
import 'package:dice_app/answer_button.dart';
import 'package:dice_app/data/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;

  void _selectAnswer(int selectedIndex) {
    final currentQuestion = questions[currentIndex];

    if (selectedIndex == currentQuestion.correctIndex) {
      score++;
    }

    setState(() {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: Text("Your score is $score/${questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                currentIndex = 0;
                score = 0;
              });
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question.text,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ...List.generate(
                question.options.length,
                (index) => OptionButton(
                  text: question.options[index],
                  onTap: () => _selectAnswer(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
