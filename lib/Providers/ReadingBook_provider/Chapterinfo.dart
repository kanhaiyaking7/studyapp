

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/ReadingBook_provider/chapter_completed_model.dart';

final Chapterinfo = StateNotifierProvider<Chapternotifier,Book_completed>((ref){
  return Chapternotifier();
}
);

class Chapternotifier extends StateNotifier<Book_completed>{
  Chapternotifier():super(Book_completed(chapterinfo: []));

  void store_bookdata(String bookname, int chapter_completed){
    final data_struct = Chapter_completed(bookname: bookname, chapter_completed: chapter_completed);
    state.chapterinfo.add(data_struct);
    final pus = state.toString();
    print(pus);
  }

  void update_bookdata(String bookname, int chapter_completed){
    var filterdata= state.chapterinfo.where((element)=>element.bookname == bookname).toList();
    filterdata[0].chapter_completed ++;
    state = state.copyWith(chapterinfo: state.chapterinfo);
  }

   check_chapterlength(){
    return state.chapterinfo.length;
  }

   get_bookdata(String bookname){
    final bookfilter = state.chapterinfo.where((element)=>element.bookname == bookname).toList();
    final selectbook = bookfilter[0].chapter_completed;
    return selectbook;
  }

  update_booklevel(String bookname, int level){
    final bookfilter = state.chapterinfo.where((element)=>element.bookname == bookname).toList();
    bookfilter[0].chapter_completed = level;
   state =  state.copyWith(chapterinfo: state.chapterinfo);

  }


}


