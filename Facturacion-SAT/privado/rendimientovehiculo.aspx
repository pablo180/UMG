<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rendimientovehiculo.aspx.vb" Inherits="privado_rendimientovehiculo" %>
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
              
                <h4 class="panel-title">Tipo de Reporte:</h4>
                <div class="form-group">
                    <div class="col-sm-4">
                       <select id="DDLTipoReporte" runat="server" class="form-control">
                           <option value="1">Gráfica</option>
                           <option value="2">Listado</option>
                       </select>
                    </div>
                </div>
              <h4 class="panel-title">Filtros:</h4>
              <form runat="Server" id="filtro">
                <div class="form-group" id="filtroGrafica">
                    <label class="col-sm-2">Departamento:</label>
                    <div class="col-sm-4">
                       <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <%--<label class="col-sm-2">Año:</label>--%>
                    <div class="col-sm-6">
                       <%--<asp:DropDownList ID="DropYear" runat="server" CssClass="form-control"></asp:DropDownList>--%>
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
                
                <div id="filtroLista" style="display:none">
                    <div class="form-group">
                        <label class="col-sm-2">Departamento:</label>
                        <div class="col-sm-4">
                           <asp:DropDownList ID="DDLDepto" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <label class="col-sm-2">Unidad:</label>
                        <div class="col-sm-4">
                           <asp:DropDownList ID="DDLUnidad" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2">Fecha Inicial:</label>
                        <div class="col-sm-4">
                           <asp:TextBox ID="txtFIni" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label class="col-sm-2">Fecha Final:</label>
                        <div class="col-sm-4">
                           <asp:TextBox ID="txtFFin" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </form>
            </div>
            <div class="panel-body panel-body-nopadding">
              <!-- BASIC WIZARD -->
              <div id="basicWizard" class="basic-wizard">
                <ul class="nav nav-pills nav-justified">
                <%--  <li><a href="#tab1" data-toggle="tab"><span>Rendimiento:</span> Combustible</a></li>
                  <li><a href="#tab2" data-toggle="tab"><span>Rendimiento:</span> Aceite de Motor</a></li>
                  <li><a href="#tab3" data-toggle="tab"><span>Rendimiento:</span> Aceite de Caja</a></li>--%>
                  <li><a href="#tab4" data-toggle="tab"><span>Repuestos:</span></a></li>
                </ul>
                <div class="tab-content">
                        <div class="col-sm-12" id="graphica">
                            <div id="GastosMensuales" style="width:100%; height:380px; position:relative;" ></div>
                            <input type="radio"  name="group" id="rb2" onclick="setDepth()">2D
                             <input type="radio" checked="checked"name="group" id="rb1" onclick="setDepth()">3D</div>
                        </div>     
                             <div class="col-sm-12" id="graphica2" style="display:none;">         
                     <%--   <div class="col-sm-12" id="PieRendimiento" style="width:500px; height:380px; display:none;"></div>--%>
                                 <div class="col-sm-12" id="PieRendimiento" style="width: 100%; height:600px; display:none;"></div>
                                 </div> 
                  <div class="col-sm-12" id="graphica3">  
                      <div class="col-sm-9" id="Div2">  
                   
                           </div>
                       <div class="col-sm-3" id="regresar" style="display:none;">  
                    <input type="button" value="Regresar a clasificacion" id="txtRegresar" class="btn btn-primary" /> 
                           </div>
                        <div class="col-sm-12"  id="PieSubRendimiento" style="width:100%; height:600px; display:none;"></div>
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
        $("#txtRegresar").click(function () {
            $("#PieRendimiento").show("slow");
            $("#PieSubRendimiento").hide("slow");
            $("#DetalleFacturacion").hide();
            $("#DivDetalle").hide("slow");
            $("#regresar").hide("slow");
            $("#DivDet").hide("slow");
            
            
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
                    $("#TxtFechaInicio").show("slow");
                    $("#TxtFechaFinal").show("slow");
                    Anual();
                    break;
                case 2:
                    Unidades();
                    bindFechas();
                    $("#filtroLista").show("slow");
                    $("#DivDetalle").show("slow");
                    $("#DetalleFacturacion_wrapper").show("slow");
                    $("#filtroGrafica").hide("slow");
                    $("#TxtFechaInicio").hide("slow");
                    $("#TxtFechaFinal").hide("slow");
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
        //Anual();
        $("#<%=DropDepartamentos.ClientID %>").change(function () {
            $("#PieRendimiento").hide();
            $("#PieSubRendimiento").hide();
            $("#DivDetalle").hide();
            // $("#GastosMensuales").hide();
            Anual();
        });
        $("#TxtFechaInicio").change(function () {
            $("#PieRendimiento").hide();
            $("#PieSubRendimiento").hide();
            $("#DivDetalle").hide();
            // $("#GastosMensuales").hide();
            Anual();
        });
        $("#TxtFechaFinal").change(function () {
            $("#PieRendimiento").hide();
            $("#PieSubRendimiento").hide();
            $("#DivDetalle").hide();
            // $("#GastosMensuales").hide();
            Anual();
        });
        $("#DDLDepto").change(function () {
            Unidades();
            llenarDetalle();
        });
        $("#DDLUnidad").change(function () {
            llenarDetalle();
        });
        $("#txtFIni").change(function () {
            llenarDetalle();
        });
        $("#txtFFin").change(function () {
            llenarDetalle();
        });
        $("#DetalleFacturacion_wrapper select").change(function () {
            $("tr>td>a").click(function (event) {
                event.preventDefault();
                var serie = $(this).html();
                FcrearPDF(serie);
            });
        });
        $("#DetalleFacturacion_wrapper div>a").click(function () {
            $("tr>td>a").click(function (event) {
                event.preventDefault();
                var serie = $(this).html();
                FcrearPDF(serie);
            });
        });
    });
    function llenarDetalle() {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/llenarDetalle",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{depto: " + $("#DDLDepto").val() + ",unidad: " + $("#<%= DDLUnidad.ClientID %>").val() + ",fechaIni: '" + $("#txtFIni").val() + "',fechaFin: '" + $("#txtFFin").val() + "'}",
            async: false,
            success: function (data) {
                $("#DivDetalle").show("slow");
                $("#DetalleFacturacion").DataTable().fnClearTable();
                var elemento = (typeof data.d) == 'string' ? eval('(' + data.d + ')') : data.d;
                console.log(data.d);
                $.each(data.d, function (index, item) {
                    $("#DetalleFacturacion").DataTable().fnAddData([
                                item.fecha,
                                "<a name='documento' href='#'>" + item.doc + "</a>",
                                item.unidad,
                                item.codigo,
                                item.clasif,
                                item.subcla,
                                item.desc,
                                item.cant,
                                item.precio,
                                item.total
                    ]);
                });
                $("tr>td>a").click(function (event) {
                    event.preventDefault();
                    var serie = $(this).html();
                    FcrearPDF(serie);
                });
            },
            error: function (data) {
                $.gritter.add({
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
    function FcrearPDF(serie) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/crearPDF",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{factura: '" + serie + "'}",
            async: false,
            success: function (data) {
                if (data.d) {
                    $.fancybox({
                        'autoScale': false,
                        'transitionIn': 'none',
                        'transitionOut': 'none',
                        'width': '70%',
                        'height': '100%',
                        'type': 'iframe',
                        'href': 'reporte/ReporteFactura.pdf'
                    });
                } else {
                    $.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: 'No se puede crear el reporte',
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
            },
            error: function (data) {
                $.gritter.add({
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
    function bindFechas() {
        var meses = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];
        $("#txtFIni").datepicker({
            monthnames: meses,
            dateformat: 'yyyy-mm-dd'
        });
        $("#txtFFin").datepicker({
            monthnames: meses,
            dateformat: 'yyyy-mm-dd'
        });
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();

        if (dd < 10) {
            dd = '0' + dd
        }

        if (mm < 10) {
            mm = '0' + mm
        }

        today = yyyy + '-' + mm + '-' + dd;
        $("#txtFIni").val(today);
        $("#txtFFin").val(today);
    }
    function Unidades(event) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/llenarUnidades",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{depto: " + $("#DDLDepto").val() + "}",
            async: false,
            success: function (data) {
                $("#<%= DDLUnidad.ClientID %>").empty();
                $("<option />", { val: 0, text: "TODOS" }).appendTo($("#<%= DDLUnidad.ClientID%>"));
                var models = (typeof data.d) == 'string' ? eval('(' + data.d + ')') : data.d;
                for (var i = 0; i <= models.length - 1; i++) {
                    $("<option />", { val: models[i].idUnidad, text: models[i].nomUnidad }).appendTo($("#<%= DDLUnidad.ClientID%>"));
                }
                $('#<%= DDLUnidad.ClientID%>').trigger("chosen:updated");
            },
            error: function (data) {
                $.gritter.add({
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
    function Anual(event) {
        if ($("#TxtFechaInicio").val() != "" && $("#TxtFechaFinal").val() != "") {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/GastosMensuales",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento:" + $("#<%=DropDepartamentos.ClientID %>").val() + ", FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "'}",
            success: function (data) {
                $("#DetalleFacturacion").DataTable().fnClearTable();
                //console.log(data.d);
                if (data.d.length < 1) {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: 'No Hay Datos',
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
                $.each(data.d, function (i, item) {
                    if (item.StrError != "0") {
                        //console.log(item.StrError);
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
                chart.categoryField = "Fecha";

                // sometimes we need to set margins manually
                // autoMargins should be set to false in order chart to use custom margin values
                chart.autoMargins = false;
                chart.marginLeft = 0;
                chart.marginRight = 0;
                chart.marginTop = 30;
                chart.marginBottom = 40;
                chart.depth3D = 25;
                chart.angle = 30;
                // AXES
                // category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.gridAlpha = 0;
                categoryAxis.axisAlpha = 0;
                categoryAxis.gridPosition = "start";

                // value
                var valueAxis = new AmCharts.ValueAxis();
                //valueAxis.stackType = "100%"; // this line makes the chart 100% stacked
                valueAxis.stackType = "regular";
                valueAxis.gridAlpha = 0;
                valueAxis.axisAlpha = 0;
                valueAxis.labelsEnabled = false;
                chart.addValueAxis(valueAxis);

                // GRAPHS
                // first graph                          
                var graph = new AmCharts.AmGraph();
                graph.title = "Respuestos y Mano de obra..........";
                graph.labelText = "[[percents]]%";
                graph.balloonText = "[[title]], [[category]]<br><span style='font-size:14px;'><b>[[value]]</b> ([[percents]]%)</span>";
                graph.valueField = "Total";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#D00000";
                graph.legendPeriodValueText = "[[value.sum]] Q";
                chart.addGraph(graph);

                // second graph              
                graph = new AmCharts.AmGraph();
                graph.title = "Gasolina";
                graph.labelText = "[[percents]]%";
                graph.balloonText = "[[title]], [[category]]<br><span style='font-size:14px;'><b>[[value]]</b> ([[percents]]%)</span>";
                graph.valueField = "TotalGasolina";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#F25A0D";
                graph.legendPeriodValueText = "[[value.sum]] Q";
                chart.addGraph(graph);

                var durationAxis = new AmCharts.ValueAxis();
                durationAxis.title = "Galones";
                durationAxis.gridAlpha = 1500;
                durationAxis.position = "right";
                durationAxis.inside = true;
                durationAxis.unit = "GLS";
                durationAxis.axisAlpha = 1000;
                chart.addValueAxis(durationAxis);

                var durationGraph = new AmCharts.AmGraph();
                durationGraph.title = "Galones";
                durationGraph.valueField = "CantidadGalones";
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
                chart.addGraph(durationGraph);

                var kmsnAxis = new AmCharts.ValueAxis();
                kmsnAxis.title = "kilometros";
                kmsnAxis.gridAlpha = 100;
                kmsnAxis.position = "left";
                kmsnAxis.inside = true;
                kmsnAxis.unit = "kms";
                kmsnAxis.axisAlpha = 100;
                chart.addValueAxis(kmsnAxis);

                var kmsGraph = new AmCharts.AmGraph();
                kmsGraph.title = "kilometros";
                kmsGraph.valueField = "kilometros";
                kmsGraph.type = "line";
                kmsGraph.valueAxis = kmsnAxis; // indicate which axis should be used
                kmsGraph.lineColor = "#2FCE08";
                kmsGraph.balloonText = "<b>[[value]]</b> kms";
                kmsGraph.lineThickness = 2;
                kmsGraph.legendValueText = "[[value]]";
                kmsGraph.bullet = "square";
                kmsGraph.bulletBorderColor = "#CC0000";
                kmsGraph.legendPeriodValueText = "[[value.sum]] KM";
                kmsGraph.bulletBorderAlpha = 1;
                kmsGraph.bulletBorderThickness = 1;
                chart.addGraph(kmsGraph);

                var rdkmtnAxis = new AmCharts.ValueAxis();
                rdkmtnAxis.title = "";
                rdkmtnAxis.gridAlpha = 0;
                rdkmtnAxis.position = "absolute";
                rdkmtnAxis.inside = true;
                rdkmtnAxis.unit = "";
                rdkmtnAxis.axisAlpha = 0;
                chart.addValueAxis(rdkmtnAxis);

                var rdkmtGraph = new AmCharts.AmGraph();
                rdkmtGraph.title = "Rendimiento kms/gls";
                rdkmtGraph.valueField = "RendimientoKmt";
                rdkmtGraph.type = "smoothedLine";
                rdkmtGraph.valueAxis = rdkmtnAxis; // indicate which axis should be used
                rdkmtGraph.lineColor = "#1D08E2";
                rdkmtGraph.balloonText = "<b>[[value]]</b> kms/gls";
                rdkmtGraph.lineThickness = 2;
                rdkmtGraph.legendValueText = "[[value]]";
                rdkmtGraph.bullet = "square";
                rdkmtGraph.bulletBorderColor = "#CC0000";
                rdkmtGraph.legendPeriodValueText = "[[value.sum]] KM";
                rdkmtGraph.bulletBorderAlpha = 1;
                rdkmtGraph.bulletBorderThickness = 1;
                chart.addGraph(rdkmtGraph);

                var ckAxis = new AmCharts.ValueAxis();
                ckAxis.title = "";
                ckAxis.gridAlpha = 0;
                ckAxis.position = "absolute";
                ckAxis.inside = true;
                ckAxis.unit = "";
                ckAxis.axisAlpha = 0;
                chart.addValueAxis(ckAxis);

                var ckGraph = new AmCharts.AmGraph();
                ckGraph.title = "Costo/Kilometro";
                ckGraph.valueField = "CostoKilometro";
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
                chart.addGraph(ckGraph);

                //var rmoAxis = new AmCharts.ValueAxis();
                //rmoAxis.title = "";
                //rmoAxis.gridAlpha = 0;
                //rmoAxis.position = "absolute";
                //rmoAxis.inside = true;
                //rmoAxis.unit = "";
                //rmoAxis.axisAlpha = 0;
                //rmoAxis.addValueAxis(rmoAxis);

                //var rmoGraph = new AmCharts.AmGraph();
                //rmoGraph.title = "Costo/Kilometro";
                //rmoGraph.valueField = "CostoKilometro";
                //rmoGraph.type = "smoothedLine";
                //rmoGraph.valueAxis = rmoAxis; // indicate which axis should be used
                //rmoGraph.lineColor = "#01A9DB";
                //rmoGraph.balloonText = "<b>[[value]]</b> Q/kms";
                //rmoGraph.lineThickness = 2;
                //rmoGraph.legendValueText = "[[value]]";
                //rmoGraph.bullet = "square";
                //rmoGraph.bulletBorderColor = "#CC0000";
                //rmoGraph.legendPeriodValueText = "[[value.sum]] Q/kms";
                //rmoGraph.bulletBorderAlpha = 1;
                //rmoGraph.bulletBorderThickness = 1;
                //chart.addGraph(rmoGraph);
                // third graph              


                // fourth graph

                // LEGEND                  
                var legend = new AmCharts.AmLegend();
                legend.borderAlpha = 0.2;
                legend.horizontalGap = 10;
                legend.autoMargins = false;
                legend.marginLeft = 20;
                legend.marginRight = 20;
                chart.addLegend(legend);

                // WRITE                  



                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart.addChartCursor(chartCursor);
                chart.addListener("clickGraphItem", Mensual);
                chart.addListener("clickGraphItem", Mensual);
                // WRITE
                chart.write("GastosMensuales");
                $("#GastosMensuales").show();
            },
            error: function (data) {
                //console.log(data.responseText);
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
                title: 'Por favor!',
                text: "Ingresar Rango de Fechas",
                class_name: 'growl-primary',
                image: 'images/screen.png',
                sticky: false,
                time: ''
            });
        }

    }

    function setDepth() {
        if (document.getElementById("rb1").checked) {
            chart.depth3D = 25;
            chart.angle = 30;
        } else {
            chart.depth3D = 0;
            chart.angle = 0;
        }
        chart.validateNow();
    }

    function Mensual(event) {
        $("#PieRendimiento").hide();
        $("#PieSubRendimiento").hide();
        $("#DivDet").hide();
        var mes = event.item.category;
        console.log(event);
        $.ajax({
            type: "POST",
            url: "WebService.asmx/GastosPorClasificacion",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento:" + $("#<%=DropDepartamentos.ClientID %>").val() + ", Mes:'" + mes + "',FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "'}",
            success: function (data) {
                $("#DetalleFacturacion").DataTable().fnClearTable();
             
                $("#txtRegresar").hide();
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

                chart1 = new AmCharts.AmSerialChart();
                chart1.addTitle("Gastos de " + mes + " Por Clasificacion", 12);
                chart1.dataProvider = data.d;
                chart1.categoryField = "Nombre";
                chart1.fieldId = "[[IdNombre]]";
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
                valueAxis1.title = "Gastos";
                valueAxis1.dashLength = 5;
                chart1.addValueAxis(valueAxis1);

                // GRAPH            
                var graph1 = new AmCharts.AmGraph();
                graph1.valueField = "Total";
                graph1.labelText = "[[Porcent]]%";
                graph1.colorField = "color";
                graph1.fieldId = "[[IdNombre]]";
              
                graph1.balloonText = "<b>[[Nombre]]</b><br><span style='font-size:14px'><b>Q.[[value]] </b>[[Porcent]]%</span><br><span style='font-size:14px'>Cantidad de Repuestos:<b>[[Cantidad]]</b>id:[[IdNombre]]</span>";
                graph1.type = "column";
                graph1.lineAlpha = 0;
                graph1.fillAlphas = 1;
                chart1.addGraph(graph1);

                
                // CURSOR
                var chartCursor1 = new AmCharts.ChartCursor();
                chartCursor1.cursorAlpha = 0;
                chartCursor1.zoomable = false;
                chartCursor1.categoryBalloonEnabled = false;
                chart1.addChartCursor(chartCursor1);

                //// PIE CHART
                //chart1 = new AmCharts.AmPieChart();
                //chart1.addTitle("Gastos de " + mes + " Por Clasificacion", 12);
                //chart1.dataProvider = data.d;
                //chart1.titleField = "Nombre";
                //chart1.valueField = "Total";
                //chart1.sequencedAnimation = true;
                //chart1.startEffect = "elastic";
                //chart1.innerRadius = "30%";
                //chart1.pullOutOnlyOne = true;
                //chart1.startDuration = 2;
                //chart1.labelRadius = 15;
                //chart1.labelText = "[[title]]: ([[percents]]%)";
                //chart1.hideLabelsPercent = 2.8;
                //chart1.fieldCantidad = "Cantidad";
                //chart1.fieldId = "IdNombre";
                //chart1.balloonText = "[[title]]<br><span style='font-size:14px'><b>Q.[[value]]</b> ([[percents]]%)</span><br><span style='font-size:14px'>Cantidad de Repuestos:<b>[[Cantidad]]</b></span>";
                //// the following two lines makes the chart 3D
                //chart1.depth3D = 10;
                //chart1.angle = 15;

                // LEGEND 
                //                var legend = new AmCharts.AmLegend();
                //                legend = new AmCharts.AmLegend();
                //                legend.position = "bottom";
                //                legend.align = "center";
                //                legend.markerType = "square";
                //                legend.valueText = "aa";
                //                chart1.addLegend(legend);

                // add click listener
                
                chart1.addListener("clickGraphItem", Detalle);
                chart1.addListener("clickGraphItem", Detalle);
                // WRITE                   
                chart1.write("PieRendimiento");
                $("#PieRendimiento").show();
                $("#graphica2").show();
            },
            error: function (data) {
                //console.log(data.responseText) 
            }
        });
    }
    function Detalle(event) {
        console.log(event);
        $("#PieSubRendimiento").hide();
        $("#DivDetalle").hide();
        $("#regresar").show("slow");
        var clasificacion = event.item.dataContext.IdNombre;
        var mes = event.item.dataContext.Fecha;
        var NombreClasificacion = event.item.category;
        console.log(event);
        $.ajax({
            type: "POST",
            url: "WebService.asmx/GastosPorSubClasificacion",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{ Departamento:" + $("#<%=DropDepartamentos.ClientID %>").val() + ",FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "', Mes:'" + mes + "', idClasificacion: '" + clasificacion + "' }",
            success: function (data) {
                $("#txtRegresar").show("slow");
                $("#PieRendimiento").hide("slow");
                $("#DetalleFacturacion").DataTable().fnClearTable();
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
                //chart1.addTitle("Gastos de " + mes + " de " + NombreClasificacion + " Por SubClasificacion", 11);
                //chart1.dataProvider = data.d;
                //chart1.titleField = "Nombre";
                //chart1.valueField = "Total";
                //chart1.sequencedAnimation = true;
                //chart1.startEffect = "elastic";
                //chart1.innerRadius = "30%";
                //chart1.pullOutOnlyOne = true;
                //chart1.startDuration = 2;
                //chart1.labelRadius = 15;
                //chart1.labelText = "[[title]]: ([[percents]]%)";
                //chart1.hideLabelsPercent = 2.8;
                //chart1.fieldCantidad = "Cantidad";
                //chart1.fieldId = "IdNombre";
                //chart1.balloonText = "[[title]]<br><span style='font-size:14px'><b>Q.[[value]]</b> ([[percents]]%)</span><br><span style='font-size:14px'>Cantidad de Repuestos:<b>[[Cantidad]]</b></span>";
                //// the following two lines makes the chart 3D
                //chart1.depth3D = 10;
                //chart1.angle = 15;

                chart1 = new AmCharts.AmSerialChart();
                chart1.addTitle("Gastos de " + mes + " de   " + NombreClasificacion + "  Por SubClasificacion", 11);
                chart1.dataProvider = data.d;
                chart1.categoryField = "Nombre";
                chart1.fieldId = "[[IdNombre]]";
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
                valueAxis1.title = "Gastos";
                valueAxis1.dashLength = 5;
                chart1.addValueAxis(valueAxis1);

                // GRAPH            
                var graph1 = new AmCharts.AmGraph();
                graph1.valueField = "Total";
                graph1.labelText = "[[Porcent]]%";
                graph1.colorField = "color";
                graph1.fieldId = "[[IdNombre]]";

                graph1.balloonText = "<b>[[Nombre]]</b><br><span style='font-size:14px'><b>Q.[[value]] </b>[[Porcent]]%</span><br><span style='font-size:14px'>Cantidad de Repuestos:<b>[[Cantidad]]</b>id:[[IdNombre]]</span>";
                graph1.type = "column";
                graph1.lineAlpha = 0;
                graph1.fillAlphas = 1;
                chart1.addGraph(graph1);


                // CURSOR
                var chartCursor1 = new AmCharts.ChartCursor();
                chartCursor1.cursorAlpha = 0;
                chartCursor1.zoomable = false;
                chartCursor1.categoryBalloonEnabled = false;
                chart1.addChartCursor(chartCursor1);

                // add click listener
             
                chart1.addListener("clickGraphItem", Listado);

                //                var legend = new AmCharts.AmLegend();
                //                legend.borderAlpha = 0.2;
                //                legend.horizontalGap = 10;
                //                chart1.addLegend(legend);
                // WRITE                   
                chart1.write("PieSubRendimiento");
                $("#PieSubRendimiento").show();
                $("#graphica3").show();
            },
            error: function (data) { //console.log(data.responseText) 
            }
        });

    }
    function Listado(event) {
        
        console.log(event);
       
        var clasificacion = event.item.dataContext.Id2;
        var mes = event.item.dataContext.Fecha;
        $('#tableDetalle').dataTable().fnClearTable();
        $("#DivDetalle").slideUp();
        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleGastos",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{ Departamento:" + $("#DropDepartamentos").val() + ",FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFinal").val() + "', Mes:'" + mes + "',idClasificacion:'" + clasificacion + "',idSubClasificacion: '" + event.item.dataContext.IdNombre + "' }",
            success: function (data) {
           
               
                //console.log(data.d);
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
                        $('#tableDetalle').dataTable().fnAddData([
        			    item.Fecha,
        			    item.Vehiculo,
        			    item.Codigo,
                        item.Descripcion,
        			    item.Cantidad,
        			    item.Precio,
                        item.Total]);
                    }
                });
                $("#DivDet").slideDown();
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
</script>
</body>
</html>
