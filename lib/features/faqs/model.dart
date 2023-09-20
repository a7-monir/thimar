part of 'bloc.dart';

class FaqsData {
  late final List<FaqsModel> list;


  FaqsData.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']??[]).map((e)=>FaqsModel.fromJson(e)).toList();

  }
}

class FaqsModel {
  late final int id;
  late final String question, answer;

  FaqsModel.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    question = json['question']??'';
    answer = json['answer']??'';
  }

}