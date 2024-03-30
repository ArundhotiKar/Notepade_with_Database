class Note{
  int? id;
   String title, description;
   DateTime createAt;

   Note({
    this.id,
    required this.title,
    required this.description,
    required this.createAt
   });

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title':title,
      'description':description,
      'createdAt':createAt.toString(),
    };
  }

}