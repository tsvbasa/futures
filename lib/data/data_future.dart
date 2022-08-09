class DataFuture{

  List<Map<String,dynamic>> _dataList = [
    {
      "fullName": "Fiorella Gonzales",
      "address": "Av. Lima 2342"
    },
    // {
    //   "fullName": "José Tapia",
    //   "address": "Calle Gonzales Prada 3455"
    // },
  ];

  Future<List<Map<String, dynamic>>> getDataList() async{
    return Future.delayed(Duration(seconds: 3),(){
      return _dataList;
    });
  }

  addPerson(Map<String,dynamic> person){
    _dataList.add(person);
  }

}