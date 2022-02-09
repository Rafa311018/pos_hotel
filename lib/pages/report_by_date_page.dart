import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_hotel/controllers/report_by_date_controller.dart';

class ReportByDatePage extends StatelessWidget {
  const ReportByDatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final reportByDatecontroller = Get.lazyPut(() => ReportByDateController(), fenix: true);

    return Scaffold(
      backgroundColor: const Color(0xffc2185b),
      floatingActionButton: GetBuilder<ReportByDateController>(
        builder: (_) {
          return FloatingActionButton(
            onPressed: (){
              _.generateReport();
            },
            child: const Icon(Icons.print_rounded),
            backgroundColor: const Color(0xff002651),
          );
        }
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffc2185b),
        elevation: 0.0,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
              alignment: Alignment.centerLeft,
            ),
            const Text(
              "Regresar",
              style: TextStyle(fontSize: 17.0),
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 30.0, top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle),
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      'assets/icons/icon_report.png',
                      width: 50.0,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Reporte",
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Nunito'),
                      ),
                      GetBuilder<ReportByDateController>(
                        id: 'title_date',
                        builder: (_) {
                          return Text(
                            "Fecha del reporte ${_.titleDate}",
                            style: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.white,
                                fontFamily: 'Nunito'),
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Seleccione la fecha",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Nunito'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(
                      Icons.date_range_rounded,
                      color: Colors.white,
                      size: 30.0,
                    ))
              ],
            ),
            Container(
                decoration: const BoxDecoration(
                    color: Color(0xffFAFAFA),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                width: Get.width,
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [

                    GetBuilder<ReportByDateController>(
                      id: 'list_remission',
                      builder: (_) {
                        return _.listRemissionByDate!.isNotEmpty ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index){
                              return Card(
                                //padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                elevation: 7.0,
                                shadowColor: Colors.grey.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                /*decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.09),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),*/
                                child: InkWell(
                                  onTap: (){},
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'REMISION ID ',
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(text: '${_.listRemissionByDate?[index]?.remisionId}',
                                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                                ],
                                              ),
                                            ),

                                            RichText(
                                              text: TextSpan(
                                                text: 'Fecha ',
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(text: '${DateFormat('dd/MM/yyyy').format(_.listRemissionByDate![index]!.createdDate)}',
                                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 15.0,
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Tasa ',
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(text: '${_.listRemissionByDate?[index]?.tasa} %',
                                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                                ],
                                              ),
                                            ),

                                            RichText(
                                              text: TextSpan(
                                                text: 'Total ',
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(text: '\$${_.listRemissionByDate![index]!.total}',
                                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),

                                        const SizedBox(
                                          height: 15.0,
                                        ),


                                        Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Método de pago ',
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(text: '${_.listRemissionByDate![index]!.metodoDePagoId == 1 ? 'EFECTIVO' : _.listRemissionByDate![index]!.metodoDePagoId == 2 ? 'CREDITO' :  _.listRemissionByDate![index]!.metodoDePagoId == 3 ? 'DEBITO' : '' }',
                                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox()
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 15.0,
                                        ),

                                        RichText(
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: 'Observaciones\n',
                                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(text: '${_.listRemissionByDate![index]!.observaciones }',
                                                  style: const TextStyle(fontWeight: FontWeight.normal)),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                        },itemCount: _.listRemissionByDate!.length, shrinkWrap: true,)
                            :
                        _.search == 0 ? Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text("Buscando", style: TextStyle(fontSize: 17.0, color: Colors.grey[400]),)
                            ],
                          ),
                        ) : Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/illustrations/search.png', width: 200.0,),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text("No hay resultados", style: TextStyle(fontSize: 17.0, color: Colors.grey[400]),)
                          ],
                        ));
                      }
                    )

                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _selectDate(BuildContext context) async {

  final ReportByDateController reportByDatecontroller = Get.find();

  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: reportByDatecontroller.selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2019),
      lastDate: DateTime(2101));
  if (picked != null) {
    reportByDatecontroller.handleDateListRemission(DateFormat("yyyy-MM-dd").format(picked));
  }
  /*selectedDate = picked;
      _dateController.text = DateFormat.yMd().format(selectedDate);*/
}
