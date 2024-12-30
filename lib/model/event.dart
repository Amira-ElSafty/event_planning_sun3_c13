class Event{   // data class - model
  static const String collectionName = 'Events';
  String id ;
  String title ;
  String description ;
  String image ;
  String eventName  ;
  DateTime dateTime ;
  String time ;
  bool isFavorite ;

  Event({
    this.id = '',
    required this.title,required this.description,
    required this.image,required this.eventName,
    required this.dateTime, required this.time,
    this.isFavorite = false
});

  // json => object
  Event.fromFireStore(Map<String,dynamic>? data):this(
    id: data!['id'] as String,
    title: data['title'] as String,
    description: data['description'] as String,
    image: data['image'] as String,
    eventName: data['eventName']as String ,
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    time: data['time'],
    isFavorite: data['isFavorite'] as bool
  );
  // object => json
  Map<String,dynamic> toFireStore(){
    return {
      'id' : id ,
      'title' : title,
      'description' : description,
      'image' : image,
      'eventName' : eventName,
      'dateTime' : dateTime.millisecondsSinceEpoch,  // int
      'time' : time,
      'isFavorite' : isFavorite
    };
  }

}