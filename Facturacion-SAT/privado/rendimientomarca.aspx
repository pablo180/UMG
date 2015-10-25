<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rendimientomarca.aspx.vb" Inherits="privado_rendimientomarca" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/png" />
  <title>Rendimiento Vehiculo | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/amCharts.css" rel="stylesheet" type="text/css" />
  <link href="css/jquery.datatables.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
  <link href="css/select2.css" rel="stylesheet" />
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
      <h2><i class="fa fa-th-large"></i> Rendimiento Vehiculo <span>Reportes</span></h2>
    </div>
    <div class="contentpanel">
      <div class="row">
        <div class="col-md-12">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title">Filtros:</h4>
              <form runat="Server" id="filtro">
                <div class="form-group" id="filtroGrafica">
                      <label class="col-sm-2">Departamento:</label>
                    <div class="col-sm-2">
                       <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <label class="col-sm-2">Fecha Inicial:</label>
                        <div class="col-sm-2">
                           <input type="text" id="TxtFechaInicio" ReadOnly="true"  class="form-control fecha" />
                        </div>
                    <label class="col-sm-2">Fecha Final:</label>
                        <div class="col-sm-2">
                           <input type="text" id="TxtFechaFinal" ReadOnly="true" class="form-control fecha" />
                        </div>
                </div>
                   <div class="form-group" id="Div4">
                      
                     <label class="col-sm-4"></label>
                    <label class="col-sm-2">Del Modelo:</label>
                        <div class="col-sm-2">
                           <asp:DropDownList ID="DropAIM" runat="server" CssClass="form-control"></asp:DropDownList>

                         
                        </div>
                    <label class="col-sm-2">Al Modelo:</label>
                        <div class="col-sm-2">
                              <asp:DropDownList ID="DropAFM" runat="server" CssClass="form-control"></asp:DropDownList>
                   
                        </div>
                </div>
            </form>
            </div>
            <div class="panel-body panel-body-nopadding">
              <!-- BASIC WIZARD -->
              <div id="basicWizard" class="basic-wizard">
                <div class="tab-content">
                    <div class="col-sm-12" id="Div2">
                        <h3><label id="LblTotalFlota" style="display:none;"></label></h3>
                    </div>
                        <div class="col-sm-12" id="graphica">
                            <div id="GastosMensuales" style="width:100%; height:380px; position:relative;" ></div>
                        </div>
                        <div class="col-sm-12" id="DivMarca" style="display:none;">
                            
                        </div>
                         <div class="col-sm-12" id="MarcaLineaModelo">
                            <div id="MarcaLineaModeloGraphic" style="width:100%; height:380px; position:relative;" ></div>
                        </div>     
                     <div class="col-sm-12" id="Div1">
                            <div id="ModeloGraphic" style="width:100%; height:380px; position:relative;" ></div>
                        </div>  

                    <div class="col-sm-12" id="Div3">
                            <div id="VehiculoGraphic" style="width:100%; height:380px; position:relative;" ></div>
                        </div>  
                        <div class="col-sm-6" id="PieRendimiento" style="width:500px; height:380px; display:none;"></div>
                        <div class="col-sm-6"  id="PieSubRendimiento" style="width:500px; height:380px; display:none;"></div>
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
                 
                </div><!-- tab-content -->
                <%--<ul class="pager wizard">
                    <li class="previous"><a href="javascript:void(0)">Previous</a></li>
                    <li class="next"><a href="javascript:void(0)">Next</a></li>
                  </ul>--%>
              </div><!-- #basicWizard -->
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
<script src="js/select2.min.js"></script>
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
        $("#DDLTipoReporte").change(function () {
            var tipo = parseInt($("#DDLTipoReporte").val());
            switch (tipo) {
                case 1:
                    $("#filtroGrafica").show("slow");
                    $("#graphica").show("slow");
                    $("#tableDetalle_wrapper").show("slow");
                    $("#DetalleFacturacion_wrapper").hide("slow");
                    $("#filtroLista").hide("slow");
                    $("#PieRendimiento").hide("slow");
                    $("#PieSubRendimiento").hide("slow");
                    $("#DivDetalle").hide("slow");
                    Anual();
                    break;
                case 2:
                    Unidades();
                    bindFechas();
                    $("#filtroLista").show("slow");
                    $("#DivDetalle").show("slow");
                    $("#DetalleFacturacion_wrapper").show("slow");
                    $("#filtroGrafica").hide("slow");
                    $("#tableDetalle_wrapper").hide("slow");
                    $("#PieRendimiento").hide("slow");
                    $("#PieSubRendimiento").hide("slow");
                    $("#graphica").hide("slow");
                    llenarDetalle();
                    break;
            }
        });
        jQuery('#table2').dataTable({
            "sPaginationType": "full_numbers"
        });
        jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
        // Basic Wizard
        jQuery('#basicWizard').bootstrapWizard();

        // Progress Wizard
        $('#progressWizard').bootstrapWizard({
            'nextSelector': '.next',
            'previousSelector': '.previous',
            onNext: function (tab, navigation, index) {
                var $total = navigation.find('li').length;
                var $current = index + 1;
                var $percent = ($current / $total) * 100;
                jQuery('#progressWizard').find('.progress-bar').css('width', $percent + '%');
            },
            onPrevious: function (tab, navigation, index) {
                var $total = navigation.find('li').length;
                var $current = index + 1;
                var $percent = ($current / $total) * 100;
                jQuery('#progressWizard').find('.progress-bar').css('width', $percent + '%');
            },
            onTabShow: function (tab, navigation, index) {
                var $total = navigation.find('li').length;
                var $current = index + 1;
                var $percent = ($current / $total) * 100;
                jQuery('#progressWizard').find('.progress-bar').css('width', $percent + '%');
            }
        });

        // Disabled Tab Click Wizard
        jQuery('#disabledTabWizard').bootstrapWizard({
            tabClass: 'nav nav-pills nav-justified nav-disabled-click',
            onTabClick: function (tab, navigation, index) {
                return false;
            }
        });

        // With Form Validation Wizard
        var $validator = jQuery("#firstForm").validate({
            highlight: function (element) {
                jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
            },
            success: function (element) {
                jQuery(element).closest('.form-group').removeClass('has-error');
            }
        });

        jQuery('#validationWizard').bootstrapWizard({
            tabClass: 'nav nav-pills nav-justified nav-disabled-click',
            onTabClick: function (tab, navigation, index) {
                return false;
            },
            onNext: function (tab, navigation, index) {
                var $valid = jQuery('#firstForm').valid();
                if (!$valid) {

                    $validator.focusInvalid();
                    return false;
                }
            }
        });


    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        // AmCharts.ready();
        PorMarca();
        $("#TxtFechaInicio").change(function () {
            //$("#DivMarca").hide();
            // $("#MarcaLineaModelo").hide();
            PorMarca();
        });
        $("#TxtFechaFinal").change(function () {
            //$("#DivMarca").hide();
            // $("#MarcaLineaModelo").hide();
            PorMarca();
        });
    });
    $("#DropDepartamentos").change(function () {
        //$("#DivMarca").hide();
        // $("#MarcaLineaModelo").hide();
        PorMarca();
    });
    $("#DropAIM").change(function () {
        //$("#DivMarca").hide();
        // $("#MarcaLineaModelo").hide();
        PorMarca();
    });
    $("#DropAFM").change(function () {
        //$("#DivMarca").hide();
        // $("#MarcaLineaModelo").hide();
        PorMarca();
    });


    function PorMarca(event) {
        $("#MarcaLineaModeloGraphic").html("");
        $("#DivMarca").hide();
        $("#LblTotalFlota").fadeOut();
        $.ajax({
            type: "POST",
            url: "WebService.asmx/PorMarca",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento:" + $("#DropDepartamentos").val() + ",FechaInicio:'" + $("#TxtFechaInicio").val() + "',FechaFinal:'" + $("#TxtFechaFinal").val() + "',ModeloInicial:'" + $("#DropAIM").val() + "',ModeloFinal:'" + $("#DropAFM").val() + "'}",
            success: function (data) {
                var TotalKm = 0;
                var TotalCosto = 0;
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
                    } else {
                        TotalKm = TotalKm + item.KmRecorrido;
                        TotalCosto = TotalCosto + item.TotalGastos;
                    }
                });
                if (data.d.length > 0) {
                    $("#LblTotalFlota").html("Costo Por Kilometro: " + (TotalCosto / TotalKm).toFixed(2)).show();
                }
                chart = new AmCharts.AmSerialChart();
                chart.dataProvider = data.d;
                chart.categoryField = "TipoVehiculo";
                chart.depth3D = 20;
                chart.angle = 30;
                var categoryAxis = chart.categoryAxis;
                categoryAxis.dashLength = 5;
                categoryAxis.gridPosition = "start";
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.title = "Por Tipo de Vehiculo";
                chart.addValueAxis(valueAxis);
                var graph = new AmCharts.AmGraph();
                graph.valueField = "CostoxKm";
                graph.colorField = "color";
                graph.balloonText = "<span style='font-size:14px'>[[category]]</span><br /><span style='font-size:12px'>Costo Por Km: <b>[[value]]</b></span><br /><span>Total Gastos: <b>Q.[[TotalGastos]]</b></span><br /><span>Km Recorridos [[KmRecorrido]]</span>";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                chart.addGraph(graph);


                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart.addChartCursor(chartCursor);
                chart.addListener("clickGraphItem", SelectedMarca);
                chart.write("GastosMensuales");
                $("#GastosMensuales").show();
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
    var _Marca = "";
    function SelectedMarca(e) {
        console.log(e.item.dataContext.IdTipoVehiculo);
        _Marca = e.item.dataContext.Marca;
        TipoVehiculo = e.item.dataContext.IdTipoVehiculo
        TipoVehiculoT = e.item.dataContext.TipoVehiculo

        console.log(e)
        $.ajax({
            type: "POST",
            url: "WebService.asmx/LlenarModeloPorMarca",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Marca:'" + TipoVehiculo + "'}",
            async: false,
            success: function (data) {
                $("#DropModelo").html("<option value='0'>TODOS</option>").trigger("chosen:updated");
                $.each(data.d, function (i, item) {
                    if (item.StrError == "0") {
                        $("#DropModelo").append("<option value='" + item.Modelo + "'>" + item.Modelo + "</option>").trigger("chosen:updated");
                    }
                });
            }
        });
        $.ajax({

            type: "POST",
            url: "WebService.asmx/LlenarLineaPorMarca",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Marca:'" + _Marca + "'}",
            async: false,
            success: function (data) {
                $("#DropLinea").html("<option value='0'>TODOS</option>").trigger("chosen:updated");
                $.each(data.d, function (i, item) {
                    if (item.StrError == "0") {
                        $("#DropLinea").append(new Option(item.Linea, item.Linea)).trigger("chosen:updated");
                        //$("#DropLinea").append("<option value='" + item.Linea + "'>" + + "</option>").trigger("chosen:updated");
                    }
                });
            }
        });
        $("#DivMarca").show();
        LineaMarca();
    }

    function LineaMarca(e) {


        console.log(e)
        $.ajax({
            type: "POST",
            url: "WebService.asmx/PorMarcaLineaModelo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento:" + $("#DropDepartamentos").val() + ",FechaInicio:'" + $("#TxtFechaInicio").val() + "',FechaFinal:'" + $("#TxtFechaFinal").val() + "',TipoVehiculo:'" + TipoVehiculo + "' ,ModeloInicial:'" + $("#DropAIM").val() + "',ModeloFinal:'" + $("#DropAFM").val() + "'}",
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
                chart.dataProvider = data.d;
                chart.categoryField = "Marca";
                chart.depth3D = 20;
                chart.angle = 30;
                var categoryAxis = chart.categoryAxis;
                categoryAxis.dashLength = 5;
                categoryAxis.gridPosition = "start";
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.title = TipoVehiculoT;
                chart.addValueAxis(valueAxis);
                var graph = new AmCharts.AmGraph();
                graph.valueField = "CostoxKm";
                graph.color = "#FFFFFF";
                graph.colorField = "color2";
                graph.balloonText = "<span style='font-size:14px'>[[category]]</span><br /><span style='font-size:12px'>Costo Por Km: <b>[[value]]</b></span><br /><span>Total Gastos: <b>Q.[[TotalGastos]]</b></span><br /><span>Km Recorridos [[KmRecorrido]]</span>";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                chart.addGraph(graph);

                var durationAxis = new AmCharts.ValueAxis();
                durationAxis.title = "KmxGalon";
                durationAxis.gridAlpha = 1500;
                durationAxis.position = "right";
                durationAxis.inside = true;
                durationAxis.unit = "Km/Gl";
                durationAxis.axisAlpha = 1000;
                chart.addValueAxis(durationAxis);
                // line
                // line
                var graph2 = new AmCharts.AmGraph();
                graph2.type = "line";
                graph2.title = "KmxGalon";
                graph2.valueAxis = durationAxis;
                graph2.lineColor = "#fcd202";
                graph2.valueField = "KmxGalon";
                graph2.lineThickness = 3;
                graph2.bullet = "round";
                graph2.bulletBorderThickness = 3;
                graph2.bulletBorderColor = "#fcd202";
                graph2.bulletBorderAlpha = 1;
                graph2.bulletColor = "#ffffff";
                graph2.dashLengthField = "dashLengthLine";
                graph2.balloonText = "<span style='font-size:13px;'>[[title]] de [[category]]:<b>[[value]]</b> [[additional]]</span><br><span style='font-size:13px;'>Cantidad de Galones: [[CantidadGalones]]</span><br><span style='font-size:13px;'>Consumo Combustible: Q.[[ConsumoCombustible]]</span><br><span style='font-size:13px;'>Rendimiento: [[Rendimiento]]KM</span>";
                chart.addGraph(graph2);

                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart.addChartCursor(chartCursor);
                chart.addListener("clickGraphItem", LineaModelo);
                chart.write("MarcaLineaModeloGraphic");
                $("#MarcaLineaModelo").show();
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
                console.log(data.responseText);
            }
        });
    }


    function LineaModelo(e) {
        TipoVehiculo = e.item.dataContext.TipoVH

        marca = e.item.dataContext.Marca
        console.log(e)
        modelo = e.item.dataContext.Modelo
        $.ajax({
            type: "POST",
            url: "WebService.asmx/PorModelo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento:" + $("#DropDepartamentos").val() + ",FechaInicio:'" + $("#TxtFechaInicio").val() + "',FechaFinal:'" + $("#TxtFechaFinal").val() + "',marca:'" + marca + "',TipoVH:'" + TipoVehiculo + "',ModeloInicial:'" + $("#DropAIM").val() + "',ModeloFinal:'" + $("#DropAFM").val() + "'}",
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
                chart.dataProvider = data.d;
                chart.categoryField = "Modelo";
                chart.depth3D = 20;
                chart.angle = 30;
                var categoryAxis = chart.categoryAxis;
                categoryAxis.dashLength = 5;
                categoryAxis.gridPosition = "start";
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.title = marca;
                chart.addValueAxis(valueAxis);
                var graph = new AmCharts.AmGraph();
                graph.valueField = "CostoxKm";
                graph.colorField = "color3";
                graph.balloonText = "<span style='font-size:14px'>[[category]]</span><br /><span style='font-size:12px'>Costo Por Km: <b>[[value]]</b></span><br /><span>Total Gastos: <b>Q.[[TotalGastos]]</b></span><br /><span>Km Recorridos [[KmRecorrido]]</span>";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                chart.addGraph(graph);
                var durationAxis = new AmCharts.ValueAxis();
                durationAxis.title = "KmxGalon";
                durationAxis.gridAlpha = 1500;
                durationAxis.position = "right";
                durationAxis.inside = true;
                durationAxis.unit = "Km/Gl";
                durationAxis.axisAlpha = 1000;
                chart.addValueAxis(durationAxis);
                // line
                // line
                var graph2 = new AmCharts.AmGraph();
                graph2.type = "line";
                graph2.title = "KmxGalon";
                graph2.valueAxis = durationAxis;
                graph2.lineColor = "#fcd202";
                graph2.valueField = "KmxGalon";
                graph2.lineThickness = 3;
                graph2.bullet = "round";
                graph2.bulletBorderThickness = 3;
                graph2.bulletBorderColor = "#fcd202";
                graph2.bulletBorderAlpha = 1;
                graph2.bulletColor = "#ffffff";
                graph2.dashLengthField = "dashLengthLine";
                graph2.balloonText = "<span style='font-size:13px;'>[[title]] de [[category]]:<b>[[value]]</b> [[additional]]</span><br><span style='font-size:13px;'>Cantidad de Galones: [[CantidadGalones]]</span><br><span style='font-size:13px;'>Consumo Combustible: Q.[[ConsumoCombustible]]</span><br><span style='font-size:13px;'>Rendimiento: [[Rendimiento]]KM</span>";
                chart.addGraph(graph2);

                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart.addChartCursor(chartCursor);
                chart.addListener("clickGraphItem", ModeloVehiculo);
                chart.write("ModeloGraphic");
                $("#ModeloGraphic").show();
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
                console.log(data.responseText);
            }
        });
    }

    function ModeloVehiculo(e) {
        TipoVehiculo = e.item.dataContext.TipoVH

        marca = e.item.dataContext.Marca
        console.log(e)
        modelo = e.item.dataContext.Modelo
        $.ajax({
            type: "POST",
            url: "WebService.asmx/PorVehiculo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento:" + $("#DropDepartamentos").val() + ",FechaInicio:'" + $("#TxtFechaInicio").val() + "',FechaFinal:'" + $("#TxtFechaFinal").val() + "',marca:'" + marca + "',TipoVH:'" + TipoVehiculo + "',Modelo:'" + modelo + "' ,ModeloInicial:'" + $("#DropAIM").val() + "',ModeloFinal:'" + $("#DropAFM").val() + "'}",
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
                chart.dataProvider = data.d;
                chart.categoryField = "Vehiculo";
                chart.depth3D = 20;
                chart.angle = 30;
                var categoryAxis = chart.categoryAxis;
                categoryAxis.dashLength = 5;
                categoryAxis.gridPosition = "start";
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.title = modelo;
                chart.addValueAxis(valueAxis);
                var graph = new AmCharts.AmGraph();

                graph.valueField = "CostoxKm";
                graph.colorField = "color4";
                graph.balloonText = "<span style='font-size:14px'>[[category]]</span><br /><span style='font-size:12px'>Costo Por Km: <b>[[value]]</b></span><br /><span>Total Gastos: <b>Q.[[TotalGastos]]</b></span><br /><span>Km Recorridos [[KmRecorrido]]</span>";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                chart.addGraph(graph);

                var durationAxis = new AmCharts.ValueAxis();
                durationAxis.title = "KmxGalon";
                durationAxis.gridAlpha = 1500;
                durationAxis.position = "right";
                durationAxis.inside = true;
                durationAxis.unit = "Km/Gl";
                durationAxis.axisAlpha = 1000;
                chart.addValueAxis(durationAxis);
                // line
                var graph2 = new AmCharts.AmGraph();
                graph2.type = "line";
                graph2.title = "KmxGalon";
                graph2.lineColor = "#fcd202";
                graph2.valueField = "KmxGalon";
                graph2.valueAxis = durationAxis;
                graph2.lineThickness = 3;
                graph2.bullet = "round";
                graph2.bulletBorderThickness = 3;
                graph2.bulletBorderColor = "#fcd202";
                graph2.bulletBorderAlpha = 1;
                graph2.bulletColor = "#ffffff";
                graph2.dashLengthField = "dashLengthLine";
                graph2.balloonText = "<span style='font-size:13px;'>[[title]] de [[category]]:<b>[[value]]</b> [[additional]]</span><br><span style='font-size:13px;'>Cantidad de Galones: [[CantidadGalones]]</span><br><span style='font-size:13px;'>Consumo Combustible: Q.[[ConsumoCombustible]]</span><br><span style='font-size:13px;'>Rendimiento: [[Rendimiento]]KM</span>";
                chart.addGraph(graph2);

                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart.addChartCursor(chartCursor);
                chart.write("VehiculoGraphic");
                $("#ModeloGraphic").show();
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
                console.log(data.responseText);
            }
        });
    }
</script>
</body>
</html>
