<%@ Page Language="VB" AutoEventWireup="false" CodeFile="liquidaciones.aspx.vb" Inherits="privado_liquidaciones" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Liquidaciones de Facturas | <%=datos.addKey("NameProject")%></title>
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/fullcalendar.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
  <link href="css/jquery.datatables.css" rel="stylesheet">
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>
<body>
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<form class="form-horizontal form-bordered" runat="server" id="formulario">
<section>
  <div class="leftpanel">
    <div class="logopanel">
        <h1><span>[</span><%=  datos.addKey("NameProject") %> <span>]</span></h1>
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
      <!-- #INCLUDE FILE="usuariomenu.html" --> 
    </div>
    <div class="pageheader">
      <h2><i class="fa fa-calendar"></i> Liquidaciones <span>Ingresos...</span></h2>
      <div class="breadcrumb-wrapper">
      </div>
    </div>
    <div class="contentpanel">
        <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding">
            <div class="form-group">
              <label class="col-sm-2 control-label">Fecha Inicio</label>
              <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="input-group">
                        <input type="text" class="form-control fecha" placeholder="yyyy-mm-dd" id="TxtFechaInicio" runat ="server"  />
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </div>
              </div>
              <label class="col-sm-2 control-label">Fecha Fin</label>
              <div class="col-sm-4">
                  <div class="panel panel-default">
                    <div class="input-group">
                        <input type="text" class="form-control fecha" placeholder="yyyy-mm-dd" id="TxtFechaFin" runat ="server"  />
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </div>
              </div>
            </div>   
            <div class="form-group">
                <div class="col-sm-10"></div>
                <div class="col-sm-2">
                  <div class="panel panel-default">
                    <div class="input-group">
                        <input type="button" class="btn btn-primary" id="BtnActualizaLiquidaciones" value="Actualizar" />
                    </div>
                </div>
              </div>
            </div>     
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-hidaction table-hover mb30 Liquidaciones">
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Empleado</th>
                                <th>Anticipo</th>
                                <th>Total Gastos</th>
                                <th>Saldo A Cargo</th>
                                <th>Saldo A Favor</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
      </div>
    </div>
  </div>
<div class="modal fade ListaFacturaLiquidaciones" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Lista de Facturas de Liquidación</h4>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-hidaction table-hover mb30 DetalleFacturasLiquidacion">
                            <thead>
                                <tr>
                                    <th>Serie Factura</th>
                                    <th>Número Factura</th>
                                    <th>Fecha Factura</th>
                                    <th>Nit</th>
                                    <th>Nombre Proveedor</th>
                                    <th>Pequeño Contribuyente</th>
                                    <th>Total Factura Bien</th>
                                    <th>Total Factura Servicio</th>
                                    <th>Combustible</th>
                                    <th>I.D.P.</th>
                                    <th>Base</th>
                                    <th>I.V.A.</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        <div class="DetalleFacturasLiquidacionSimple" style="display:none;">
                            <table border="1">
                                <thead>
                                    <tr>
                                        <th bgcolor="#2683ff"><font color="white"><b>Serie Factura</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Numero Factura</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Fecha Factura</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Nit</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Nombre Proveedor</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Pequeño Contribuyente</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Total Factura (Bien)</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Total Factura (Servicio)</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Combustible</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>I.D.P.</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Base</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>I.V.A.</b></font></th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                        <div class="Contabilizacion" style="display:none;">
                            <table border="1">
                                <thead>
                                    <tr>
                                        <th bgcolor="#2683ff"><font color="white"><b>Cuenta 1</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Cuenta 2</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Cuenta 3</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Valor</b></font></th>
                                        <th bgcolor="#2683ff"><font color="white"><b>Descripcion</b></font></th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <div class="col-md-6"></div>
                    <div class="col-md-2"><input type="button" id="DescargarExcel" value="Libro de Compras Excel" class="btn btn-primary btn-xs" /></div>
                    <div class="col-md-2"><input type="button" id="DescargarContabilizacion" value="Contabilizacion Excel" class="btn btn-primary btn-xs" /></div>
                    <div class="col-md-2"><input type="button" id="DescargarPDF" value="Exportar PDF" class="btn btn-primary btn-xs" runat="server"/></div>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>
</section>
</form>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/modernizr.min.js"></script>
<script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="js/toggles.min.js"></script>
<script type="text/javascript" src="js/retina.min.js"></script>
<script type="text/javascript" src="js/jquery.cookies.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript" src="js/fullcalendar.min.js"></script>
<script type="text/javascript" src="js/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<script type="text/javascript" src="js/jquery.gritter.min.js"></script>
<script type="text/javascript" src="js/jquery.datatables.min.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        $("#DescargarExcel").click(function (e) {
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.DetalleFacturasLiquidacionSimple').html()));
            e.preventDefault();
        });
        $("#DescargarContabilizacion").click(function (e) {
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.Contabilizacion').html()));
            e.preventDefault();
        });
        /* initialize the external events
        -----------------------------------------------------------------*/
        jQuery('#external-events div.external-event').each(function () {
            // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
            // it doesn't need to have a start or end
            var eventObject = {
                title: $.trim($(this).text()) // use the element's text as the event title
            };
            // store the Event Object in the DOM element so we can get to it later
            jQuery(this).data('eventObject', eventObject);
            // make the event draggable using jQuery UI
            jQuery(this).draggable({
                zIndex: 999,
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });
        });
        jQuery('.fecha').datepicker({
            numberOfMonths: 1,
            dateFormat: "yy-mm-dd",
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            closeOnSelect: true,
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        });
        jQuery('.DetalleFacturasLiquidacion').dataTable({ "sPaginationType": "full_numbers" });
        $("#BtnActualizaLiquidaciones").click(function () {
            if ($("#TxtFechaInicio").val() != "" && $("#TxtFechaFin").val() != "") {
                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/BuscarLiquidaciones",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFin").val() + "'}",
                    success: function (data) {
                        $(".Liquidaciones tbody").html("");
                        if (data.d.length != 0) {
                            $.each(data.d, function (index, item) {
                                if (item.StrError == "0") {
                                    $(".Liquidaciones tbody").append("<tr><td>" + item.Fecha + "</td><td>" + item.Usuario + "</td><td>" + item.Anticipo + "</td><td>" + item.TotalGastos + "</td><td>" + item.SaldoCargo + "</td><td>" + item.SaldoFavor + "</td><td class='table-action'><a class='delete-row VerLiquidacion' id='Liquidacion_" + item.IdLiquidacion + "'><i class='fa fa-search'></i></a></td></tr>")
                                } else {
                                    jQuery.gritter.add({
                                        title: 'Se Ha Producido Un Error!',
                                        text: item.StrError,
                                        class_name: 'growl-danger',
                                        image: 'images/screen.png',
                                        sticky: false,
                                        time: ''
                                    });
                                }
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
                    }
                })
            }
        });
        $(".Liquidaciones tbody").on("click", "tr td .VerLiquidacion", function () {
            var id = this.id.split("_");
            $.ajax({
                type: "POST",
                url: "WebService.asmx/BuscarLiquidacionesFactura",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{IdLiquidacion:'" + id[1] + "'}",
                beforeSend: function (data) { $('.DetalleFacturasLiquidacion').dataTable().fnClearTable(); $(".DetalleFacturasLiquidacionSimple tbody").html(""); },
                success: function (data) {
                    if (data.d.length != 0) {
                        $('.DetalleFacturasLiquidacion').dataTable().fnClearTable();
                        $(".DetalleFacturasLiquidacionSimple tbody").html("");
                        $.each(data.d, function (index, item) {
                            if (item.StrError == "0") {
                                $('.DetalleFacturasLiquidacion').dataTable().fnAddData([
                                            item.Serie,
											item.NumeroFactura,
											item.Fecha,
											item.Nit,
											item.NombreProveedor,
											parseFloat(item.FPQ).toFixed(2),
											parseFloat(item.FacturaBien).toFixed(2),
											parseFloat(item.FacturaServicio).toFixed(2),
                                            parseFloat(item.Combustible).toFixed(2),
                                            parseFloat(item.IDP).toFixed(2),
                                            parseFloat(item.Base).toFixed(2),
                                            parseFloat(item.IVA).toFixed(2)]);
                                $(".DetalleFacturasLiquidacionSimple tbody").append("<tr><td>" + item.Serie + "</td><td>" + item.NumeroFactura + "</td><td>" + item.Fecha + "</td><td>" + item.Nit + "</td><td>" + item.NombreProveedor + "</td><td>" + item.FPQ + "</td><td>" + item.FacturaBien + "</td><td>" + item.FacturaServicio + "</td><td>" + item.Combustible + "</td><td>" + item.IDP + "</td><td>" + item.Base + "</td><td>" + item.IVA + "</td></tr>");

                            } else {
                                jQuery.gritter.add({
                                    title: 'Se Ha Producido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false,
                                    time: ''
                                });
                            }
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
                },
                complete: function () {
                    $(".ListaFacturaLiquidaciones").modal('toggle');
                    $.ajax({
                        type: "POST",
                        url: "WebService.asmx/Contabilizacion",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{IdLiquidacion:'" + id[1] + "'}",
                        success: function (data) {
                            $(".Contabilizacion table tbody").html("");
                            console.log(data.d);
                            $.each(data.d, function (index, item) {
                                if (item.StrError == "0") {
                                    $(".Contabilizacion table tbody").append("<tr><td>" + item.Cuenta1 + "</td><td>" + item.Cuenta2 + "</td><td>" + item.Cuenta3 + "</td><td>" + item.Valor + "</td><td>" + item.Descripcion + "</td></tr>");
                                }
                            });
                        },
                        error: function () { }
                    });
                }
            })
        });
    });
</script>
</body>
</html>