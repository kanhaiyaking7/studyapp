

class Chapter_completed{
  String bookname;
  int chapter_completed;

  Chapter_completed({required this.bookname, required this.chapter_completed});

  Chapter_completed copyWith({ String? bookname,  int? chapter_completed}){
    return Chapter_completed(bookname: bookname ?? this.bookname , chapter_completed: chapter_completed ?? this.chapter_completed);
  }
}

class Book_completed{
  List <Chapter_completed> chapterinfo;

  Book_completed({required this.chapterinfo});

  Book_completed copyWith({List<Chapter_completed>? chapterinfo}){
    return Book_completed(chapterinfo: chapterinfo ?? this.chapterinfo);
  }


}