part of 'bloc.dart';

class FaqsModel {
  late final List<Data> list;


  FaqsModel.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']??[]).map((e)=>Data.fromJson(e)).toList();

  }
}

class Data {
  late final int id;
  late final String question, answer;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    question = json['question']??'';
    answer = json['answer']??'';
  }

}