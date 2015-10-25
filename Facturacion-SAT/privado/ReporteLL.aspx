<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteLL.aspx.vb" Inherits="privado_ReporteLL" %>


<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Reporte de LLantas | <%=datos.addKey("NameProject")%></title>

  <link rel="stylesheet" href="css/style.default.css" />
  
  <link rel="stylesheet" href="css/bootstrap-fileupload.min.css" />
  <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
  <link rel="stylesheet" href="css/jquery.tagsinput.css" />
  <link rel="stylesheet" href="css/colorpicker.css" />
  <link rel="stylesheet" href="css/dropzone.css" />
  <link rel="stylesheet" href="css/autocomplete.css" />
  <link rel="Stylesheet" href="css/jquery-ui.css"
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
  <link rel="stylesheet" href="css/colorpicker.css" />
  <style>.grids th{text-align:center}</style>

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
        <h1><span>[</span> <%=datos.addKey("NameProject")%> <span>]</span></h1>
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
      <h2><i class="fa fa-edit"></i> Llantas Por Vehiculo <span>Reporte...</span></h2>
    </div>
    
    
      <form class="form-horizontal form-bordered" runat="server" id="formulario">
     
        <div class="panel-body panel-body-nopadding">
          
            <div class="panel panel-default">
            <div class="form-group">
              <label class="col-sm-2 control-label">Flota</label>
              <div class="col-sm-4">
             <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        </div>
              <div class="col-sm-6">
             
               <%--     <div class="input-group">
                        <div class="col-sm-6">

                      <input type="button" value="Actualizar" id="BtnActualizar" class="btn btn-primary" />
                    </div>
                        <div class="col-sm-6">
                        <button type="button" class="btn btn-info" value="Resumen" id="BtnResumen" >Resumen</button>
                    </div>
                </div>
                  --%>
             
                          
                           

             
           </div>
           </div>
           </div>
           
           
           


 
        <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">

             
              
              
                
       
                <ul class="nav nav-pills nav-justified">
                  <li><a href="#tab4" data-toggle="tab" type ="hidden"><span id="destino">Resumen:</span></a></li>
                </ul>
                <div class="tab-content">
                      <div class="col-sm-12">
                         <div id="chartdiv1" style="width: 100%; height: 150px;"></div>
        
                         </div>
                    <div class="form-group">
                      
                    <div class="col-sm-12" id="chartdiv" style="width: 100%;height:380px; position:relative;" "></div>
       
                            
                
                        </div>     
                     </div> 
                 
                  <div class="tab-content">
                      <div class="form-group">
                        <div class="col-sm-12"  id="PieSubRendimiento" style="width:100%; height:380px; display:none;"></div>
                    <div class="table-responsive" style="display:none;" id="DivDet">
                       </div>
                  </div> 
              </div>       
             

                      <div class="tab-content">
                      <div class="form-group">
                        <div class="col-sm-12"  id="RenLlantaa" style="width:100%; height:380px; display:none;"></div>
                    <div class="table-responsive" style="display:none;" id="Div2">
                       </div>
                  </div> 
              </div>   
        
             </div>        
                         
                    </div>
                 
                </div><!-- tab-content -->
                <%--<ul class="pager wizard">
                    <li class="previous"><a href="javascript:void(0)">Previous</a></li>
                    <li class="next"><a href="javascript:void(0)">Next</a></li>
                  </ul>--%>
              </div><!-- #basicWizard -->
            </div><!-- panel-body -->

            
           
<%--            </form>--%>
          
          
<%--          <form class="form-horizontal form-bordered">--%>
 
                    
            </form>
            
          </div><!-- table-responsive -->
        <%--</div>--%><!-- col-md-12 -->
      <%--</div>--%><!-- row -->
    </div><!-- contentpanel -->
  <%--</div>--%><!-- mainpanel -->
</section>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script type="text/javascript" src="http://www.amcharts.com/lib/3/amcharts.js"></script>
<script type="text/javascript" src="http://www.amcharts.com/lib/3/pie.js"></script>
<script type="text/javascript" src="http://www.amcharts.com/lib/3/themes/none.js"></script>
<script src="js/amCharts/amcharts.js" type="text/javascript"></script>
<script src="js/amCharts/pie.js" type="text/javascript"></script>
    <script src="js/amcharts/pie.js" type="text/javascript"></script>
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
<script src="js/highcharts.js"></script>
<script src="js/modules/data.js"></script>
<script src="js/modules/drilldown.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".reporteLlantas").dataTable({
            aLengthMenu: [
    [25, 50, 100, 200, -1],
    [25, 50, 100, 200, "All"]
            ],
            iDisplayLength: -1
        });


        $("#BtnActualizar").click(function () {
            $(".reporteLlantas").dataTable().fnClearTable();
            MostrarVehiculos(0)
        });
        $("#DropDepartamentos").change(function () {
            ReporteTotalLLantas()

            ReporteEstadoLLantas()
            //$("html,body").animate({ scrollTop: $("#destino").offset().top }, 1500);
        });




    }); //fin document.ready






    $(document).ready(function () {

        ReporteTotalLLantas()

        ReporteEstadoLLantas()

    });


    function ReporteTotalLLantas(event) {

        $.ajax({
            type: "POST",
            url: "WebService.asmx/ResumenTotalLlantas",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento: " + $("#DropDepartamentos").val() + "}",
            success: function (data) {
                console.log(data.d);

                /*
                chart = new AmCharts.AmPieChart();

                // title of the chart


                //chart = new AmCharts.AmPieChart();
                //chart.addTitle("Resumen por marca", 16);
                //chart.dataProvider = data.d;
                //chart.titleField = "marca";
                //chart.valueField = "total";
                //chart.outlineColor = "#FFFFFF";
                //chart.outlineAlpha = 0.8;
                //chart.outlineThickness = 2;
                //chart.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";





                //

                chart1 = new AmCharts.AmSerialChart();
                chart1.addTitle("Resumen por marca", 16);
                chart1.dataProvider = data.d;
                chart1.categoryField = "marca";
                chart1.fieldId = "[[total]]";
                // the following two lines makes chart 3D
                chart1.depth3D = 20;
                chart1.angle = 30;


                // AXES
                // category
                var categoryAxis1 = chart1.categoryAxis;
                categoryAxis1.labelRotation = 35;
                categoryAxis1.dashLength = 5;
                categoryAxis1.gridPosition = "start";

                // value
                var valueAxis1 = new AmCharts.ValueAxis();
                valueAxis1.title = "marca";
                valueAxis1.dashLength = 5;
                chart1.addValueAxis(valueAxis1);

                // GRAPH            
                var graph1 = new AmCharts.AmGraph();
                graph1.valueField = "total";
                graph1.labelText = "[[Porcent]]%";
                graph1.colorField = "color";
                graph1.fieldId = "[[marca]]";

                graph1.balloonText = "<b>[[marca]]</b><br><span style='font-size:14px'><b>No. LLantas:</b>[[value]] </b><br><b>Kilometraje:</b>[[kilometraje]]<br><b>32avos Desgastados:</b>[[Desgastado]]<br><b>Rendimiento por 32avo:</b>[[Rentreinta]]<br><b>Costo:</b>[[Precio]]<br><b>Costo por kilometro:</b>[[Costoxkilometro]]</span><br><span style='font-size:14px'></span>";
                graph1.type = "column";
                graph1.lineAlpha = 0;
                graph1.fillAlphas = 1;
                chart1.addGraph(graph1);


                var durationAxis = new AmCharts.ValueAxis();
                durationAxis.title = "Rendimiento por 32avo";
                durationAxis.gridAlpha = 1500;
                durationAxis.position = "right";
                durationAxis.inside = true;
                durationAxis.unit = "GLS";
                durationAxis.axisAlpha = 1000;
                chart1.addValueAxis(durationAxis);

                var durationGraph = new AmCharts.AmGraph();
                durationGraph.title = "Rendimiento";
                durationGraph.valueField = "[[Rentreinta]]";
                durationGraph.type = "line";
                durationGraph.valueAxis = durationAxis; // indicate which axis should be used
                durationGraph.lineColor = "#FCFF04";
                durationGraph.balloonText = "<b>[[value]]</b> Galones";
                durationGraph.lineThickness = 2;
                durationGraph.legendValueText = "[[value]]";
                durationGraph.bullet = "square";
                durationGraph.bulletBorderColor = "#CC0000";
                durationGraph.legendPeriodValueText = "[[value.sum]] Gls";
                durationGraph.bulletBorderAlpha = 1;
                durationGraph.bulletBorderThickness = 1;
                chart1.addGraph(durationGraph);


                // WRITE
                chart1.write("chartdiv");
                chart1.addListener("clickGraphItem", Detalle);
                chart1.addListener("clickGraphItem", Detalle);
                */


                /////////////////////////////////////////////////////////////////////////////////

                chart2 = new AmCharts.AmSerialChart();
                chart2.dataProvider = data.d;
                chart2.categoryField = "marca";

                // sometimes we need to set margins manually
                // autoMargins should be set to false in order chart to use custom margin values
                chart2.autoMargins = false;
                chart2.marginLeft = 20;
                chart2.marginRight = 0;
                chart2.marginTop = 30;
                chart2.marginBottom = 70;
                chart2.depth3D = 25;
                chart2.angle = 30;
                // AXES
                // category
                var categoryAxis = chart2.categoryAxis;
                categoryAxis.gridAlpha = 0;
                categoryAxis.axisAlpha = 0;
                categoryAxis.labelRotation = 35;
                categoryAxis.gridPosition = "start";

                // value
                var valueAxis = new AmCharts.ValueAxis();
                //valueAxis.stackType = "100%"; // this line makes the chart 100% stacked
                valueAxis.stackType = "regular";
                valueAxis.gridAlpha = 0;
                valueAxis.axisAlpha = 0;
                valueAxis.labelsEnabled = false;
                chart2.addValueAxis(valueAxis);

                // GRAPHS
                // first graph                          
                var graph = new AmCharts.AmGraph();
                graph.title = "Resumen por marca";
                graph.labelText = "[[Porcent]]%";
                graph.balloonText = "<b>[[marca]]</b><br><span style='font-size:14px'><b>No. LLantas:</b>[[value]]([[Porcent]]%) </b><br><b>Kilometraje:</b>[[kilometraje]]<br><b>32avos Desgastados:</b>[[Desgastado]]<br><br><b>Costo:</b>[[Precio]]</span><br><span style='font-size:14px'></span>";
                graph.valueField = "total";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#D00000";
                graph.legendPeriodValueText = "[[value.sum]] Q";
                chart2.addGraph(graph);

      

                var rdkmtnAxis = new AmCharts.ValueAxis();
                rdkmtnAxis.title = "Rend 32av0";
                rdkmtnAxis.gridAlpha = 0;
                rdkmtnAxis.position = "right";
                rdkmtnAxis.inside = true;
                rdkmtnAxis.unit = "kms/32 avos";
                rdkmtnAxis.axisAlpha = 0;
                chart2.addValueAxis(rdkmtnAxis);

                var rdkmtGraph = new AmCharts.AmGraph();
                rdkmtGraph.title = "kms/32 avos";
                rdkmtGraph.valueField = "Rentreinta";
                rdkmtGraph.type = "smoothedLine";
                rdkmtGraph.valueAxis = rdkmtnAxis; // indicate which axis should be used
                rdkmtGraph.lineColor = "#1D08E2";
                rdkmtGraph.balloonText = "<b>[[value]]</b>kms/32 avos";
                rdkmtGraph.lineThickness = 2;
                rdkmtGraph.legendValueText = "[[value]]";
                rdkmtGraph.bullet = "square";
                rdkmtGraph.bulletBorderColor = "#CC0000";
                rdkmtGraph.legendPeriodValueText = "[[value.sum]] kms/32 avos";
                rdkmtGraph.bulletBorderAlpha = 1;
                rdkmtGraph.bulletBorderThickness = 1;
                chart2.addGraph(rdkmtGraph);




                var ckAxis = new AmCharts.ValueAxis();
                ckAxis.title = "";
                ckAxis.gridAlpha = 0;
                ckAxis.position = "right";
                ckAxis.inside = true;
                ckAxis.unit = "";
                ckAxis.axisAlpha = 0;
                chart2.addValueAxis(ckAxis);

                var ckGraph = new AmCharts.AmGraph();
                ckGraph.title = "Costo/Kilometro";
                ckGraph.valueField = "Costoxkilometro";
                ckGraph.type = "smoothedLine";
                ckGraph.valueAxis = ckAxis; // indicate which axis should be used
                ckGraph.lineColor = "#01A9DB";
                ckGraph.balloonText = "<b>[[value]]</b> Q/kms";
                ckGraph.lineThickness = 2;
                ckGraph.legendValueText = "[[value]]";
                ckGraph.bullet = "square";
                ckGraph.bulletBorderColor = "#CC0000";
                ckGraph.legendPeriodValueText = "[[value.sum]] Q/kms";
                ckGraph.bulletBorderAlpha = 1;
                ckGraph.bulletBorderThickness = 1;
                chart2.addGraph(ckGraph);

                // LEGEND                  
                var legend = new AmCharts.AmLegend();
                legend.borderAlpha = 0.2;
                legend.horizontalGap = 10;
                legend.autoMargins = false;
                legend.marginLeft = 20;
                legend.marginRight = 20;
                chart2.addLegend(legend);

                // WRITE                  



                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart2.addChartCursor(chartCursor);
                chart2.write("chartdiv");
                chart2.addListener("clickGraphItem", Detalle);
                chart2.addListener("clickGraphItem", Detalle);




                //////////////////////////////////////////////////////////////////////////////////


                //    // WRITE


            },
            error: function (data) { //console.log(data.responseText) 
            }
        });

    }
    function setLabelPosition() {
        if (document.getElementById("rb1").checked) {
            chart.labelRadius = 30;
            chart.labelText = "[[title]]: [[value]]";
        } else {
            chart.labelRadius = -30;
            chart.labelText = "[[percents]]%";
        }
        chart.validateNow();
    }
    function ReporteEstadoLLantas(event) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/ResumenDesgaste",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento: " + $("#DropDepartamentos").val() + "}",
            success: function (data) {

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


                chart = new AmCharts.AmSerialChart();
                chart.addTitle("Estado de desgate", 16);
                chart.dataProvider = data.d;
                chart.categoryField = "EstadoLLantas";
                chart.plotAreaBorderAlpha = 0.2;
                chart.rotate = true;


                // AXES
                // Category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.gridAlpha = 0.1;
                categoryAxis.axisAlpha = 0;
                categoryAxis.labelRotation = 35;
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
                graph.title = "Buen Estado";
                graph.labelText = "([[percents]]%)";
                graph.valueField = "BuenEstado";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.zoomable
                graph.lineColor = "#22DE0E";
                graph.balloonText = "<b><span style='color:#22DE0E'>[[title]]</b></span><br><span style='font-size:14px'><b>No. LLantas: </b>[[BuenEstado]]([[percents]]%) </span>";



                chart.depth3D = 20;
                chart.angle = 30;



                chart.addGraph(graph);
                //Gentrac Fin de semana
                var graph = new AmCharts.AmGraph();
                graph.title = "Regular Estado";
                graph.labelText = "([[percents]]%)";
                graph.valueField = "RegularEstado";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#FF8000";
                graph.balloonText = "<b><span style='color:#FF8000'>[[title]]</b></span><br><span style='font-size:14px'><b>No. LLantas: </b>[[RegularEstado]]([[percents]]%) </span>";


                chart.depth3D = 20;
                chart.angle = 30;
                chart.addGraph(graph);

                // Visitas                         
                graph = new AmCharts.AmGraph();
                graph.title = "Mal Estado";
                graph.labelText = "([[percents]]%)";
                graph.valueField = "MalEstado";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#FF0000";

                graph.balloonText = "<b><span style='color:#FF0000'>[[title]]</b></span><br><span style='font-size:14px'><b>No. LLantas: </b>[[MalEstado]]([[percents]]%) </span>";

              

                var graph = new AmCharts.AmGraph();
                graph.title = "Resumen por marca";
                graph.labelText = "[[Porcent]]%";
                graph.balloonText = "<b>[[marca]]</b><br><span style='font-size:14px'><b>No. LLantas:</b>[[value]]([[Porcent]]%) </b><br><b>Kilometraje:</b>[[kilometraje]]<br><b>32avos Desgastados:</b>[[Desgastado]]<br><br><b>Costo:</b>[[Precio]]</span><br><span style='font-size:14px'></span>";
                graph.valueField = "total";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#D00000";
                graph.legendPeriodValueText = "[[value.sum]] Q";
                chart.addGraph(graph);



              



                chart.depth3D = 20;
                chart.angle = 30;
                chart.addGraph(graph);



                // WRITE


                //chart.addListener("clickSlice", PorcentajePorDepartamento);
                chart.write("chartdiv1");
                $("#chartdiv1").show();

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


    function Detalle(event) {
        console.log(event);
        var codigo = event.item.dataContext.codigo;
        console.log(codigo);
        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleLlantasTotal",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{codigollanta:'" + codigo + "',Departamento: " + $("#DropDepartamentos").val() + "}",
            success: function (data) {
                console.log(data.d);
                $.each(data.d, function (i, item) {
                    if (item.StrError != "0") {
                        //console.log(item)
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


                //chart1 = new AmCharts.AmPieChart();

                //// title of the chart
                //chart1.addTitle("Detalle Llantas", 16);

                //chart1.dataProvider = data.d;
                //chart1.titleField = "idllanta";
                //chart1.valueField = "cantidad";
                //chart1.sequencedAnimation = true;
                //chart1.startEffect = "elastic";
                //chart1.innerRadius = "30%";
                //chart1.startDuration = 2;
                //chart1.labelRadius = 15;
                //chart1.pullOutOnlyOne = true;
                //chart1.labelText = "";
                //chart1.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[cantidad]]</b> ([[percents]]%)</span>";
                //// the following two lines makes the chart 3D
                //chart1.depth3D = 10;
                //chart1.angle = 15;

                //// LEGEND                  
                //var legend = new AmCharts.AmLegend();
                //legend.borderAlpha = 0.2;
                //legend.horizontalGap = 2;
                //chart1.addLegend(legend);
                // WRITE                                 


                ///////////////////////////

                chart2 = new AmCharts.AmSerialChart();
                chart2.dataProvider = data.d;
                chart2.categoryField = "idllanta";

                // sometimes we need to set margins manually
                // autoMargins should be set to false in order chart to use custom margin values
                chart2.autoMargins = false;
                chart2.marginLeft = 50;
                chart2.marginRight = 0;
                chart2.marginTop = 30;
                chart2.marginBottom = 90;
                chart2.depth3D = 25;
                chart2.angle = 30;
                // AXES
                // category
                var categoryAxis = chart2.categoryAxis;
                categoryAxis.gridAlpha = 0;
                categoryAxis.axisAlpha = 0;
                categoryAxis.labelRotation = 35;
                categoryAxis.gridPosition = "start";

                // value
                var valueAxis = new AmCharts.ValueAxis();
                //valueAxis.stackType = "100%"; // this line makes the chart 100% stacked
                valueAxis.stackType = "regular";
                valueAxis.gridAlpha = 0;
                valueAxis.axisAlpha = 0;
                valueAxis.labelsEnabled = true;
                chart2.addValueAxis(valueAxis);

                // GRAPHS
                // first graph                          
                var graph = new AmCharts.AmGraph();
                graph.title = "Resumen por marca";
                graph.labelText = "[[Porcent]]%";
                graph.balloonText = "<b>[[marca]]</b><br><span style='font-size:14px'><b>No. LLantas:</b>[[value]]([[Porcent]]%) </b><br><b>Kilometraje:</b>[[kilometraje]]<br><b>32avos Desgastados:</b>[[Desgastado]]<br><br><b>Costo:</b>[[Precio]]</span><br><span style='font-size:14px'></span>";
                graph.valueField = "cantidad";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#D00000";
                graph.legendPeriodValueText = "[[value.sum]] ";
                chart2.addGraph(graph);

                // LEGEND                  
                var legend = new AmCharts.AmLegend();
                legend.borderAlpha = 0.2;
                legend.horizontalGap = 10;
                legend.autoMargins = false;
                legend.marginLeft = 20;
                legend.marginRight = 20;
                chart2.addLegend(legend);




                var rdkmtnAxis = new AmCharts.ValueAxis();
                rdkmtnAxis.title = "Rend 32av0";
                rdkmtnAxis.gridAlpha = 0;
                rdkmtnAxis.position = "right";
                rdkmtnAxis.inside = true;
                rdkmtnAxis.unit = "kms/32 avos";
                rdkmtnAxis.axisAlpha = 0;
                chart2.addValueAxis(rdkmtnAxis);

                var rdkmtGraph = new AmCharts.AmGraph();
                rdkmtGraph.title = "kms/32 avos";
                rdkmtGraph.valueField = "Rentreinta";
                rdkmtGraph.type = "smoothedLine";
                rdkmtGraph.valueAxis = rdkmtnAxis; // indicate which axis should be used
                rdkmtGraph.lineColor = "#1D08E2";
                rdkmtGraph.balloonText = "<b>[[value]]</b>kms/32 avos";
                rdkmtGraph.lineThickness = 2;
                rdkmtGraph.legendValueText = "[[value]]";
                rdkmtGraph.bullet = "square";
                rdkmtGraph.bulletBorderColor = "#CC0000";
                rdkmtGraph.legendPeriodValueText = "[[value.sum]] kms/32 avos";
                rdkmtGraph.bulletBorderAlpha = 1;
                rdkmtGraph.bulletBorderThickness = 1;
                chart2.addGraph(rdkmtGraph);




                var ckAxis = new AmCharts.ValueAxis();
                ckAxis.title = "";
                ckAxis.gridAlpha = 0;
                ckAxis.position = "right";
                ckAxis.inside = true;
                ckAxis.unit = "";
                ckAxis.axisAlpha = 0;
                chart2.addValueAxis(ckAxis);

                var ckGraph = new AmCharts.AmGraph();
                ckGraph.title = "Costo/Kilometro";
                ckGraph.valueField = "Costoxkilometro";
                ckGraph.type = "smoothedLine";
                ckGraph.valueAxis = ckAxis; // indicate which axis should be used
                ckGraph.lineColor = "#01A9DB";
                ckGraph.balloonText = "<b>[[value]]</b> Q/kms";
                ckGraph.lineThickness = 2;
                ckGraph.legendValueText = "[[value]]";
                ckGraph.bullet = "square";
                ckGraph.bulletBorderColor = "#CC0000";
                ckGraph.legendPeriodValueText = "[[value.sum]] Q/kms";
                ckGraph.bulletBorderAlpha = 1;
                ckGraph.bulletBorderThickness = 1;
                chart2.addGraph(ckGraph);

                // LEGEND                  
                var legend = new AmCharts.AmLegend();
                legend.borderAlpha = 0.2;
                legend.horizontalGap = 10;
                legend.autoMargins = false;
                legend.marginLeft = 20;
                legend.marginRight = 20;
                chart2.addLegend(legend);
                // WRITE                  



                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart2.addChartCursor(chartCursor);
                //chart2.write("chartdiv");
                //chart2.addListener("clickGraphItem", Detalle);
                //chart2.addListener("clickGraphItem", Detalle);

                //////////////////////////////////





                //                var legend = new AmCharts.AmLegend();
                //                legend.borderAlpha = 0.2;
                //                legend.horizontalGap = 10;
                //                chart1.addLegend(legend);
                // WRITE                   
                chart2.addListener("clickGraphItem", RenLLanta);
                chart2.addListener("clickGraphItem", RenLLanta);
                chart2.write("PieSubRendimiento");
                $("#PieSubRendimiento").show();






            },
            error: function (data) { //console.log(data.responseText) 
            }
        });

    }


    function RenLLanta(event) {
        console.log(event);
        var medida = event.item.dataContext.idllanta;
        console.log(medida);
        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleLlantasUnidad",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{codigollanta:'" + medida + "',Departamento: " + $("#DropDepartamentos").val() + "}",
            success: function (data) {
                console.log(data.d);
                $.each(data.d, function (i, item) {
                    if (item.StrError != "0") {
                        //console.log(item)
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


                //chart1 = new AmCharts.AmPieChart();

                //// title of the chart
                //chart1.addTitle("Detalle Llantas", 16);

                //chart1.dataProvider = data.d;
                //chart1.titleField = "idllanta";
                //chart1.valueField = "cantidad";
                //chart1.sequencedAnimation = true;
                //chart1.startEffect = "elastic";
                //chart1.innerRadius = "30%";
                //chart1.startDuration = 2;
                //chart1.labelRadius = 15;
                //chart1.pullOutOnlyOne = true;
                //chart1.labelText = "";
                //chart1.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[cantidad]]</b> ([[percents]]%)</span>";
                //// the following two lines makes the chart 3D
                //chart1.depth3D = 10;
                //chart1.angle = 15;

                //// LEGEND                  
                //var legend = new AmCharts.AmLegend();
                //legend.borderAlpha = 0.2;
                //legend.horizontalGap = 2;
                //chart1.addLegend(legend);
                // WRITE                                 


                ///////////////////////////

                chart2 = new AmCharts.AmSerialChart();
                chart2.dataProvider = data.d;
                chart2.categoryField = "Vehiculo";

                // sometimes we need to set margins manually
                // autoMargins should be set to false in order chart to use custom margin values
                chart2.autoMargins = false;
                chart2.marginLeft = 50;
                chart2.marginRight = 0;
                chart2.marginTop = 30;
                chart2.marginBottom = 90;
                chart2.depth3D = 25;
                chart2.angle = 30;
                // AXES
                // category
                var categoryAxis = chart2.categoryAxis;
                categoryAxis.gridAlpha = 0;
                categoryAxis.axisAlpha = 0;
                categoryAxis.labelRotation = 35;
                categoryAxis.gridPosition = "start";

                // value
                var valueAxis = new AmCharts.ValueAxis();
                //valueAxis.stackType = "100%"; // this line makes the chart 100% stacked
                valueAxis.stackType = "regular";
                valueAxis.gridAlpha = 0;
                valueAxis.axisAlpha = 0;
                valueAxis.labelsEnabled = true;
                chart2.addValueAxis(valueAxis);

                // GRAPHS
                // first graph                          
                var graph = new AmCharts.AmGraph();
                graph.title = "Resumen por marca";
                graph.labelText = "[[Porcent]]%";
                graph.balloonText = "<b>[[marca]]</b><br><span style='font-size:14px'><b>Medida:</b>[[idllanta]]<br><b>No. LLantas:</b>[[value]]([[Porcent]]%) </b><br><b>Kilometraje:</b>[[kilometraje]]<br><b>32avos Desgastados:</b>[[Desgastado]]<br><b>Costo:</b>[[Precio]]</span><br><span style='font-size:14px'></span>";
                graph.valueField = "cantidad";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#D00000";
                graph.legendPeriodValueText = "[[value.sum]] ";
                chart2.addGraph(graph);

                // LEGEND                  
                var legend = new AmCharts.AmLegend();
                legend.borderAlpha = 0.2;
                legend.horizontalGap = 10;
                legend.autoMargins = false;
                legend.marginLeft = 20;
                legend.marginRight = 20;
                chart2.addLegend(legend);




                var rdkmtnAxis = new AmCharts.ValueAxis();
                rdkmtnAxis.title = "Rend 32av0";
                rdkmtnAxis.gridAlpha = 0;
                rdkmtnAxis.position = "right";
                rdkmtnAxis.inside = true;
                rdkmtnAxis.unit = "kms/32 avos";
                rdkmtnAxis.axisAlpha = 0;
                chart2.addValueAxis(rdkmtnAxis);

                var rdkmtGraph = new AmCharts.AmGraph();
                rdkmtGraph.title = "kms/32 avos";
                rdkmtGraph.valueField = "Rentreinta";
                rdkmtGraph.type = "smoothedLine";
                rdkmtGraph.valueAxis = rdkmtnAxis; // indicate which axis should be used
                rdkmtGraph.lineColor = "#1D08E2";
                rdkmtGraph.balloonText = "<b>[[value]]</b>kms/32 avos";
                rdkmtGraph.lineThickness = 2;
                rdkmtGraph.legendValueText = "[[value]]";
                rdkmtGraph.bullet = "square";
                rdkmtGraph.bulletBorderColor = "#CC0000";
                rdkmtGraph.legendPeriodValueText = "[[value.sum]] kms/32 avos";
                rdkmtGraph.bulletBorderAlpha = 1;
                rdkmtGraph.bulletBorderThickness = 1;
                chart2.addGraph(rdkmtGraph);




                var ckAxis = new AmCharts.ValueAxis();
                ckAxis.title = "";
                ckAxis.gridAlpha = 0;
                ckAxis.position = "right";
                ckAxis.inside = true;
                ckAxis.unit = "";
                ckAxis.axisAlpha = 0;
                chart2.addValueAxis(ckAxis);

                var ckGraph = new AmCharts.AmGraph();
                ckGraph.title = "Costo/Kilometro";
                ckGraph.valueField = "Costoxkilometro";
                ckGraph.type = "smoothedLine";
                ckGraph.valueAxis = ckAxis; // indicate which axis should be used
                ckGraph.lineColor = "#01A9DB";
                ckGraph.balloonText = "<b>[[value]]</b> Q/kms";
                ckGraph.lineThickness = 2;
                ckGraph.legendValueText = "[[value]]";
                ckGraph.bullet = "square";
                ckGraph.bulletBorderColor = "#CC0000";
                ckGraph.legendPeriodValueText = "[[value.sum]] Q/kms";
                ckGraph.bulletBorderAlpha = 1;
                ckGraph.bulletBorderThickness = 1;
                chart2.addGraph(ckGraph);

                // LEGEND                  
                var legend = new AmCharts.AmLegend();
                legend.borderAlpha = 0.2;
                legend.horizontalGap = 10;
                legend.autoMargins = false;
                legend.marginLeft = 20;
                legend.marginRight = 20;
                chart2.addLegend(legend);
                // WRITE                  



                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart2.addChartCursor(chartCursor);
                //chart2.write("chartdiv");
                //chart2.addListener("clickGraphItem", Detalle);
                //chart2.addListener("clickGraphItem", Detalle);

                //////////////////////////////////





                //                var legend = new AmCharts.AmLegend();
                //                legend.borderAlpha = 0.2;
                //                legend.horizontalGap = 10;
                //                chart1.addLegend(legend);
                // WRITE                   
                chart2.write("RenLlantaa");
                $("#RenLlantaa").show();






            },
            error: function (data) { //console.log(data.responseText) 
            }
        });

    }


    function ajustar(tam, num) {
        if (num.toString().length <= tam) return ajustar(tam, '0' + num)
        else return num;
    }

    $(document).ready(function () {

        $(".reporteLlantas tbody").on("click", ".BtnLlanta", function () {
            var id = this.id;



            $(".TablaMovimientosll").dataTable().fnClearTable();
            $.ajax({
                type: "POST",
                url: "WebService.asmx/DetalleLlantasGenerales",
                data: "{ 'idLlanta': " + id + " }",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $.each(data.d, function (index, item) {

                        $("#LblCodigo").text(item.idcodigo);
                        $("#LblDesgaste").text(item.desgaste);
                        $("#LblFecha").text(item.fecha);
                        $("#LblKilometraje").text(item.kilometraje);
                        $("#Lblrenkp").text(item.renkp);
                        $("#LblRenXTreinta").text(item.RendXtreinta);



                    });
                },
                error: function (data) {
                    console.log(data);
                }

            });

        });

    });





        </script>
</body>
</html>