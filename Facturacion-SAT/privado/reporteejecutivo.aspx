<%@ Page Language="VB" AutoEventWireup="false" CodeFile="reporteejecutivo.aspx.vb" Inherits="privado_reporteejecutivo" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/png" />
  <title>Reporte Ejecutivo | Monitoreo</title>
  <link rel="stylesheet" href="css/style.default.css" />
  <link rel="stylesheet" href="css/amCharts.css" type="text/css" />
  <link rel="stylesheet" href="css/jquery.datatables.css" />
  <link rel="stylesheet" href="css/jquery.gritter.css" />
  <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
  <link rel="stylesheet" href="css/select2.css" />
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>
<body>
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<section>
  <div class="leftpanel">
    <div class="logopanel">
        <h1><span>[</span> Monitoreo <span>]</span></h1>
    </div>
    <div class="leftpanelinner">
        <!-- #include file="usuario.html"-->
      <h5 class="sidebartitle">Men&uacute;</h5>
      <!--#include file="menu.html" -->
    </div>
  </div>
  <div class="mainpanel">
    <div class="headerbar">
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      <!-- #include FILE="usuariomenu.html" --> 
    </div>
    <div class="pageheader">
      <h2><i class="fa fa-th-large"></i> Reporte Ejecutivo <span>Reportes</span></h2>
    </div>
    <div class="contentpanel">
      <div class="row">
        <div class="col-md-12">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title">Filtros:</h4>
              <form runat="Server" id="filtro">
                <div class="form-group">
                    <label class="col-sm-1">Departamento:</label>
                    <div class="col-sm-2">
                       <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                     <label class="col-sm-1">Vehiculo:</label>
                    <div class="col-sm-2">
                       <asp:DropDownList ID="DropVehiculo" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <label class="col-sm-1">Año:</label>
                    <div class="col-sm-2">
                       <asp:DropDownList ID="DropYear" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <label class="col-sm-1">Mes:</label>
                    <div class="col-sm-2">
                       <asp:DropDownList ID="DropMes" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1">Opcion:</label>
                    <div class="col-sm-3">
                       <asp:DropDownList ID="DropOpcion" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <label class="col-sm-1">Filtro:</label>
                    <div class="col-sm-3">
                       <asp:DropDownList ID="DropFiltro" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <label class="col-sm-1">Valor:</label>
                    <div class="col-sm-3">
                       <div class="input-group"><div class="bootstrap-timepicker"><input type="text" class="form-control TxtValor" id="TxtHora" value="08:00" /></div><span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span></div>
                       <input type="text" class="form-control TxtValor" id="TxtVelocidad" style="display:none;" value="90" />
                       <input type="text" class="form-control TxtValor" id="TxtDistancia" style="display:none;" value="50" />
                       <input type="text" class="form-control TxtValor" id="TxtHorasEncendido" style="display:none;" value="4" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-6"></div>
                    <div class="col-sm-6">
                        <div class="btn-demo">
                            <input type="button" value="Actualizar" id="BtnActualizar" class="btn btn-primary" />
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target=".bs-example-modal-static" id="BtnMostrarAnual">Mostrar Grafica Anual</button>
                            <input id="btnExport" class="btn btn-success" type="button" value="Exportar a Excel" /></div>
                        </div>
                    </div>
                </div>
            </form>
            </div>
            <div class="panel-body panel-body-nopadding">
                <div class="table-responsive" style="display:none;" id="DivDetalle">
                    <table class="table" id="TblDetalle" >
                        <thead><tr></tr></thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

    <div class="panel-body">
             

                <div class="DivDetalle1" style="display:none;">
                            <table border="1" class="table" id="TblDetalle1">
                                <thead>
                                    <tr>
                            <th>Departamento</th>
                            <th>Unidad</th>
                             <th>Conductor</th>
                             <th>Total</th>

                            <th>1</th><th>2</th><th>3</th><th>4</th><th>5</th>
                            <th>6</th><th>7</th><th>8</th><th>9</th><th>10</th>
                            <th>11</th><td>13</td><td>14</td><td>15</td><td>16</td>
                            <td>17</td><td>18</td><td>19</td><td>20</td><td>21</td>
                            <td>22</td><td>23</td><td>24</td><td>25</td><td>26</td>
                            <td>27</td><td>28</td> <td>29</td><td>30</td><td>31</td>
                           

                            
                           
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
               
            </div><!-- panel-body -->
</section>
<div class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Grafica Anual</h4>
        </div>
        <div class="modal-body">
            <div id="chartdiv" style="width: 560px; height: 300px; display:block;"></div>
        </div>
    </div>
  </div>
</div>
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
<script src="js/jquery.datatables.min.js"></script>
<script src="js/jquery.gritter.min.js"></script>
<script src="js/select2.min.js"></script>
<script src="js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        jQuery('#TxtHora').timepicker({ showMeridian: false });
        $("#<%=DropOpcion.ClientID %>").change(function () {
            $(".TxtValor, .input-group").hide();
            if ($(this).val() == 1 || $(this).val() == 2) {
                $(".input-group, #TxtHora").show();
            } else if ($(this).val() == 3) {
                $("#TxtVelocidad").show();
            } else if ($(this).val() == 4) {
                $("#TxtDistancia").show();
            } else if ($(this).val() == 5) {
                $("#TxtHorasEncendido").show();
            }
        });
        $("#BtnActualizar").click(function () {
            llenar();
            LlenarDropVehivulosDepto();
        });
        $("#BtnMostrarAnual").click(function () {
            llenarAnual();
        });
    });
    function llenar() {
        var valor;
        if ($("#<%=DropOpcion.ClientID %>").val() == 1 || $("#<%=DropOpcion.ClientID %>").val() == 2) {
            valor = $("#TxtHora").val();
        } else if ($("#<%=DropOpcion.ClientID %>").val() == 3) {
            valor = $("#TxtVelocidad").val();
        } else if ($("#<%=DropOpcion.ClientID %>").val() == 4) {
            valor = $("#TxtDistancia").val();
        } else if ($("#<%=DropOpcion.ClientID %>").val() == 5) {
            valor = $("#TxtHorasEncendido").val();
        }
    $.ajax({
        type: "POST",
        url: "WebService.asmx/ReporteEjecutivo",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{Departamento:" + $("#<%=DropDepartamentos.ClientID %>").val() + ", Year:" + $("#<%=DropYear.ClientID %>").val() + ", Mes:" + $("#<%=DropMes.ClientID %>").val() + ", Opcion:" + $("#<%=DropOpcion.ClientID %>").val() + ",Filtro:" + $("#<%=DropFiltro.ClientID%>").val() + ", Valor: '" + valor + "',Vehiculo:" + $("#<%=DropVehiculo.ClientID%>").val() + "}",
            success: function (data) {
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
                        $("#TblDetalle thead tr").html("<th>Departamento</th><th>Unidad</th><th>Conductor</th>");
                        $("#TblDetalle1 thead tr").html("<th>Departamento</th><th>Unidad</th><th>Conductor</th>");
                        for (dia = 1; dia <= item.Dias; dia++) {
                            $("#TblDetalle thead tr").append("<th>" + dia + "</th>");
                            $("#TblDetalle1 thead tr").append("<th>" + dia + "</th>");
                        }

                        
                            $("#TblDetalle thead tr").append("<th>Total</th>");
                            $("#TblDetalle1 thead tr").append("<th>Total</th>");
                      
                        
                        $("#TblDetalle tbody").html("");
                        $("#TblDetalle1 tbody").html("");
                        $.each(item.Unidad, function (j, jItem) {
                            var html;
                            for (dia = 1; dia <= item.Dias; dia++) {
                                html = html + "<td></td>";
                            }
                            $("#TblDetalle tbody").append("<tr id='row_" + jItem.IdVehiculo + "'><td>" + jItem.Departamento + "</td><td data-content='Promedio: " + jItem.Promedio + " <br />Mediana: " + jItem.Mediana + " <br />Moda: " + jItem.Moda + " <br />Frecuencia-Moda: " + jItem.Frecuencia + " <br /> <div class=chart id=\"graph_" + jItem.IdVehiculo + "\"></div>' data-placement='top' data-toggle='popover' data-trigger='hover' data-container='body' class='popovers' data-original-title='' title='' style='cursor:pointer;'>" + jItem.Unidad + "</td><td>" + jItem.Piloto + "</td>" + html + "<td>" + jItem.Total + "</td></tr>");
                            $("#TblDetalle1 tbody").append("<tr id='row_" + jItem.IdVehiculo + "'><td>" + jItem.Departamento + "</td><td data-content='Promedio: " + jItem.Promedio + " <br />Mediana: " + jItem.Mediana + " <br />Moda: " + jItem.Moda + " <br />Frecuencia-Moda: " + jItem.Frecuencia + " <br /> <div class=chart id=\"graph_" + jItem.IdVehiculo + "\"></div>' data-placement='top' data-toggle='popover' data-trigger='hover' data-container='body' class='popovers' data-original-title='' title='' style='cursor:pointer;'>" + jItem.Unidad + "</td><td>" + jItem.Piloto + "</td>" + html + "<td>" + jItem.Total + "</td></tr>");

                            jQuery('.popovers').popover({ html: true });
                            $.each(jItem.Data, function (x, xIndex) {
                                var clase;
                                if (xIndex.Parametro == true) {
                                    clase = "btn-success";
                                } else if (xIndex.Parametro == false) {
                                    clase = "btn-danger";
                                }
                                $("#TblDetalle tbody #row_" + jItem.IdVehiculo + " td:eq(" + (xIndex.Fecha + 2) + ")").addClass(clase).html(xIndex.Valor);
                                $("#TblDetalle1 tbody #row_" + jItem.IdVehiculo + " td:eq(" + (xIndex.Fecha + 2) + ")").addClass(clase).html(xIndex.Valor);

                            });
                        });
                       
                        console.log(data);

                    }
                });
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
            }, complete: function () { $("#DivDetalle").fadeIn(); }
        });
    }
    function llenarAnual() {
        var valor;
        if ($("#<%=DropOpcion.ClientID %>").val() == 1 || $("#<%=DropOpcion.ClientID %>").val() == 2) {
            valor = $("#TxtHora").val();
        } else if ($("#<%=DropOpcion.ClientID %>").val() == 3) {
            valor = $("#TxtVelocidad").val();
        } else if ($("#<%=DropOpcion.ClientID %>").val() == 4) {
            valor = $("#TxtDistancia").val();
        } else if ($("#<%=DropOpcion.ClientID %>").val() == 5) {
            valor = $("#TxtHorasEncendido").val();
        }
    $.ajax({
        type: "POST",
        url: "WebService.asmx/ReporteEjecutivoAnual",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{Departamento:" + $("#<%=DropDepartamentos.ClientID %>").val() + ", Year:" + $("#<%=DropYear.ClientID %>").val() + ", Opcion:" + $("#<%=DropOpcion.ClientID %>").val() + ",Filtro:" + $("#<%=DropFiltro.ClientID%>").val() + ", Valor: '" + valor + "'}",
            success: function (data) {
                console.log(data.d);
                if (data.d[0].StrError == "0") {
                    chart = new AmCharts.AmSerialChart();
                    chart.dataProvider = data.d;
                    chart.categoryField = "Mes";
                    chart.depth3D = 20;
                    chart.angle = 30;

                    var categoryAxis = chart.categoryAxis;
                    categoryAxis.dashLength = 5;
                    categoryAxis.gridPosition = "start";

                    var valueAxis = new AmCharts.ValueAxis();
                    valueAxis.title = "Cantidad";
                    valueAxis.dashLength = 5;
                    chart.addValueAxis(valueAxis);

                    var graph = new AmCharts.AmGraph();
                    graph.valueField = "Cantidad";
                    graph.colorField = "#000000";
                    graph.balloonText = "<span style='font-size:14px'>[[category]]: <b>[[value]]</b></span>";
                    graph.type = "column";
                    graph.lineAlpha = 0;
                    graph.fillAlphas = 1;
                    chart.addGraph(graph);

                    var chartCursor = new AmCharts.ChartCursor();
                    chartCursor.cursorAlpha = 0;
                    chartCursor.zoomable = false;
                    chartCursor.categoryBalloonEnabled = false;
                    chart.addChartCursor(chartCursor);

                    chart.write("chartdiv");
                } else {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.d[0].StrError,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
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
            }, complete: function () { $("#DivDetalle").fadeIn(); }
        });
    }
    function hourtoseconds(stringhour) {
        var hms = stringhour;
        var a = hms.split(':');
        var seconds = (+a[0]) * 60 * 60 + (+a[1]) * 60;
        return seconds;
    }
    $("#btnExport").click(function () {

        window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.DivDetalle1').html()));
        e.preventDefault();

    });

    $("#<%=DropDepartamentos.ClientID %>").change(function () {
        $("#<%=DropVehiculo.ClientID%>").html("");
        $("#<%=DropVehiculo.ClientID%>").append($("<option></option>").attr("value", 0).text("TODOS"))
        // armo el objeto que servira de parametro, para ello utilizo una libreria de JSON
        //este parametro mapeara con el definido en el web service
        var params = new Object();
        params.pais = $("#<%=DropDepartamentos.ClientID%>").val();
        params = JSON.stringify(params);

        $.ajax({
            type: "POST",
            url: "WebService.asmx/CargarDropVehilosDepto",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'IdDepto':'" + $("#DropDepartamentos").val() + "'}",
            success: function (data) {
                $.each(data.d, function (index, item) {

                    $("#<%=DropVehiculo.ClientID%>").append($("<option></option>").attr("value", this.Id).text(this.Vehiculo))

                    });
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





</script>
</body>
</html>
