class Task{
   static const  String collectionName= 'tasks';
  String id;
  String tittle;
  String description;
  DateTime dateTime;
  bool isdone;

  Task({this.id='',
    required this.tittle,
    required this.description,
    required this.dateTime,
    this.isdone=false});
  Task.fromFireStore(Map<String,dynamic> data):this(
    id: data['id'] as String,
    tittle: data['tittle'] as String,
    description: data ['description'] as String,
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['datetime']) as DateTime,
    isdone: data['isdone'] as bool

  );
  Map<String,dynamic> toJson(){
    return {
      'id':id ,
      'tittle': tittle,
      'description': description,
      'datetime': dateTime.millisecondsSinceEpoch,
      'isdone': isdone
  };
  }
}
