import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
class Livro{
  var nome;
  var id;
  Livro(this.nome,this.id);
}

class HomePage extends StatefulWidget{

  @override

  StateHomePage createState() => StateHomePage();
}

class StateHomePage extends State<HomePage>{
  List<Livro> lista = [];
  String url = "https://biblia-catolica.herokuapp.com/api/biblia";

  Future<Map> getbiblia() async{
    Map data = Map();
    http.Response response = await http.get(
        url,
    headers: {"Content-Type" : "application/json"});

  data = jsonDecode(response.body);
  return data;
  }

  void loading(){
    lista = [];
    getbiblia().then((data){

      List list = data["livros"];
      if(list.length > 0){
        print(list);
        for(int i = 0;i<list.length && (i+1) < list.length;i++){
          setState(() {
            lista.add(Livro(list[i]["nome"], list[i]["id"]));
          });

        }
        
      }

    });



  }

  void initState(){
    super.initState();
    loading();
  }



  buildListTiles(BuildContext context, var nome,var pos){

    return new MergeSemantics(
      child: 
      new ListTile(
        title: new Text(nome),
        leading: new Icon(Icons.book),
        trailing: new IconButton(icon: new Icon(Icons.open_in_new), onPressed: (){}),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    Iterable<Widget> listtiles = lista.map((item) => buildListTiles(context, item.nome,item.id));

    return new Scaffold(
      drawer: new Drawer(
        child: 
        new Column(children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: new BoxDecoration(
              image: new DecorationImage( fit: BoxFit.fill,image: new NetworkImage("https://diocesesa.org.br/wp-content/uploads/2017/09/Confira-algumas-curiosidades-sobre-a-Bi%CC%81blia-2.jpg")),
            ),
              accountName: new Text("Nome"), 
              accountEmail: new Text("Email"),
              currentAccountPicture: new CircleAvatar(child: new Icon(Icons.person),
              ),
              ),
          new ListTile(
            title: new Text("Meus favoritos"),
            trailing: new Icon(Icons.star,color: Colors.yellow,),
            onTap: (){},
          ),
          new Divider(height: 2.0,),
        ],)
      ),
      appBar: new AppBar(),
      body: new ListView(children:

        lista.length < 1 ? <Widget>[new SizedBox(height: 200.0,),new Center(child: new CircularProgressIndicator())] :
       listtiles.toList(),),
    );
  }


}