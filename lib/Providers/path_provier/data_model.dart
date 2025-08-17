

class DataModel{
  Object data;
  int Level;

  DataModel({required this.data, required this.Level});

  DataModel copyWith({Object? data, int? Level}){
    return DataModel(data: data ?? this.data , Level: Level ?? this.Level);
  }
}