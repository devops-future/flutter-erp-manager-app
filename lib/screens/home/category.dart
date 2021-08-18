import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:ancalmo_manager/models/db_structure.dart';
import 'package:ancalmo_manager/models/orders_args.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;
    final int cur_user_id = int.parse(args);
    List<Category> categories = [
      Category(4, "Caja Chica", "assets/icons/caja_chica.png"),
      Category(5, "Contrato", "assets/icons/contrato.png"),
      Category(3, "Emergencia", "assets/icons/emergencia.png"),
      Category(2, "Materia Prima", "assets/icons/materia_prima.png"),
      Category(1, "Regular", "assets/icons/regular.png")
    ];
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                //color: Color(0xffFEFEFE),
                image: DecorationImage(
                    image: AssetImage("assets/head_category.png"),
                    //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.dstATop),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter)),
            child: GridView.count(
              // crossAxisCount is the number of columns
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 20,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 6,
                  right: 15,
                  left: 15),
              children: List.generate(categories.length, (index) {
                return RaisedButton(
                  //minWidth: MediaQuery.of(context).size.width / 3,
                  //height: 60,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xffffffff), width: 3)),
                  color: Color(0xffffffff),
                  onPressed: () {
                    Navigator.pushNamed(context, '/list', arguments:AncalmoOrdersArguments(categories[index].id, cur_user_id));
                  },
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 20,
                      ),
                      Image(
                        alignment: Alignment.topCenter,
                        image: AssetImage(categories[index].image),
                        height: MediaQuery.of(context).size.width / 6,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 10,
                      ),
                      Center(
                          child: Text(
                        categories[index].title,
                        style: TextStyle(
                            color: Color(0xff2C92D5),
                            fontFamily: "CentraleSansRegular",
                            fontSize: 14),
                      ))
                    ],
                  ),
                );
              }),
            )));
  }
}
