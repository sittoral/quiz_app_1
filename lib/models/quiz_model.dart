class QuizModel {
  final String question;
  final String correctAnswer;
  final List<String> answers;

  QuizModel({
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    final correct = json['correct_answer'] as String;
    final answers = [
      correct,
      ...List<String>.from(json['incorrect_answers']),
    ]..shuffle();

    return QuizModel(
      question: json['question'] as String,
      correctAnswer: correct,
      answers: answers,
    );
  }
}