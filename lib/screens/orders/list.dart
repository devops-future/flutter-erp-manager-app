//import 'package:ancalmo_manager/list.dart';
import 'package:ancalmo_manager/data/rest_ds.dart';
import 'package:ancalmo_manager/models/order_detail_args.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'detail.dart';
import 'package:ancalmo_manager/models/db_structure.dart';
import 'package:ancalmo_manager/models/orders_args.dart';
import 'package:ancalmo_manager/models/orders_response.dart';

class ListPage extends StatefulWidget {
  BuildContext _ctx;
  ListPage(BuildContext context) {
    _ctx = context;
  }
  @override
  _ListPageState createState() => _ListPageState(_ctx);
}

class _ListPageState extends State<ListPage> {
  BuildContext _ctx;
  _ListPageState(BuildContext context) {
    _ctx = context;
  }

  RestDatasource api = new RestDatasource();
  Future<AncalmoOrdersResponse> futureOrders;
  TextEditingController searchValController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    final AncalmoOrdersArguments args = ModalRoute.of(_ctx).settings.arguments;
    print('initState:build:' + args.cate_id.toString() + ':' + args.user_id.toString());

    futureOrders = api.get_orders(args.user_id, args.cate_id);
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  AncalmoOrder formatOrderRowString(AncalmoOrder order) {
    AncalmoOrder orderRet = order;
    if(order.article.length > 14) {
      orderRet.article = order.article.substring(0, 14) + '..';
    }
    if(order.provider.length > 18) {
      orderRet.provider = order.provider.substring(0, 18) + '..';
    }
    if(order.applicant.length > 18) {
      orderRet.applicant = order.applicant.substring(0, 18) + '..';
    }
    return orderRet;
  }

  @override
  Widget build(BuildContext context) {
    final AncalmoOrdersArguments args = ModalRoute.of(_ctx).settings.arguments;
    final int cur_user_id = args.user_id;
    final int cur_cate_id = args.cate_id;

    List<String> states = [
      "PENDI..",
      "APROB..",
      "RECHZ.."
    ];

    double dScreenWidth = MediaQuery.of(context).size.width;
    double dDataTableWidth = dScreenWidth - 2 * 20;

    const TextStyle styleTHead = TextStyle(
      fontSize: 10,
      color: Color(0xff152B76),
      fontWeight: FontWeight.bold
    );
    const TextStyle styleTCell = TextStyle(
      color: Color(0xff152B76),
      fontSize: 10
    );

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          //color: Color(0xffFEFEFE),
            image: DecorationImage(
                image: AssetImage("assets/head_list.png"),
                //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.dstATop),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height/7,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: const Offset(0, 3.0),
                        blurRadius: 3.0,
                        spreadRadius: 1.0
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: FutureBuilder<AncalmoOrdersResponse>(
                future: futureOrders,
                builder: (context, snapshot) {
                  List<DataRow> tblRows = new List<DataRow>();
                  if (snapshot.hasData) {
                    List.generate(snapshot.data.rows.length, (index) {
                      AncalmoOrder orderShowRow = this.formatOrderRowString(snapshot.data.rows[index]);
                      String strState = states[snapshot.data.rows[index].state];
                      Color clrState;
                      switch (snapshot.data.rows[index].state) {
                        case 1:
                          clrState = Colors.green;
                          break;
                        case 2:
                          clrState = Colors.red;
                          break;
                        default:
                          clrState = Colors.grey;
                          break;
                      }
                      tblRows.add(
                        DataRow(
                          color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            //return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                            return Color(0xffF1F1F1);
                          }),
                          onSelectChanged:  (bool selected) {
                            if (selected) {
                              Navigator.pushNamed(context, '/detail', arguments:AncalmoOrderDetailArguments(snapshot.data.rows[index].order_no, cur_user_id))
                                  .then((value) {
                                setState(() {
                                  print('popping');
                                  scaffoldKey.currentState
                                      .showSnackBar(new SnackBar(content: new Text(value)));
                                  futureOrders = api.get_orders(cur_user_id, cur_cate_id);
                                });
                              });
                            }
                          },
                          cells: <DataCell>[
                            DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.1, child:Center(child:Text(orderShowRow.order_no)))),
                            DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.15, child:Center(child:Text(orderShowRow.article)))),
                            DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.2, child:Center(child:Text(orderShowRow.provider)))),
                            DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.2, child:Center(child:Text(orderShowRow.applicant)))),
                            DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.15, child:Center(child:Text(strState, style: TextStyle(fontSize: 10, color: clrState))))),
                          ],
                        ),
                      );
                    });
                  }
                  return DataTable(
                      headingTextStyle: styleTHead,
                      dataTextStyle: styleTCell,
                      columnSpacing: 5,
                      dividerThickness: 10,
                      showCheckboxColumn: false,
                      columns: const <DataColumn>[
                        DataColumn( label: Text( 'ORDEN' ) ),
                        DataColumn( label: Text( 'ARTICULO' ) ),
                        DataColumn( label: Text( 'PROVEEDOR' ) ),
                        DataColumn( label: Text( 'SOLICITANTE' ) ),
                        DataColumn( label: Text( 'ESTADO' ) ),
                      ],
                      rows: tblRows
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: searchValController,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "CentraleSansRegular"
              ),
              decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(vertical: 5.0),
                  /*
                  prefixIcon: Icon(LineAwesomeIcons.user,
                    color: Color(0xffC7CFDC),
                    size: 30,),
                   */
                  prefixIcon: new Image(
                    image: new AssetImage("assets/icons/order.png"),
                    width: 30,
                    height: 30,
                    color: Color(0xffC7CFDC),
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color(0xff8A99B2),
                          width: 1
                      )
                  ),
                  hintText: "Ingresar identificador orden de compra",
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: "CentraleSansRegular"
                  )
              ),
            ),
            SizedBox(height: 20),
            FlatButton(
                height: 48,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Color(0xff0A2555),
                        width: 3
                    )
                ),
                color: Color(0xff0A2555),
                onPressed: (){
                  setState(() {
                    print('search with query');
                    futureOrders = api.get_orders(cur_user_id, cur_cate_id, searchValController.text.trim());
                  });
                },
                child: Text(
                  "Buscar Orden",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CentraleSansRegular",
                      fontSize: 18
                  ),
                )
            ),
          ]
        )
      ),
    );
  }
}
