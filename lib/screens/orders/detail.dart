import 'package:ancalmo_manager/data/rest_ds.dart';
import 'package:ancalmo_manager/models/order_detail_args.dart';
import 'package:ancalmo_manager/models/order_detail_response.dart';
import 'package:ancalmo_manager/screens/orders/detail_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:ancalmo_manager/models/db_structure.dart';

class DetailPage extends StatefulWidget {
  BuildContext _ctx;
  DetailPage(BuildContext context) {
    _ctx = context;
  }
  @override
  _DetailPageState createState() => _DetailPageState(_ctx);
}

class _DetailPageState extends State<DetailPage> implements DetailScreenContract {
  BuildContext _ctx;
  DetailScreenPresenter _presenter;
  _DetailPageState(BuildContext context) {
    _ctx = context;
    _presenter = new DetailScreenPresenter(this);
  }

  RestDatasource api = new RestDatasource();
  Future<AncalmoOrderDetailResponse> futureOrder;

  @override
  void initState() {
    super.initState();

    final AncalmoOrderDetailArguments args = ModalRoute.of(_ctx).settings.arguments;
    print('initState:build:' + args.order_no + ':' + args.user_id.toString());

    futureOrder = api.get_order(args.user_id, args.order_no);
  }

  OrderItem formatOrderRowString(OrderItem orderItem) {
    OrderItem itemRet = orderItem;
    if(itemRet.article.length > 18) {
      itemRet.article = orderItem.article.substring(0, 14) + '..';
    }
    return itemRet;
  }

  @override
  Widget build(BuildContext context) {
    final AncalmoOrderDetailArguments args = ModalRoute.of(_ctx).settings.arguments;
    final int cur_user_id = args.user_id;
    final String cur_order_no = args.order_no;

    double dScreenWidth = MediaQuery.of(context).size.width;
    double dDataTableWidth = dScreenWidth - 2 * 20;

    TextStyle styleTHead = TextStyle(
        fontSize: 12,
        color: Color(0xff152B76),
        fontWeight: FontWeight.bold
    );
    TextStyle styleTCell = TextStyle(
        color: Color(0xff152B76),
        fontSize: 12
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //color: Color(0xffFEFEFE),
          image: DecorationImage(
            image: AssetImage("assets/head_detail.png"),
            //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.dstATop),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter)),
        child: ListView(
          //physics: const AlwaysScrollableScrollPhysics(), // new
          children: <Widget>[
            Container(
                height: 490,
                margin: EdgeInsets.only(left: 20, top: MediaQuery.of(context).size.height/6, right: 20),
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
                    borderRadius: BorderRadius.all(Radius.elliptical(30, 60))
                ),
                child: Column(
                    //physics: const AlwaysScrollableScrollPhysics(), // new
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            Text(
                              'Establecimientos Ancalmo',
                              style: TextStyle(fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 30,),
                            Text(
                              'Orden de Compra',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              cur_order_no,
                              style: TextStyle(fontSize: 12.0,
                                  color: Color(0xff4A4D58),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Solicitante:',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10,),
                            FutureBuilder<AncalmoOrderDetailResponse>(
                                future: futureOrder,
                                builder: (context, snapshot) {
                                  List<DataRow> tblRows = new List<DataRow>();
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.applicant,
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      '',
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  }
                                }
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Departamento:',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10,),
                            FutureBuilder<AncalmoOrderDetailResponse>(
                                future: futureOrder,
                                builder: (context, snapshot) {
                                  List<DataRow> tblRows = new List<DataRow>();
                                  if (snapshot.hasData) {
                                    String strDepartment = snapshot.data.department;
                                    if(strDepartment.length > 27) {
                                      strDepartment = strDepartment.substring(0, 27) + '..';
                                    }
                                    return Text(
                                      strDepartment,
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      '',
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  }
                                }
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                        child: FutureBuilder<AncalmoOrderDetailResponse>(
                          future: futureOrder,
                          builder: (context, snapshot) {
                            List<DataRow> tblRows = new List<DataRow>();
                            if (snapshot.hasData) {
                              List.generate(snapshot.data.details.length, (index) {
                                tblRows.add(
                                  DataRow(
                                    onSelectChanged:  (bool selected) {
                                      if (selected) {

                                      }
                                    },
                                    cells: <DataCell>[
                                      DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.1, child:Text(snapshot.data.details[index].item_no.toString()))),
                                      DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.2, child:Text(snapshot.data.details[index].article))),
                                      DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.15, child:Text(snapshot.data.details[index].medida))),
                                      DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.15, child:Text('\$' + snapshot.data.details[index].price.toString()))),
                                      DataCell(Container(padding: EdgeInsets.only(top: 10), width: dDataTableWidth * 0.15,
                                          child:Text(
                                              snapshot.data.details[index].cantidad.toString(),
                                              textAlign: TextAlign.center,
                                          ))),
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
                                  DataColumn( label: Text( 'Item.' ) ),
                                  DataColumn( label: Text( 'Articulo' ) ),
                                  DataColumn( label: Text( 'Proveedor.' ) ),
                                  DataColumn( label: Text( 'Precio' ) ),
                                  DataColumn( label: Text( 'Cantidad' ) ),
                                ],
                                rows: tblRows
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Aprobaciones',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                            ),
                          ]
                      ),
                      Row(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Gestor de compras',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58)),
                            ),
                            SizedBox(width: 10,),
                            FutureBuilder<AncalmoOrderDetailResponse>(
                                future: futureOrder,
                                builder: (context, snapshot) {
                                  List<DataRow> tblRows = new List<DataRow>();
                                  if (snapshot.hasData) {
                                    String strCut = snapshot.data.manager_name;
                                    if(strCut.length > 23) {
                                      strCut = strCut.substring(0, 23) + '..';
                                    }
                                    return Text(
                                      strCut,
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      '',
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  }
                                }
                            ),
                          ]
                      ),
                      Row(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Jefe de Compras',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58)),
                            ),
                            SizedBox(width: 10,),
                            FutureBuilder<AncalmoOrderDetailResponse>(
                                future: futureOrder,
                                builder: (context, snapshot) {
                                  List<DataRow> tblRows = new List<DataRow>();
                                  if (snapshot.hasData) {
                                    String strCut = snapshot.data.director_name1;
                                    if(strCut.length > 23) {
                                      strCut = strCut.substring(0, 23) + '..';
                                    }
                                    return Text(
                                      strCut,
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      '',
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  }
                                }
                            ),
                          ]
                      ),
                      Row(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Director Area',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58)),
                            ),
                            SizedBox(width: 10,),
                            FutureBuilder<AncalmoOrderDetailResponse>(
                                future: futureOrder,
                                builder: (context, snapshot) {
                                  List<DataRow> tblRows = new List<DataRow>();
                                  if (snapshot.hasData) {
                                    String strCut = snapshot.data.director_name2;
                                    if(strCut.length > 23) {
                                      strCut = strCut.substring(0, 23) + '..';
                                    }
                                    return Text(
                                      strCut,
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      '',
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  }
                                }
                            ),
                          ]
                      ),
                      Row(
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Director Financiero',
                              style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58)),
                            ),
                            SizedBox(width: 10,),
                            FutureBuilder<AncalmoOrderDetailResponse>(
                                future: futureOrder,
                                builder: (context, snapshot) {
                                  List<DataRow> tblRows = new List<DataRow>();
                                  if (snapshot.hasData) {
                                    String strCut = snapshot.data.director_name3;
                                    if(strCut.length > 23) {
                                      strCut = strCut.substring(0, 23) + '..';
                                    }
                                    return Text(
                                      strCut,
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      '',
                                      style: TextStyle(fontSize: 12.0, color: Color(0xff4A4D58), fontWeight: FontWeight.bold),
                                    );
                                  }
                                }
                            ),
                          ]
                      ),
                      /*
                      SizedBox(height: 20,),
                      Row(
                        // This next line does the trick.
                        children: [
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 3, // 60% of space => (6/(6 + 4))
                            child: FlatButton(
                              height: 25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Color(0xff707070),
                                      width: 1
                                  )
                              ),
                              color: Color(0xff0A2555),
                              onPressed: (){
                              },
                              child: Text(
                                "Ver Solicitud",
                                style: TextStyle(
                                    color: Color(0xffF7F7FC),
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 7,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 3, // 60% of space => (6/(6 + 4))
                            child: FlatButton(
                              height: 25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Color(0xff707070),
                                      width: 1
                                  )
                              ),
                              color: Color(0xff0A2555),
                              onPressed: (){
                              },
                              child: Text(
                                "Ver Cotizzacion",
                                style: TextStyle(
                                    color: Color(0xffF7F7FC),
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 7,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 3, // 60% of space => (6/(6 + 4))
                            child: FlatButton(
                              height: 25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Color(0xff707070),
                                      width: 1
                                  )
                              ),
                              color: Color(0xff0A2555),
                              onPressed: (){
                              },
                              child: Text(
                                "Ver Orden Compra",
                                style: TextStyle(
                                    color: Color(0xffF7F7FC),
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 7,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                       */
                    ]
                )
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                  // This next line does the trick.
                children: [
                  Expanded(
                    flex: 5, // 60% of space => (6/(6 + 4))
                    child: FlatButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                              color: Color(0xff707070),
                              width: 1
                          )
                      ),
                      color: Color(0xffF0306B),
                      onPressed: (){
                        _presenter.doSign(cur_user_id, cur_order_no, true);
                      },
                      child: Text(
                        "Rechazar",
                        style: TextStyle(
                            color: Color(0xffF7F7FC),
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 5, // 60% of space => (6/(6 + 4))
                    child: FlatButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                              color: Color(0xff707070),
                              width: 1
                          )
                      ),
                      color: Color(0xff30D168),
                      onPressed: (){
                        _presenter.doSign(cur_user_id, cur_order_no, false);
                      },
                      child: Text(
                        "Aprobar",
                        style: TextStyle(
                            color: Color(0xffF7F7FC),
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }

  @override
  void onSignError(String errorTxt) {
    print('onSignError');
    Navigator.of(_ctx).pop(errorTxt);
  }

  @override
  void onSignSuccess() {
    print('onSignSuccess');
    Navigator.of(_ctx).pop('Aplicada con éxito!');
  }
}

