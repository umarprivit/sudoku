class Recordd{
final String category;
final int seconds;

const Recordd({required this.category,required this.seconds});


factory Recordd.fromJson (Map<String,dynamic> json)=> Recordd(
category :json["category"],
seconds :json["seconds"]

);


Map<String,dynamic> toJson() => {
  "category":category,
  "seconds":seconds
};
}