<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteUtilizacionFlota.aspx.vb" Inherits="privado_ReporteUtilizacionFlota" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/png" />
  <title>Porcentaje Utilización | Monitoreo</title>
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
      <h2><i class="fa fa-th-large"></i> Porcentaje Flota <span>Reportes</span></h2>
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
              <label class="col-sm-2 control-label">Flota</label>
              <div class="col-sm-4">
             <asp:DropDownList ID="DropDepartamentosFlota" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        </div>
                          <label class="col-sm-2 control-label">Tipo de Consulta</label>
              <div class="col-sm-4">

                        <asp:DropDownList ID="DropTipoConsulta" runat="server">
                            <asp:ListItem Selected="True">Nombre</asp:ListItem>
                            <asp:ListItem Value="Codigo">Vehiculo</asp:ListItem>
                        </asp:DropDownList>

                        </div>

                        </div>
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
                        <label class="col-sm-2 control-label">No. Datos en Visitas</label>
                        <div class="col-sm-4">
                                 
                       <select id="DropRango" name="DropCantidad" style="width:100%; height: 40px;">
                        <option value="10">10 <selected></option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="75">75</option>
     
                     </select>
                        </div>
                        <div class="col-sm-4">
                             </div>
                        <div class="col-sm-2">
                           <input type="button" value="Actualizar" id="BtnActualizar" class="btn btn-primary" />
                            
                             


                        </div>
                        <div class="col-sm-12">
                         <div id="parametros" style="width: 100%; height: 150px;"></div>
        
                         </div>


                        
                </div>
            </form>
            </div>
            <div class="panel-body panel-body-nopadding">

                        <div class="col-sm-12" id="graphica">
                            <div id="PorcentajeDepartamento" style="width:100%; height:2200px; position:relative; top: 0px; left: 0px;" ></div>
                             <div style="margin-left:40px;">
                        <input type="radio"  name="group" id="rb1" onclick="setDepth()">2D
                        <input type="radio" checked="checked" name="group" id="rb2" onclick="setDepth()">3D
		</div>
                        </div>    
                        <div class="col-sm-12" id="graphica1" style="display:none;">
                            <div id="PorcentajePorDepartamento" style="width:100%; height:380px; position:relative;" ></div>
                        </div>                 
                  <%--<div id ="barra" style="width:100%; height:380px; position:relative;""></div>--%>
                

             <div><a data-toggle="tab" type ="hidden"><span id="destino">Resumen:</a></div>
                  <div class="col-sm-12" id="graphica2" style="display:none;">
                 
                        </div>
                <div class="col-sm-12" id="chartdiv1" style="width: 100%; height:600px; display:none;"></div>
                      </div>  
                        <div class="col-sm-12" id="graphica3" style="display:none;">

                <div id="chartdiv" style="width: 100%; height: 400px;"></div> 

                            </div>  
               
                </div> 



            
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-md-12 -->
      </div><!-- row -->
      <div class="modal fade DetalleT" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title"><span style="display:none" id="LblModificar">Modificaion</span><span style="display:none" id="LblCrear">Creacion</span> de  Detalle de Ubicacion: <i><label id="Label1"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="Hidden1" />
            <div class="form-group">
                            <table class="table table-bordered table-striped TablaDetalle">
    <thead>
    	<tr>
        	<th>Vehiculo</th>
            <th>FechaInicio</th>
            <th>FechaFin</th>
            <th>Ubicacion</th>
            <th>Tiempo Total</th>
           
        </tr>
    </thead>
           </table>
            </div>
           

  </div>
</div>
      </div>
    </div>
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
    var chart;

    var chartData = [
        {
            "year": 2003,
            "europe": 2.5,
            "namerica": 2.5,
            "asia": 2.1,
            "lamerica": 0.3,
            "meast": 0.2,
            "africa": 0.1
        },

    ];
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

        //var altura = $("div").offset().top;

        //$(window).scroll(function () {

        //    if ($(window).scrollTop() >= altura) {

        //        $("#barra").css("margin-top", "0");
        //        $("#barra").css("position", "fixed");

        //    } else {

        //        $("#barra").css("margin-top", "100px");
        //        $("#barra").css("position", "static");

        //    }

        //});


    });
</script>
<script type="text/javascript">
    $(document).ready(function () {

        //crear gif y ocultarlo
        $loading = $('<img src="images/loading.gif" id="loading" />').hide();

        //agregarlo al body
        $('body').append($loading);
        $("#BtnActualizar").click(function () {

            $_elem = $(this);

            PorcentajeDepartamento();
            ResumenDeparamento()
        });
    });

    //var CodigoV;
    function PorcentajeDepartamento(event) {
        $("#PorcentajePorDepartamento").hide();
        $("#graphica2").hide();
        $("#chartdiv1").hide();
        $("#graphica3").hide();
        $("#chartdiv0").hide();
        if ($("#TxtFechaInicio").val() != "" && $("#TxtFechaFinal").val() != "") {
            $loading.show() //mostramos el gif
            $.ajax({
                type: "POST",
                url: "WebService.asmx/UtilizacionFlota",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "',Departamento: " + $("#DropDepartamentosFlota").val() + "}",

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
                    $loading.hide();
                    //CodigoV= item.Codigo;
                    // SERIALL CHART
                    var categoria;
                    if ($("#DropTipoConsulta").val() == "Nombre") {
                        categoria = "nombre"
                    } else {
                        categoria = "Codigo"
                    }


                    console.log($("#DropTipoConsulta").val())


                    chart = new AmCharts.AmSerialChart();
                    chart.dataProvider = data.d;
                    chart.categoryField = categoria;
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
                    //valueAxis.stackType = "regular";
                    valueAxis.stackType = "100%"
                    valueAxis.gridAlpha = 0.1;
                    valueAxis.axisAlpha = 0;

                    chart.addValueAxis(valueAxis);

                    // GRAPHS
                    // firstgraph 
                    var graph = new AmCharts.AmGraph();
                    graph.title = "Gentrac_Mobil";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "Gentrac_Mobil";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
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
                    graph.valueField = "Gentrac_MobilFin";
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
                    graph.valueField = "Visitas";
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
                    chart.addListener("clickGraphItem", $("#DropRango"));

                    // Visitas Nocturno                             
                    graph = new AmCharts.AmGraph();
                    graph.title = "visitas Nocturno";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "VisitasNocturno";
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
                    graph.valueField = "VisitasFinS";
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
                    graph.valueField = "Apagado";
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
                    graph.title = "apagado nocturno";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "ApagadoNocturno";
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
                    graph.valueField = "ApagadoFinS";
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
                    graph.valueField = "Desplazamiento";
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
                    graph.valueField = "Taller";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.color = "#FFFFFF";
                    graph.lineColor = "#9A6C09";
                    graph.balloonText = "<b><span style='color:#9A6C09'>[[title]]</b></span><br><span style='font-size:14px'><b>Vehiculo: </b>[[Codigo]] <br><b>Tiempo: </b> [[HoraT]]([[percents]]%)</span>";
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
                    chart.write("PorcentajeDepartamento");
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


    $("#DropRango").change(function (event) {


        console.log(event);

    });
    function PorcentajePorRubro(event) {
        console.log(event)

        var CodVehiculo = event.item.dataContext.Codigo;
        var Rubro = event.graph.valueField
        var Empleado = event.item.category
        var color = event.graph.lineColor;
        if (Rubro == "Desplazamiento") {
            DetalleDesplazamiento(event);

        }
        else if (Rubro != "Desplazamiento") {
            $("#graphica3").hide();
            $("#chartdiv").hide();



            $.ajax({
                type: "POST",
                url: "WebService.asmx/DetalleUsoVisitas",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "',CodVehiculo: '" + CodVehiculo + "',Rubro: '" + Rubro + "',Cantidad:" + $("#DropRango").val() + "}",
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
                    if (Rubro == "Apagado") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "ApagadoNocturno") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "ApagadoFinS") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "Gentrac_Mobil") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "Gentrac_MobilFin") {
                        chart.categoryField = "FechaInicio";
                    } else if (Rubro == "Visitas") {
                        chart.categoryField = "Ubicacion";
                    } else if (Rubro == "VisitasNocturno") {
                        chart.categoryField = "Ubicacion";
                    } else if (Rubro == "VisitasFinS") {
                        chart.categoryField = "Ubicacion";
                    } else if (Rubro == "Taller") {
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
                    graph.balloonText = "<span style='font-size:14px'><b>Ubicacion:</b> [[Ubicacion]]<b>Tiempo Total:</b> [[TiempoTL]]<b>Fecha:</b> [[FechaIniciod]]";

                    graph.lineAlpha = 0;
                    graph.fillColors = "" + color + "";
                    graph.fillAlphas = 1;
                    chart.addGraph(graph);


                    chart.write("chartdiv1");
                    chart.addListener("clickGraphItem", DetalleTiempos);
                    $("#graphica2").show();
                    $("#chartdiv1").show();
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
        $("#graphica2").hide();
        $("#chartdiv1").hide();

        //var celdaValor = $(this).find('td(2)');

        var CodVehiculo = event.item.dataContext.Codigo;
        var color = event.graph.lineColor;
        //var FechaEntregaa;

        var CodVehiculo = event.item.dataContext.Codigo;
        var Rubro = event.graph.valueField
        var Empleado = event.item.category
        //console.log(idpedido);


        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleDesplazamiento",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "',IdVehiculo: '" + CodVehiculo + "'}",
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
                chart.write("chartdiv");
                $("#graphica3").show();
                $("#chartdiv").show();
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

    function ResumenDeparamento(event) {

        if ($("#TxtFechaInicio").val() != "" && $("#TxtFechaFinal").val() != "") {
            $loading.show() //mostramos el gif
            $.ajax({
                type: "POST",
                url: "WebService.asmx/UtilizacionFlotaTOTAL",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "',Departamento: " + $("#DropDepartamentosFlota").val() + "}",
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
                    $loading.hide();
                    //CodigoV= item.Codigo;
                    // SERIALL CHART

                    chart = new AmCharts.AmSerialChart();
                    chart.dataProvider = data.d;
                    chart.categoryField = "Departamento";
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


                    graph.balloonText = "<b><span style='color:#EEFE17'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b>[[HoraG]]([[percents]]%) </span>";

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

                    graph.balloonText = "<b><span style='color:#FFEF00'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b>[[HoraGF]]([[percents]]%)</span>";

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

                    graph.balloonText = "<b><span style='color:#190986'>[[title]]</b></span><br><span style='font-size:14px'> <b>Tiempo: </b>[[HoraV]]([[percents]]%)</span>";
                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);


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

                    graph.balloonText = "<b><span style='color:#190986'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b>[[HoraVN]]([[percents]]%)</span>";
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

                    graph.balloonText = "<b><span style='color:#190986'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b>[[HoraVF]]([[percents]]%)</span>";
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
                    graph.balloonText = "<b><span style='color:#FF0008'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b> [[HoraA]]([[percents]]%) </span>";

                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);

                    // apagado nocturno
                    graph = new AmCharts.AmGraph();
                    graph.title = "apagado nocturno";
                    graph.labelText = "([[percents]]%)";
                    graph.valueField = "APAGADO_NOCTURNO";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    graph.lineColor = "#D53232";
                    graph.balloonText = "<b><span style='color:#FF0008'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b> [[HoraAN]]([[percents]]%)</span>";

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
                    graph.balloonText = "<b><span style='color:#FF0008'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b> [[HoraAF]]([[percents]]%) </span>";

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
                    graph.balloonText = "<b><span style='color:#29A838'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b>[[HoraD]]([[percents]]%)<br><b>Kilometros: </b>[[KILOMETROS]]</span>";
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
                    graph.color = "#FFFFFF";
                    graph.lineColor = "#9A6C09";
                    graph.balloonText = "<b><span style='color:#9A6C09'>[[title]]</b></span><br><span style='font-size:14px'><b>Tiempo: </b> [[HoraT]]([[percents]]%)</span>";
                    chart.depth3D = 20;
                    chart.angle = 30;
                    chart.addGraph(graph);

                    // fifth graph 




                    // WRITE


                    //chart.addListener("clickSlice", PorcentajePorDepartamento);
                    chart.write("parametros");
                    $("#parametros").show();

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
    };


    function DetalleTiempos(event) {

        console.log(event);

        var Vehiculo = event.item.dataContext.vehiculo;
        $("#Label1").text = event.item.category;
        var Rubro = event.item.dataContext.Rubros;
        var ubicacion = event.item.dataContext.Ubicacion;
        var FechaInicioC = event.item.dataContext.FechaIniciod;
        var color = event.graph.lineColor;
        if (Rubro == "Desplazamiento") {
            DetalleDesplazamiento(event);

        }
        else if (Rubro != "Desplazamiento") {
            $("#graphica3").hide();
            $("#chartdiv").hide();

            $(".TablaDetalle").dataTable().fnClearTable();

            $.ajax({
                type: "POST",
                url: "WebService.asmx/DetalleUsoVisitasDs",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "',CodVehiculo: '" + Vehiculo + "',Ubicacion: '" + ubicacion + "',Rubro: '" + Rubro + "',FechaInicioC: '" + FechaInicioC + "',Cantidad:" + $("#DropRango").val() + "}",
                success: function (data) {

                    $.each(data.d, function (index, item) {

                        $(".TablaDetalle").dataTable().fnAddData([
                      item.vehiculo,
                      item.FechaInicioT,
                      item.FechaFinT,
                      item.Ubicacion,
                      item.TiempoTL,

                        ]);


                    });
                    $('.DetalleT').modal('toggle');

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

</script>
    <style type="text/css">
    <!--
    #loading{
        position:  absolute;
        left: 83%;
        top: 44.5%;
    }

                   
        </style>
</body>
</html>