<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ProgramacionUnidad.aspx.vb" Inherits="privado_ProgramacionUnidad" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es"
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/png" />
  <title>Programacíon de Unidad | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/fullcalendar.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
  <link href="css/jquery.datatables.css" rel="stylesheet" />
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
  <style type="text/css">
  .DataTables_sort_icon { display:none;}
  .error {border: solid 1px red;}
  .error:focus {border: solid 1px red;}
  </style>
</head>
<body>
<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<form class="form-horizontal form-bordered" runat="server" id="formulario">
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
      <h2><i class="fa fa-calendar"></i> Programacíon de Unidades <span>Reporte...</span></h2>
      <div class="breadcrumb-wrapper">
      </div>
    </div>
    <div class="contentpanel">
        <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding">
            <div class="form-group">
              <label class="col-sm-2 control-label">Fecha</label>
              <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="input-group">
                        <input type="text" class="form-control fecha" placeholder="yyyy-mm" id="TxtFechaInicio" runat ="server"  />
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
                 <label class="col-sm-2 control-label" id="lbl_mes" runat ="server"></label>
                   <table class="table mb30 Liquidaciones Reservaciones">                     
                        <thead>
                            <tr>                               
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
      <%--  <div class="panel-footer">
			 <div class="row">
				<div class="col-sm-1 col-sm-offset-10">
				  <button class="btn btn-primary" id="BtnAgregarProducto">Agregar</button>&nbsp;
				</div>
			 </div>
		  </div><!-- panel-footer -->--%>
      </div><!-- panel -->
    </div>
  </div>
<div class="modal fade ListaFacturaLiquidaciones" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
  </div>
</div>
<div class="modal fade ModalCompetidor" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-body">
          <div class="tab-content mb30">
          <div class="tab-pane active" id="home2">
            <input id="TxtIdVehiculoReservacion" type="hidden" readOnly />
            <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                   <table class="table mb30 ListadoReservaciones">                     
                        <thead>
                            <tr>  
                            <th>Unidad</th><th>Nombre</th><th>Fecha Inicio</th><th>Fecha Fin</th>                             
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
          </div>
        </div>
        </div>
    </div>
</div>
</div>
<div class="modal fade ModalOT" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="panel-heading">
            <h4 class="panel-title">Programación Orden de Trabajo <i>(Servicios)</i></h4>
        </div>
        <div class="modal-body">
            <input id="TxtIdVehiculo" type="hidden" readOnly />
            <div class="row">
                <div class="form-group">
                    <label class="col-md-3 control-label">Orden de Trabajo</label>
                    <div class="col-md-3">
                        <input type="text" class="form-control" id="TxtOrdenTrabajo" name="TxtOrdenTrabajo" readonly />
                    </div>
                    <label class="col-md-3 control-label">Kilometraje</label>
                    <div class="col-md-3">
                        <input type="text" class="form-control" id="TxtKilometraje" name="TxtKilometraje" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                       <table class="table mb30 ListadoOT">                     
                            <thead>
                                <tr><th>Clasificacion</th><th>Servicio</th><th>Descripcion</th><th>Observacion</th><th></th></tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</section>
</form>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script src="js/jquery-ui-1.10.3.min.js"></script>
<script src="js/fullcalendar.min.js"></script>
<script src="js/jquery.ui.touch-punch.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/jquery.gritter.min.js"></script>
<script src="js/jquery.datatables.min.js"></script>
<script>
    jQuery(document).ready(function () {
        $("#DescargarExcel").click(function (e) {
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.DetalleFacturasLiquidacionSimple').html()));
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
            dateFormat: "yy-mm",
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            closeOnSelect: true,
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        });
        jQuery('.ListadoReservaciones').DataTable({ "sPaginationType": "full_numbers" });
        $(".Reservaciones tbody").on("click", ".btn-success", function (event) {
            if ($("#TxtFechaInicio").val() != "") {
                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/BuscarReservacionesDetalle",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{Fecha:'" + $("#TxtFechaInicio").val() + "', id:'" + $(this).parent().attr("id").split("_")[1] + "', dia:'" + $(this).index() + "'}",
                    success: function (data) {
                        if (data.d.length != 0) {
                            jQuery('.ListadoReservaciones').DataTable().fnClearTable();
                            $.each(data.d, function (index, item) {
                                if (item.StrError == "0") {
                                    jQuery('.ListadoReservaciones').DataTable().fnAddData([item.unidad, item.nombre, item.fechainicio, item.fechafin]);
                                    // $(".ListadoReservaciones tbody").append("<tr><td>" + item.unidad + "</td><td>" + item.nombre + "</td><td>" + item.fechainicio + "</td><td>" + item.fechafin + "</td></tr>");
                                } else {
                                    jQuery.gritter.add({
                                        titlse: 'Se Ha Producido Un Error!',
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
                    complete: function () { $(".ModalCompetidor").modal("toggle"); }
                })
            }
        });
        $(".Reservaciones tbody").on("click", ".btn-danger", function (event) {
            $("#TxtOrdenTrabajo").val($(this).attr("id-ot"));
            $.ajax({
                type: "POST",
                url: "WebService.asmx/BuscarReservacionOT",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{IdOT:'" + $(this).attr("id-ot") + "'}",
                success: function (data) {
                    if (data.d.length != 0) {
                        jQuery('.ListadoOT').DataTable().fnClearTable();
                        $.each(data.d, function (index, item) {
                            if (item.StrError == "0") {
                                jQuery('.ListadoOT').DataTable().fnAddData([item.Clasificacion, item.Servicio, item.Descripcion, "<input type='text' class='form-control' placeholder='Observacion de Cierre' id='TxtObservacion_" + item.IdOT + "' />", "<input type='button' class='btn btn-xs btn-danger BtnCerrarOrden' id-otd='" + item.IdOT + "' value='Cerrar' />"]);
                            } else {
                                jQuery.gritter.add({ titlse: 'Se Ha Producido Un Error!', text: item.StrError, class_name: 'growl-danger', image: 'images/screen.png', sticky: false, time: '' });
                            }
                        });
                    }
                },
                error: function (data) {
                    jQuery.gritter.add({ title: 'Se Ha Producido Un Error!', text: data.responseText, class_name: 'growl-danger', image: 'images/screen.png', sticky: false, time: '' });
                },
                complete: function () { $(".ModalOT").modal("toggle"); }
            });
        });
        $(".ListadoOT").on("click", ".BtnCerrarOrden", function () {
            if ($("#TxtKilometraje").val() != "") {
                $("#TxtKilometraje").removeClass("error");
                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/CerrarOT",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{IdOT:'" + $(this).attr("id-otd") + "', Kilometraje: '" + $("#TxtKilometraje").val() + "', descripcionCierre:'" + $("#TxtObservacion_" + $(this).attr("id-otd")).val() + "'}",
                    success: function (data) {
                        console.log(data);
                        if (data.d.length != 0) {
                            $.each(data.d, function (index, item) {
                                if (item.StrError == "0") {
                                    jQuery.gritter.add({
                                        title: 'Exito!',
                                        text: 'La Operacion se Realizo Correctamente.',
                                        class_name: 'growl-success',
                                        image: 'images/screen.png',
                                        sticky: false,
                                        time: ''
                                    });
                                    $(".ModalOT").modal("toggle");
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
                });
            } else {
                $("#TxtKilometraje").addClass("error");
                $("#TxtKilometraje").focus();
            }
        });
        $("#BtnActualizaLiquidaciones").click(function () {
            if ($("#TxtFechaInicio").val() != "") {
                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/BuscarReservaciones",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{Fecha:'" + $("#TxtFechaInicio").val() + "'}",
                    success: function (data) {
                        $(".Reservaciones tbody").html("");
                        $(".Reservaciones thead tr").html("");
                        if (data.d.length != 0) {
                            $.each(data.d, function (index, item) {
                                if (item.StrError == "0") {
                                    var d = 1;
                                    $(".Reservaciones thead tr").append("<th>Unidad</th>");
                                    while (d <= item.diasmes) {
                                        $(".Reservaciones thead tr").append("<th>" + d + "</th>");
                                        d++;
                                    };
                                    $(".Reservaciones tbody").html("");
                                    $.each(item.Unidad, function (ind, i) {
                                        $(".Reservaciones tbody").append("<tr id='row_" + i[0] + "'><td style='border: solid 1px #EEEEEE;'>" + i[1] + "</td></tr>");
                                        var d = 1;
                                        while (d <= item.diasmes) {
                                            $("#row_" + i[0]).append("<td style='border: solid 1px #EEEEEE;'></td>");
                                            d++;
                                        };
                                        $.each(i[2], function (inde, j) {
                                            while (j[0] <= j[1]) {
                                                if (j[2] == 2) {
                                                    if (j[4] == 4) {
                                                        $("#row_" + i[0] + " td:eq(" + j[0] + ")").removeClass("btn-success").addClass("btn-primary").attr("id-ot", j[3]);
                                                    } else {
                                                        $("#row_" + i[0] + " td:eq(" + j[0] + ")").removeClass("btn-success").addClass("btn-danger").attr("id-ot", j[3]);
                                                    }
                                                } else if (j[2] == 1) {
                                                    $("#row_" + i[0] + " td:eq(" + j[0] + ")").addClass("btn-success");
                                                }
                                                j[0]++;
                                            }
                                        });
                                    });
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
    });
</script>
</body>
</html>