<%@ Page Language="VB" AutoEventWireup="false" CodeFile="porcentajecarpool.aspx.vb" Inherits="privado_porcentajecarpool" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/png" />
  <title>Utilización CarPool | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/amCharts.css" rel="stylesheet" type="text/css" />
  <link href="css/jquery.datatables.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
  <%--<link href="css/select2.css" rel="stylesheet" />--%>
  <link href="css/jquery.fancybox.css" rel="stylesheet" />
  <link href="css/dataTables.tableTools.min.css" rel="stylesheet" />
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>
<body>
<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<section>
  <div class="leftpanel">
    <div class="logopanel">
        <h1><span>[</span> Monitoreo <span>]</span></h1>
    </div><!-- logopanel -->
    <div class="leftpanelinner">
        <!-- This is only visible to small devices -->
        <!-- #include file="usuario.html"-->
      <h5 class="sidebartitle">Men&uacute;</h5>
      <!--#include file="menu.html" -->
    </div><!-- leftpanelinner -->
  </div><!-- leftpanel -->
  <div class="mainpanel">
    <div class="headerbar">
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      <!-- #INCLUDE FILE="usuariomenu.html" --> 
    </div><!-- headerbar -->
    <div class="pageheader">
      <h2><i class="fa fa-th-large"></i> Utilización CarPool <span>Reportes</span></h2>
    </div>
    <div class="contentpanel">
      <div class="row">
        <div class="col-md-12">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title">Filtros:</h4>
              <form runat="Server" id="filtro">
                <div class="form-group" id="filtroGrafica">
                    <div class="form-group">
                        <label class="col-sm-2">Fecha Inicial:</label>
                        <div class="col-sm-4">
                           <input type="text" id="TxtFechaInicio" ReadOnly="true"  class="form-control fecha" />
                        </div>
                        <label class="col-sm-2">Fecha Final:</label>
                        <div class="col-sm-4">
                           <input type="text" id="TxtFechaFinal" ReadOnly="true" class="form-control fecha" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                        </div>
                        <div class="col-sm-2">
                           <input type="button" value="Actualizar" id="BtnActualizar" class="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </form>
            </div>
            <div class="panel-body panel-body-nopadding">
                        <div class="col-sm-12" id="graphica">
                            <div id="PorcentajeDepartamento" style="width:100%; height:380px; position:relative;" ></div>
                        </div>    
                        <div class="col-sm-12" id="graphica1" style="display:none;">
                            <div id="PorcentajePorDepartamento" style="width:100%; height:380px; position:relative;" ></div>
                        </div>                 
                 <div class="col-sm-12" id="graphica2" style="display:none;">
          
                 </div>   

                

                
             
                    <div class="table-responsive" style="display:none;" id="DivDet">
                      <table class="table" id="tableDetalle" >
                          <thead>
                             <tr>
                                <th>Fecha</th>
                                <th>Vehiculo</th>
                                <th>Codigo</th>
                                <th>Descripcion</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Total</th>
                             </tr>
                          </thead>
                          <tbody>
                          </tbody>
                       </table>
                    </div>
                    <div class="table-responsive" style="display:none;" id="DivDetalle">
                        <table class="table" id="DetalleFacturacion" >
                          <thead>
                             <tr><th>Fecha</th><th>Documento</th><th>Vehiculo</th><th>Codigo</th><th>Clasificacion</th><th>Subclasificacion</th><th>Descripcion</th><th>Cantidad</th><th>Precio</th><th>Total</th></tr>
                          </thead>
                          <tbody>
                          </tbody>
                       </table>    
                      </div><!-- table-responsive -->

                        <%--            <div class="table-responsive" style="display:none;" id="TablaReservaciones">--%>
                <table class="table table-hidaction table-hover mb30 TablaReservaciones"id="TablaReservaciones" style="display:none;" >
                    <thead>
                        <tr>
                          
                            <th>Numero de Reservacion</th>
                            <th>Vehiculo</th>
                            <th>Fecha de Entrega</th>
                            <th>Fecha de Devolucion</th>
                                                      <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
          <%--  </div><!-- panel-body -->--%>
               <div class="panel-body panel-body-nopadding">

                       <div class="col-sm-12" id="graphica6" style="display:none;">
                            <div id="PorcentajeDepartamentoG" style="width:100%; height:300px; position:relative; top: 0px; left: 0px;" ></div>
                             <div style="margin-left:40px;">
                        <input type="radio"  name="group" id="rb1" onclick="setDepth()">2D
                        <input type="radio" checked="checked" name="group" id="rb2" onclick="setDepth()">3D
		</div>
                        </div>    
                                     
                  <%--<div id ="barra" style="width:100%; height:380px; position:relative;""></div>--%>
            
               
                     </div> 

                <div><a data-toggle="tab" type ="hidden"><span id="destino">Detalle:</a></div>
                  
                            
          	<div class="col-sm-12" id="graphica4" style="display:none;">
                           <div id="chartdiv1" style="width: 100%; height: 500px;"></div> 
                        </div>    
                <div class="col-sm-12" id="graphica5" style="display:none;">
                            <div id="chartdiv" style="width: 100%; height: 600px;"></div> 
                        </div>    

    </div><!-- contentpanel -->

             

            </div>
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-md-12 -->
      </div><!-- row -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>


<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script src="js/amCharts/amcharts.js" type="text/javascript"></script>
<script src="js/amCharts/pie.js" type="text/javascript"></script>
<script src="js/amCharts/serial.js" type="text/javascript"></script>
<script src="js/bootstrap-wizard.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/chosen.jquery.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/jquery.gritter.min.js"></script>
<%--<script src="js/select2.min.js"></script>--%>
<script src="js/jquery-ui-1.10.3.min.js"></script>
<script src="js/jquery.datatables.min.js"></script>
<script src="js/dataTables.tableTools.js"></script>
<script src="js/jquery.fancybox.js"></script>
<script>
    jQuery(document).ready(function () {
        //$("#tableDetalle").DataTable();
        var meses = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];
        $(".fecha").datepicker({
            monthnames: meses,
            dateformat: 'yyyy-mm-dd'
        });
        $("#DetalleFacturacion").DataTable({
            "sDom": 'T<"clear">lfrtip',
            "oTableTools": {
                "sSwfPath": "swf/copy_csv_xls_pdf.swf",
                "aButtons": [
                    "copy",
                    "print",
                    {
                        "sExtends": "collection",
                        "sButtonText": "Save",
                        "aButtons": ["csv", "xls", "pdf"]
                    }
                ]
            }
        });
        jQuery('#table2').dataTable({
            "sPaginationType": "full_numbers"
        });
        jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#BtnActualizar").click(function () {
            PorcentajeDepartamento();
            $("#TablaReservaciones").hide();
        });
    });
    function PorcentajeDepartamento(event) {
        $("#PorcentajePorDepartamento").hide();
        $("#graphica4").hide();
        $("#chartdiv1").hide();
        $("#graphica5").hide();
        $("#chartdiv").hide();
        $("#graphica6").hide();
        $("#PorcentajePorDepartamentoG").hide();
        $("#TablaReservaciones").hide();


        $(".TablaReservaciones").dataTable().fnClearTable();
        if ($("#TxtFechaInicio").val() != "" && $("#TxtFechaFinal").val() != "") {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/PorcentajeDepartamento",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "'}",
                success: function (data) {
                    if (data.d.length == 0) {
                        jQuery.gritter.add({
                            title: 'Se Ha Producido Un Error!',
                            text: "No hay Información para Rango de Fechas Ingresado",
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        return;
                    }
                    $.each(data.d, function (i, item) {
                        if (item.StrError != "0") {
                            jQuery.gritter.add({
                                title: 'Se Ha Producido Un Error!',
                                text: item.StrError,
                                class_name: 'growl-danger',
                                image: 'images/screen.png',
                                sticky: false,
                                time: ''
                            });
                            return;
                        }
                    });
                    chart1 = new AmCharts.AmPieChart();
                    chart1.addTitle("Porcentaje Utilización por Departamento", 12);
                    chart1.dataProvider = data.d;
                    chart1.titleField = "Descripcion";
                    chart1.valueField = "Minutos";
                    chart1.sequencedAnimation = true;
                    chart1.startEffect = "elastic";
                    chart1.innerRadius = "30%";
                    chart1.pullOutOnlyOne = true;
                    chart1.startDuration = 2;
                    chart1.labelRadius = 15;
                    chart1.labelText = "[[title]]: ([[percents]]%)";
                    chart1.hideLabelsPercent = 2.8;
                    chart1.fieldCantidad = "Cantidad";
                    chart1.fieldId = "IdDepartamento";
                    chart1.balloonText = "<span style='font-size:14px'><b>([[percents]]%)</b></span><br>[[title]]<br>Cantidad: [[Cantidad]]";
                    chart1.depth3D = 10;
                    chart1.angle = 15;
                    chart1.addListener("clickSlice", PorcentajePorDepartamento);
                    chart1.write("PorcentajeDepartamento");
                    $("#PorcentajeDepartamento").show();
                },
                error: function (data) {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
            });
        } else {
            jQuery.gritter.add({
                title: 'Se Ha Producido Un Error!',
                text: "Ingresar Rango de Fechas",
                class_name: 'growl-danger',
                image: 'images/screen.png',
                sticky: false,
                time: ''
            });
        }
    }
    function PorcentajePorDepartamento(event) {
        var IdDepartamento = event.dataItem.dataContext.IdDepartamento;
        var FechaInicio = event.dataItem.dataContext.FechaInicio;
        var FechaFin = event.dataItem.dataContext.FechaFin;
        $(".TablaReservaciones").dataTable().fnClearTable();
        $("#graphica4").hide();
        $("#chartdiv1").hide();
        $("#graphica5").hide();
        $("#chartdiv").hide();
        $("#graphica6").hide();
        $("#PorcentajePorDepartamentoG").hide();
        $("#TablaReservaciones").hide();
        $.ajax({
            type: "POST",
            url: "WebService.asmx/PorcentajePorDepartamento",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{FechaInicio:'" + FechaInicio + "', FechaFin:'" + FechaFin + "', IdDepartamento:" + IdDepartamento + "}",
            success: function (data) {

                $.each(data.d, function (i, item) {
                    if (item.StrError != "0") {
                        jQuery.gritter.add({
                            title: 'Se Ha Producido Un Error!',
                            text: item.StrError,
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        return;
                    }
                });
                chart = new AmCharts.AmPieChart();
                chart.addTitle("Porcentaje Utilización por Departamento/Empleado", 12);
                chart.dataProvider = data.d;
                chart.titleField = "Nombre";
                chart.valueField = "Minutos";
                chart.sequencedAnimation = true;
                chart.startEffect = "elastic";
                chart.innerRadius = "30%";
                chart.pullOutOnlyOne = true;
                chart.startDuration = 2;
                chart.labelRadius = 15;
                chart.labelText = "[[title]]: ([[percents]]%)";
                chart.fieldId = "IdDepartamento";
                chart.fieldCantidad = "Cantidad";
                chart.balloonText = "<span style='font-size:14px'><b>([[percents]]%)</b></span><br>[[title]]<br>Cantidad: [[Cantidad]]";
                chart.depth3D = 10;
                chart.angle = 15;

                //chart.addListener("clickSlice", PorcentajePorDepartamento);

                chart.addListener("clickSlice", MostrarDetalle);



                $("#TablaReservaciones").show

                $("#graphica1").show();
                $("#PorcentajePorDepartamento").show();
                $("#graphica2").show();
                $("#chartdiv").show();
                chart.write("PorcentajePorDepartamento");
            },
            error: function (data) {
                jQuery.gritter.add({
                    title: 'Se Ha Producido Un Error!',
                    text: data.responseText,
                    class_name: 'growl-danger',
                    image: 'images/screen.png',
                    sticky: false,
                    time: ''
                });
            }
        });

    }





    function MostrarDetalle(event) {
        $("#graphica4").hide();
        $("#chartdiv1").hide();
        $("#graphica5").hide();
        $("#chartdiv").hide();
        $("#graphica6").hide();
        $("#PorcentajePorDepartamentoG").hide();
        $("#TablaReservaciones").show();
        var IdUsuario = event.dataItem.dataContext.IdEmpleado;
        $(".TablaReservaciones").dataTable().fnClearTable();
        console.log(event);
        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleReservaciones",

            data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "', Usuario:'" + IdUsuario + "'  }",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                console.log(data);
                console.log(data.d);
                $.each(data.d, function (index, item) {

                    $(".TablaReservaciones").dataTable().fnAddData([
                        item.NoReservacion,
                        item.Vehiculo,
                        item.FechaEntrega,
                        item.FechaDevolucion,
                        "<button type='button' id-reservacion='" + item.NoReservacion + "' id='" + item.Vehiculo + "' class='btn btn-default btn-xs BtnDetalle'  aria-label='Left Align'><i class='glyphicon glyphicon-edit DetalleReservacion'></i> DetalleReservacion</button>"
                    ]);
                });
            },
            error: function (data) {
                console.log(data);
            }
        });
    }
    //aqui comienza el detalle
    $(document).ready(function () {
        $(".TablaReservaciones tbody").on("click", ".BtnDetalle", function () {
            var id = this.id;
            console.log(id);
            var idReservacion = $(this).attr("id-reservacion");
            console.log(idReservacion);
            //var celdaValor = $(this).find('td(2)');
            $("#PorcentajePorDepartamentoG").hide();
            $("#graphica2").hide();
            $("#chartdiv1").hide();
            $("#graphica3").hide();
            $("#chartdiv0").hide();
            $("#graphica4").hide();
            $("#chartdiv1").hide();
            $("#graphica5").hide();
            $("#chartdiv").hide();
            $("#graphica6").show();
            $("#PorcentajePorDepartamentoG").show();

            $.ajax({
                type: "POST",
                url: "WebService.asmx/DetalleReservacionesUsuarioPool",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{IdReservacion:'" + idReservacion + "',IdVehiculo:'" + id + "'}",
                success: function (data) {
                    console.log(data);
                    console.log(data.d);
                    $.each(data.d, function (i, item) {
                        if (item.StrError != "0") {
                            jQuery.gritter.add({
                                title: 'Se Ha Producido Un Error!',
                                text: item.StrError,
                                class_name: 'growl-danger',
                                image: 'images/screen.png',
                                sticky: false,
                                time: ''
                            });
                            return;
                        }
                    });

                    //CodigoV= item.Codigo;
                    // SERIALL CHART

                    chart = new AmCharts.AmSerialChart();
                    chart.dataProvider = data.d;
                    chart.categoryField = "Codigo";
                    chart.plotAreaBorderAlpha = 0.2;
                    chart.rotate = true;


                    // AXES
                    // Category
                    var categoryAxis = chart.categoryAxis;
                    categoryAxis.gridAlpha = 0.1;
                    categoryAxis.axisAlpha = 0;
                    categoryAxis.gridPosition = "start";

                    // value                      
                    var valueAxis = new AmCharts.ValueAxis();
                    valueAxis.stackType = "regular";
                    valueAxis.gridAlpha = 0.1;
                    valueAxis.axisAlpha = 0;

                    chart.addValueAxis(valueAxis);

                    // GRAPHS
                    // firstgraph 
                    var graph = new AmCharts.AmGraph();
                    graph.title = "Gentrac_Mobil";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "GENTRAC";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.zoomable
                    graph.lineColor = "#EEFE17";
                    graph.fieldCodigo = "Codigo"

                    graph.balloonText = "<b><span style='color:#EEFE17'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b>[[HoraG]]([[percents]]%) <br> Parametros de medicion </b><br><b> Gentrac 5% (lunes-viernes)    </b> </b><br><b>Gentrac 43% (lunes - domingo)   </b></span>";

                    chart.depth3D = 20;
                    chart.angle = 30;










                    chart.addGraph(graph);
                    //Gentrac Fin de semana
                    var graph = new AmCharts.AmGraph();
                    graph.title = "gentrac/mobil fin de semana";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "GENTRAC_MOBILFIN";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#FFEF00";
                    graph.fieldCodigo = "Codigo"
                    graph.balloonText = "<b><span style='color:#FFEF00'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b>[[HoraGF]]([[percents]]%) <br> Parametros de medicion </b><br><b> Gentrac 5% (lunes-viernes)    </b> </b><br><br><b> Gentrac 43% (lunes - domingo)   </b></span>";

                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);

                    // Visitas                         
                    graph = new AmCharts.AmGraph();
                    graph.title = "visitas";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "VISITAS";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#190986";
                    graph.color = "#FFFFFF";
                    graph.fieldCodigo = "Codigo"
                    graph.balloonText = "<b><span style='color:#190986'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]]<br> <b>Tiempo: </b>[[HoraV]]([[percents]]%)</span>";
                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);
                    chart.addListener("clickGraphItem", PorcentajePorRubro);
                    chart.addListener("clickGraphItem", PorcentajePorRubro);

                    // Visitas Nocturno                             
                    graph = new AmCharts.AmGraph();
                    graph.title = "visitas Nocturno";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "VISITAS_NOCTURNO";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#3943FA";
                    graph.color = "#FFFFFF";
                    graph.fieldCodigo = "Codigo"
                    graph.balloonText = "<b><span style='color:#190986'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]]<br> <b>Tiempo: </b>[[HoraVN]]([[percents]]%)</span>";
                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);


                    // Visitas Fin de semana                           
                    graph = new AmCharts.AmGraph();
                    graph.title = "visitas fin de semana";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "VISITAS_FIN_SEMANA";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#3138B6";
                    graph.color = "#FFFFFF";
                    graph.fieldCodigo = "Codigo"
                    graph.balloonText = "<b><span style='color:#190986'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]]<br> <b>Tiempo: </b>[[HoraVF]]([[percents]]%)</span>";
                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);


                    // Apagado            
                    graph = new AmCharts.AmGraph();
                    graph.title = "apagado";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "APAGADO";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#FF0008";
                    graph.balloonText = "<b><span style='color:#FF0008'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b> [[HoraA]]([[percents]]%) <br> Parametros de medicion </b><br><b> Apagado 33%(lunes-domingo)      </b> </b><br><b> Apagado 24%(lunes-viernes)  </b></span>";

                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);

                    // apagado nocturno
                    graph = new AmCharts.AmGraph();
                    graph.title = "apagado nacturno";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "APAGADO_NOCTURNO";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#D53232";
                    graph.balloonText = "<b><span style='color:#FF0008'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b> [[HoraAN]]([[percents]]%) <br> Parametros de medicion </b><br><b> Apagado 33%(lunes-domingo)      </b> </b><br><b> Apagado 24%(lunes-viernes)   </b></span>";

                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);

                    // apagado Fin de semana
                    graph = new AmCharts.AmGraph();
                    graph.title = "apagado fin de semana";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "APAGADO_FIN";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#B80000";
                    graph.balloonText = "<b><span style='color:#FF0008'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b> [[HoraAF]]([[percents]]%) <br> Parametros de medicion </b><br><b> Apagado 33%(lunes-domingo)        </b> </b><br><b> Apagado 24%(lunes-viernes)  </b></span>";

                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);



                    // fourth graph 
                    graph = new AmCharts.AmGraph();
                    graph.title = "desplazamiento";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "DESPLAZAMIENTO";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#29A838";
                    graph.balloonText = "<b><span style='color:#29A838'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b>[[HoraD]]([[percents]]%)</span>";
                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);

                    // taller
                    graph = new AmCharts.AmGraph();
                    graph.title = "Taller";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "TALLER";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#FA4F06";
                    graph.balloonText = "<b><span style='color:#FA4F06'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b> [[HoraT]]([[percents]]%)</span>";
                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);

                    // fifth graph 


                    // LEGEND
                    var legend = new AmCharts.AmLegend();
                    legend.position = "top";
                    legend.borderAlpha = 0.3;
                    legend.horizontalGap = 10;
                    legend.switchType = "v";
                    chart.addLegend(legend);

                    // WRITE


                    //chart.addListener("clickSlice", PorcentajePorDepartamento);
                    chart.write("PorcentajeDepartamentoG");
                    $("#PorcentajeDepartamentoG").show();

                },
                error: function (data) {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
            });

        });
    });

    // Make chart 2D/3D
    function setDepth() {
        if (document.getElementById("rb2").checked) {
            chart.depth3D = 20;
            chart.angle = 30;
        } else {
            chart.depth3D = 0;
            chart.angle = 0;
        }
        chart.validateNow();
    }


    function PorcentajePorRubro(event) {
        console.log(event)

        var CodVehiculo = event.item.dataContext.Codigo;
        var Rubro = event.graph.valueField
        var Empleado = event.item.category
        var color = event.graph.lineColor;
        var FechaInicioC = event.item.dataContext.FechaInicioC
        var FechaFin = event.item.dataContext.FechaFinC
        console.log(FechaInicioC)
        if (Rubro == "DESPLAZAMIENTO") {
            DetalleDesplazamiento(event);

        }
        else if (Rubro != "DESPLAZAMIENTO") {
            $("#graphica4").hide();
            $("#chartdiv1").hide();



            $.ajax({
                type: "POST",
                url: "WebService.asmx/DetalleUsoVisitasPool",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{FechaInicio:'" + FechaInicioC + "', FechaFin:'" + FechaFin + "',CodVehiculo: '" + CodVehiculo + "',Rubro: '" + Rubro + "'}",
                success: function (data) {

                    $.each(data.d, function (i, item) {
                        if (item.StrError != "0") {
                            jQuery.gritter.add({
                                title: 'Se Ha Producido Un Error!',
                                text: item.StrError,
                                class_name: 'growl-danger',
                                image: 'images/screen.png',
                                sticky: false,
                                time: ''
                            });
                            return;
                        }
                    });


                    // SERIAL CHART
                    chart = new AmCharts.AmSerialChart();

                    chart.dataProvider = data.d;
                    if (Rubro == "APAGADO") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "APAGADO_NOCTURNO") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "APAGADO_FIN") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "GENTRAC") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "GENTRAC_MOBILFIN") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "VISITAS") {
                        chart.categoryField = "Ubicacion";
                    } else if (Rubro == "VISITAS_NOCTURNO") {
                        chart.categoryField = "Ubicacion";
                    } else if (Rubro == "VISITAS_FIN_SEMANA") {
                        chart.categoryField = "Ubicacion";
                    } else if (Rubro == "TALLER") {
                        chart.categoryField = "FechaInicio";
                    }
                    chart.labelText = "[[title]]: ([[percents]]%)";
                    // this single line makes the chart a bar chart, 
                    // try to set it to false - your bars will turn to columns                
                    chart.rotate = true;
                    // the following two lines makes chart 3D
                    chart.depth3D = 20;
                    chart.angle = 30;

                    // AXES
                    // Category
                    chart.addTitle("Detalle de " + Rubro + "/Empleado: " + Empleado + "", 12);
                    var categoryAxis = chart.categoryAxis;
                    categoryAxis.gridPosition = "start";
                    categoryAxis.axisColor = "#DADADA";
                    categoryAxis.fillAlpha = 1;
                    categoryAxis.gridAlpha = 0;
                    categoryAxis.fillColor = "#FAFAFA";

                    // value
                    var valueAxis = new AmCharts.ValueAxis();
                    valueAxis.axisColor = "#DADADA";
                    valueAxis.title = "Tiempo Localización ";
                    valueAxis.gridAlpha = 0.1;
                    chart.addValueAxis(valueAxis);

                    // GRAPH
                    var graph = new AmCharts.AmGraph();
                    graph.title = "Tiempo";
                    graph.valueField = "TiempoSL";
                    graph.type = "column";

                    graph.balloonText = "<span style='font-size:14px'><b>Ubicacion:</b> [[Ubicacion]]<b>Tiempo Total:</b> [[TiempoTL]]<br><b>Fecha Inicio:</b> [[FechaInicioT]]<br><b>Fecha Fin:</b> [[FechaFinT]]";

                    graph.lineAlpha = 0;
                    graph.fillColors = "" + color + "";
                    graph.fillAlphas = 1;
                    chart.addGraph(graph);


                    chart.write("chartdiv");
                    $("#graphica5").show();
                    $("#chartdiv").show();
                    $("html,body").animate({ scrollTop: $("#destino").offset().top }, 550);
                },
                error: function (data) {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
            });

        }
    }

    function DetalleDesplazamiento(event) {
        $("#graphica4").hide();
        $("#chartdiv").hide();

        //var celdaValor = $(this).find('td(2)');

        var CodVehiculo = event.item.dataContext.Codigo;
        var Rubro = event.graph.valueField
        var Empleado = event.item.category
        var color = event.graph.lineColor;
        var FechaInicioC = event.item.dataContext.FechaInicioC
        var FechaFin = event.item.dataContext.FechaFinC

        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleDesplazamientoPool",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{FechaInicio:'" + FechaInicioC + "', FechaFin:'" + FechaFin + "',IdVehiculo: '" + CodVehiculo + "'}",
            success: function (data) {
                console.log(data.d);

                chart = new AmCharts.AmSerialChart();
                chart.addTitle("Detalle de " + Rubro + "/Empleado: " + Empleado + "", 12);
                chart.dataProvider = data.d;
                chart.categoryField = "FechaInicio";
                chart.depth3D = 20;
                chart.angle = 30;
                //                chart.dataDateFormat = "YYYY-MM-DD";
                chart.marginTop = 0;
                var categoryAxis = chart.categoryAxis;

                categoryAxis.autoGridCount = false;
                categoryAxis.gridCount = 50;
                categoryAxis.gridAlpha = 0;
                categoryAxis.gridColor = "#08088A";
                categoryAxis.axisColor = "#555555";
                categoryAxis.labelRotation = 35;


                var durationAxis = new AmCharts.ValueAxis();
                durationAxis.title = "TotalHoras";
                durationAxis.gridAlpha = 0.05;
                durationAxis.axisAlpha = 0;
                durationAxis.inside = true;
                // the following line makes this value axis to convert values to duration
                // it tells the axis what duration unit it should use. mm - minute, hh - hour...                
                durationAxis.duration = "mm";
                durationAxis.durationUnits = {
                    DD: "d. ",
                    hh: "h ",
                    mm: "min",
                    ss: ""
                };
                chart.addValueAxis(durationAxis);

                // Distance value axis 
                var distanceAxis = new AmCharts.ValueAxis();
                distanceAxis.title = "Distancia";
                distanceAxis.gridAlpha = 0;
                distanceAxis.position = "right";
                distanceAxis.inside = true;
                distanceAxis.unit = "mi";
                distanceAxis.axisAlpha = 0;
                chart.addValueAxis(distanceAxis);

                // GRAPHS
                // duration graph
                var durationGraph = new AmCharts.AmGraph();
                durationGraph.title = "TotalHoras";
                durationGraph.valueField = "TotalHoras";
                durationGraph.type = "line";
                durationGraph.valueAxis = durationAxis; // indicate which axis should be used
                durationGraph.lineColor = "#CC0000";
                durationGraph.balloonText = "[[value]]";
                durationGraph.lineThickness = 1;
                durationGraph.legendValueText = "[[value]]";
                durationGraph.bullet = "square";
                durationGraph.bulletBorderColor = "#CC0000";
                durationGraph.bulletBorderAlpha = 1;
                durationGraph.bulletBorderThickness = 1;
                chart.addGraph(durationGraph);

                // distance graph
                var distanceGraph = new AmCharts.AmGraph();
                distanceGraph.valueField = "Distancia";
                distanceGraph.title = "Distancia";
                distanceGraph.type = "column";
                distanceGraph.fillAlphas = 0.6;
                distanceGraph.valueAxis = distanceAxis; // indicate which axis should be used
                distanceGraph.balloonText = "[[value]] KM";
                distanceGraph.legendValueText = "[[value]] KM";
                distanceGraph.legendPeriodValueText = "total: [[value.sum]] KM";
                distanceGraph.lineColor = "" + color + "";
                distanceGraph.lineAlpha = 0;
                chart.addGraph(distanceGraph);

                var graph2 = new AmCharts.AmGraph();

                graph2.type = "line";
                graph2.lineColor = "#fcd202";
                graph2.valueField = "MaximaVelocidad";
                graph2.lineThickness = 3;
                graph2.bullet = "round";
                graph2.bulletBorderThickness = 3;
                graph2.bulletBorderColor = "#fcd202";
                graph2.bulletBorderAlpha = 1;
                graph2.bulletColor = "#ffffff";
                graph2.dashLengthField = "dashLengthLine";
                graph2.balloonText = "<span style='font-size:13px;'> MaximaVelocidad <b>[[MaximaVelocidad]]</b> </span><br /><span style='font-size:13px;'>VelocidadMedia <b>[[VelocidadMedia]] </b></span>";
                chart.addGraph(graph2);

                // CURSOR                
                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonDateFormat = "DD";
                chartCursor.cursorAlpha = 0;
                chart.addChartCursor(chartCursor);

                // LEGEND
                var legend = new AmCharts.AmLegend();
                legend.bulletType = "round";
                legend.equalWidths = false;
                legend.valueWidth = 120;
                legend.color = "#08088A";
                legend.useGraphSettings = true;
                chart.addLegend(legend);
                // WRITE                                
                chart.write("chartdiv1");
                $("#graphica4").show();
                $("#chartdiv1").show();
                $("html,body").animate({ scrollTop: $("#destino").offset().top }, 550);
            }

        });

    }
    function setDepth2() {
        if (document.getElementById("Radio2").checked) {
            chart.depth3D = 20;
            chart.angle = 30;
        } else {
            chart.depth3D = 0;
            chart.angle = 0;
        }
        chart.validateNow();
    }





</script>
</body>
</html>