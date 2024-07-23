class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> get shuffledAnswers{
  final shuffledList = List.of(answers); // This method .of copies the values old list to new list
  shuffledList.shuffle(); // this method will shuffle the order of the exixting list thats why doing in new list is preferable
  return shuffledList; 
  }


}
