import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../repositories/quiz_repository.dart';

class QuestionsPage extends StatefulWidget {
  final int amount;
  final int? category;
  final String? difficulty;

  const QuestionsPage({
    super.key,
    required this.amount,
    this.category,
    this.difficulty,
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final _repository = QuizRepository();
  late Future<List<QuizModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repository.getQuestions(
      amount: widget.amount,
      category: widget.category,
      difficulty: widget.difficulty,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<QuizModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Could not load questions'));
          }

          final quiz = snapshot.data!.first;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quiz.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 32),
                for (final answer in quiz.answers)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {}, 
                      child: Text(answer),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}