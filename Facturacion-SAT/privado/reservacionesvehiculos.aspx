<%@ Page Language="VB" AutoEventWireup="false" CodeFile="reservacionesvehiculos.aspx.vb" Inherits="privado_reservacionesvehiculos" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="image/png" />
  <title>Reservación de Vehiculos | Monitoreo</title>
  <link type="text/css" href="css/style.default.css" rel="stylesheet" />
  <link type="text/css" href="css/fullcalendar.css" rel="stylesheet" />
  <link type="text/css" href="css/jquery.gritter.css" rel="stylesheet" />
      <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/colorpicker.css" />
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
      <!-- #INCLUDE FILE="usuariomenu.html" --> 
    </div>
    <div class="pageheader">
      <h2><i class="fa fa-calendar"></i> Reservaciones <span>Extras...</span></h2>
      <div class="breadcrumb-wrapper">
      <%--    <a href="#" style="cursor: pointer; font-weight:bold; font-style:italic; float:right " onclick=ExportToExcel()>Export to Excel</a>--%>
          <input id="btnExport" class="btn btn-primary" type="button" value="Exportar a Excel" /></div>
    </div>
    <div class="contentpanel">
      <div class="row">
      <div class="col-sm-3 col-md-3">
          <div class="panel panel-default panel-dark panel-alt">
            <div class="panel-heading">
              <h4 class="panel-title">Filtros</h4>
            </div>
            <div class="panel-body">
              <div id='Filtros'>
                   <label class="col-md-12">Estado Reservacion:</label>
                   <div class="col-md-12">
                        <asp:DropDownList ID="DropEstadoReservacion" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                   </div>
                </div>
              </div>
            </div>
          <div class="mb20"></div>
          <div class="row">
            <div class="col-xs-12">
              <div class="panel panel-default panel-dark panel-alt">
                <div class="panel-heading">
                  <h4 class="panel-title">Reservaciones Sin Gestionar</h4>
                </div>
                <div class="panel-body">
                  <div id='external-events'>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-9">
          <div id="calendar"></div>
        </div>
      </div>
    </div>
  </div>
<div class="modal fade ModalEntrega" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Entrega de Vehiculo a: <i><label id="LblNombreEntrega"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="TxtIdEntrega" />
             <div class="form-group">
                <label class="col-md-2">Fecha Transaccion:</label>
                <label id="lblFechaReservacion" class="col-md-2"></label>
                <label class="col-md-2">Fecha Aprobacion:</label>
                <label id="LblFechaAprobacionEn" class="col-md-2"></label>
                <label class="col-md-2">Fecha Asignacion:</label>
                <label id="LblFechaAsignacionEn" class="col-md-2"></label>
                <label class="col-md-2">Hora Transaccion:</label>
                <label id="lblHoraReservacion" class="col-md-2"></label>
                <label class="col-md-2">Hora Aprobacion:</label>
                <label id="LblHoraAprobacionEn" class="col-md-2"></label>
                <label class="col-md-2">Hora Asignacion:</label>
                <label id="LblHoraAsignacionEN" class="col-md-2"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Destino:</label>
                <label id="LblDestinoEntrega" class="col-md-3"></label>
                <label class="col-md-3">Tipo Vehiculo:</label>
                <label id="LblTipoVehiculoEntrega" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Fecha Inicio:</label>
                <label id="LblFechaInicioEntrega" class="col-md-3"></label>
                <label class="col-md-3">Fecha Fin:</label>
                <label id="LblFechaFinEntrega" class="col-md-3"></label>
            </div>
                 
            <div class="form-group">
                <label class="col-md-3">Observacion:</label>
                <label id="LblObservacionEntrega" class="col-md-3"></label>
                <label class="col-md-3">Vehiculo:</label>
                <label id="LblVehiculoEntrega" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <div class="btn-demo">
                        <input type="button" id="BtnEntregaReservacion" class="btn btn-primary" value="Entregar" />
                        <input type="button" class="btn btn-primary BtnReasignarUnidad" value="Re-asignar Unidad" />
                        <input type="button" class="btn btn-primary BtnCancelarReservacion" value="Cancelar Reservación" />
                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>
<div class="modal fade ModalDevuelve" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Devolucion de Vehiculo de: <i><label id="LblNombreDevuelve"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="TxtIdDevuelve" />
                <div class="form-group">
                <label class="col-md-2">Fecha Transaccion:</label>
                <label id="LblFechaReservacionD" class="col-md-2"></label>
                <label class="col-md-2">Fecha Aprobacion:</label>
                <label id="LblFechaAprobacion" class="col-md-2"></label>
                <label class="col-md-2">Fecha Asignacion:</label>
                <label id="LblFechaAsiganacion" class="col-md-2"></label>
                <label class="col-md-2">Hora Transaccion:</label>
                <label id="Label1" class="col-md-2"></label>
                <label class="col-md-2">Hora Aprobacion:</label>
                <label id="LblHoraAprobacion" class="col-md-2"></label>
                <label class="col-md-2">Hora Asignacion:</label>
                <label id="LblHoraAsiganacion" class="col-md-2"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Destino:</label>
                <label id="LblDestinoDevuelve" class="col-md-3"></label>
                <label class="col-md-3">Tipo Vehiculo:</label>
                <label id="LblTipoVehiculoDevuelve" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Fecha Inicio:</label>
                <label id="LblFechaInicioDevuelve" class="col-md-3"></label>
                <label class="col-md-3">Fecha Fin:</label>
                <label id="LblFechaFinDevuelve" class="col-md-3"></label>
            </div>
               <div class="form-group">
                <label class="col-md-3">Fecha Entrega:</label>
                <label id="LblFechaEntrega" class="col-md-3"></label>
                <label class="col-md-3">Hora Entrega:</label>
                <label id="LblHoraEntrega" class="col-md-3"></label>
         
            </div>
            <div class="form-group">
                <label class="col-md-3">Observacion:</label>
                <label id="LblObservacionDevuelve" class="col-md-3"></label>
                <label class="col-md-3">Vehiculo:</label>
                <label id="LblVehiculoDevuelve" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <div class="col-md-5">
                    <div class="btn-demo">
                        <input type="button" id="BtnRecibirReservacion" class="btn btn-primary" value="Recibir" />
                        <input type="button" id="BtnReimprimir" class="btn btn-primary" value="Re-imprimir ticket" />
                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>
<div class="modal fade ModalInfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Devolucion de Vehiculo de: <i><label id="LblNombreInfo"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="TxtIdInfo" />
            <div class="form-group">
                <label class="col-md-2">Fecha Transaccion:</label>
                <label id="LblFechaTransaccionInfo" class="col-md-2"></label>
                <label class="col-md-2">Fecha Aprobacion:</label>
                <label id="LblFechaAprobacionInfo" class="col-md-2"></label>
                <label class="col-md-2">Fecha Asignacion:</label>
                <label id="LblFechaAsignacionInfo" class="col-md-2"></label>
                <label class="col-md-2">Hora Transaccion:</label>
                <label id="LblHoraTransaccionInfo" class="col-md-2"></label>
                <label class="col-md-2">Hora Aprobacion:</label>
                <label id="LblHoraAprobacionInfo" class="col-md-2"></label>
                <label class="col-md-2">Hora Asignacion:</label>
                <label id="LblHoraAsignacionInfo" class="col-md-2"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Destino:</label>
                <label id="LblDestinoInfo" class="col-md-3"></label>
                <label class="col-md-3">Tipo Vehiculo:</label>
                <label id="LblTipoVehiculoInfo" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Fecha Inicio:</label>
                <label id="LblFechaInicioInfo" class="col-md-3"></label>
                <label class="col-md-3">Fecha Fin:</label>
                <label id="LblFechaFinInfo" class="col-md-3"></label>
            </div>

             <div class="form-group">
                <label class="col-md-3">Fecha Entrega:</label>
                <label id="LblFechaEntregaD" class="col-md-3"></label>
                 
                <label class="col-md-3">Fecha Devolucion:</label>
                <label id="LblFechaDevolucion" class="col-md-3"></label>
                <label class="col-md-3">Hora Entrega:</label>
                <label id="LblHoraEntregaD" class="col-md-3"></label>
                <label class="col-md-3">Hora Devolucion:</label>
                <label id="LblHoraDevolucion" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Observacion:</label>
                <label id="LblObservacionInfo" class="col-md-3"></label>
                <label class="col-md-3">Vehiculo:</label>
                <label id="LblVehiculoInfo" class="col-md-3"></label>
            </div>
            <div class="form-group">
            </div>
        </div>
    </div>
  </div>
</div>
<div class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Aprobar y Asignar Vehiculo a: <i><label id="LblNombreReservacion"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="TxtIdReservacion" />

             <div class="form-group">
                <label class="col-md-3">Fecha Transaccion:</label>
                <label id="lblFechaTransaccionR" class="col-md-3"></label>
                <label class="col-md-3">Fecha Aprobacion:</label>
                <label id="lblFechaAprobacionR" class="col-md-3"></label>
                <label class="col-md-3">Hora Transaccion:</label>
                <label id="lblHoraTransaccionR" class="col-md-3"></label>
                <label class="col-md-3">Hora Aprobacion:</label>
                <label id="lblHoraAprobacionR" class="col-md-3"></label>
                 </div>
            <div class="form-group">
                <label class="col-md-3">Destino:</label>
                <label id="LblDestinoReservacion" class="col-md-3"></label>
                <label class="col-md-3">Tipo Vehiculo:</label>
                <label id="LblTipoVehiculoReservacion" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Fecha Inicio:</label>
                <label id="LblFechaInicioReservacion" class="col-md-3"></label>
                <label class="col-md-3">Fecha Fin:</label>
                <label id="LblFechaFinReservacion" class="col-md-3"></label>
            </div>

          
            <div class="form-group">
                <label class="col-md-3">Observacion:</label>
                <label id="LblObservacionReservacion" class="col-md-3"></label>
                <label class="col-md-3">Vehiculo:</label>
                <div class="col-md-3">
                    <select id="DropVehiculo" class="form-control">
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3">Observacion:</label>
                <div class="col-md-4">
                    <textarea class="form-control" id="TxtObservacion"></textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-5">
                    <div class="btn-demo">
                        <input type="button" id="BtnAprobarReservacion" class="btn btn-primary" value="Aprobar" />
                        <input type="button" class="btn btn-primary BtnCancelarReservacion" value="Cancelar Reservación" />
                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>
            <div class="panel-body">
             

                <div class="TablaVehiculos" style="display:none;">
                            <table border="1">
                                <thead>
                                    <tr>
                            <th>FechaReservacion</th>
                            <th>HoraReservacion</th>
                            <th>FechaInicioReservacion</th>
                            <th>FechaFinReservacion</th>
                            <th>FechaAutorizacion</th>
                             <th>HoraAutorizacion</th>
                             <th>FechaAsignacion</th>
                             <th>HoraAsignacion</th>
                            
                            <th>FechaEntrega</th>
                            <th>HoraEntrega</th>
                            <th>FechaDevolucion</th>
                            <th>HoraDevolucion</th>
                            <th>vehiculo</th>
                            <td>titulo</td>
                            
                           
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
               
            </div><!-- panel-body -->
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
 

    
<%--        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="src/jquery.table2excel.js"></script>   --%>
<script src="js/jquery.datatables.min.js"></script>

<script type="text/javascript">
    jQuery(document).ready(function () {

        jQuery('#external-events div.external-event').each(function () {
            var eventObject = {
                title: $.trim($(this).text())
            };
            jQuery(this).data('eventObject', eventObject);
            jQuery(this).draggable({
                zIndex: 999,
                revert: true,
                revertDuration: 0
            })
        });
        jQuery('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            eventClick: function (calEvent, jsEvent, view) {
                if (calEvent.status == 0) {
                    llenarModal(calEvent.id, calEvent.status);
                    $('.bs-example-modal-static').modal('toggle')
                }
                if (calEvent.status == 1) {
                    llenarModalEntrega(calEvent.id, calEvent.status);
                    $('.ModalEntrega').modal('toggle')
                }
                if (calEvent.status == 3) {
                    llenarModalRegreso(calEvent.id, calEvent.status);
                    $('.ModalDevuelve').modal('toggle')
                }
                if (calEvent.status == 4) {
                    llenarModalInfo(calEvent.id, calEvent.status);
                    $('.ModalInfo').modal('toggle')
                }
            },
            editable: false,
            droppable: false,
            drop: function (date, allDay) {
                var originalEventObject = jQuery(this).data('eventObject');
                var copiedEventObject = $.extend({}, originalEventObject);
                copiedEventObject.start = date;
                copiedEventObject.allDay = allDay;
                jQuery('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
                if (jQuery('#drop-remove').is(':checked')) {
                    jQuery(this).remove()
                }
            }
        });
        llenarCalendario(0, "%");
        $("#external-events").on('click', '.external-event', function (event) {
            var id = this.id.split("_");
            llenarModal(id[1]);
            $('.bs-example-modal-static').modal('toggle')
        });
        $("#BtnAprobarReservacion").click(function () {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/AprobarReservacion",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                data: "{Id:'" + $("#TxtIdReservacion").val() + "', IdVehiculo:'" + $("#DropVehiculo").val() + "', Observacion: '" + $("#TxtObservacion").val() + "'}",
                success: function (data) {
                    if (data.d.length != 0) {
                        $.each(data.d, function (index, item) {
                            if (item.StrError == "0") {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Exito!',
                                    text: 'La Operacion Se Ha Realizado Correctamente.',
                                    class_name: 'growl-info',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                                llenarCalendario($("#TxtIdReservacion").val(), '%');
                                $('#calendar').fullCalendar('removeEvents', (event._id = $("#TxtIdReservacion").val()));
                                $("#event_" + $("#TxtIdReservacion").val()).remove();
                                $('.bs-example-modal-static').modal('toggle');
                                $("#TxtObservacion").val("")
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                })
                            }
                        })
                    }
                },
                error: function (data) {
                    console.log(data.responseText);
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    })
                }
            })
        });
        $("#<%=DropEstadoReservacion.ClientID %>").change(function () {
            $('#calendar').fullCalendar('removeEvents');
            llenarCalendario("0", $(this).val())
            $(".TablaVehiculos table tbody").html("");
        });
        $("#BtnEntregaReservacion").click(function () {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/EntregaReservacion",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{Id:" + $("#TxtIdEntrega").val() + "}",
                success: function (data) {
                    if (data.d.length != 0) {
                        $.each(data.d, function (index, item) {
                            if (item.StrError == "0") {
                                jQuery.gritter.add({
                                    title: 'Exito!',
                                    text: 'La Operacion Se Ha Realizado Correctamente.',
                                    class_name: 'growl-info',
                                    image: 'images/screen.png',
                                    sticky: false
                                });

                                window.location.href = "ReservacionAprobada.txt"
                                $('#calendar').fullCalendar('removeEvents', (event._id = $("#TxtIdEntrega").val()));
                                llenarCalendario($("#TxtIdEntrega").val(), '%');
                                $('.ModalEntrega').modal('toggle');
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                })
                            }
                        })
                    }
                },
                error: function (data) {
                    console.log(data);
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    })
                }
            })
        });
        $("#BtnRecibirReservacion").click(function () {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/RecibirReservacion",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{Id:'" + $("#TxtIdDevuelve").val() + "'}",
                success: function (data) {
                    if (data.d.length != 0) {
                        $.each(data.d, function (index, item) {
                            if (item.StrError == "0") {
                                jQuery.gritter.add({
                                    title: 'Exito!',
                                    text: 'La Operacion Se Ha Realizado Correctamente.',
                                    class_name: 'growl-info',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                                $('#calendar').fullCalendar('removeEvents', (event._id = $("#TxtIdDevuelve").val()));
                                llenarCalendario($("#TxtIdDevuelve").val(), '%');
                                $('.ModalDevuelve').modal('toggle')
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                })
                            }
                        })
                    }
                },
                error: function (data) {
                    console.log(data.responseText);
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    })
                }
            })
        });
        $(".BtnCancelarReservacion").click(function () {
            var pregunta = confirm("Seguro Que Quiere Cancelar Reservación?");
            if (pregunta == true) {
                var id = 0;
                if ($(".bs-example-modal-static").is(":visible")) {
                    id = $("#TxtIdReservacion").val()
                }
                if ($(".ModalEntrega").is(":visible")) {
                    id = $("#TxtIdEntrega").val()
                }
                if (id != 0) {
                    $.ajax({
                        type: "POST",
                        url: "WebService.asmx/CancelarReservacion",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{Id:'" + id + "'}",
                        success: function (data) {
                            if (data.d.length != 0) {
                                $.each(data.d, function (index, item) {
                                    if (item.StrError == "0") {
                                        jQuery.gritter.add({
                                            title: '¡Exito!',
                                            text: "La Operacion se ha realizado Correctamente.",
                                            class_name: 'growl-success',
                                            image: 'images/screen.png',
                                            sticky: false,
                                            time: ''
                                        });
                                        if ($(".bs-example-modal-static").is(":visible")) {
                                            $('.bs-example-modal-static').modal('toggle')
                                        }
                                        if ($(".ModalEntrega").is(":visible")) {
                                            $('.ModalEntrega').modal('toggle')
                                        }
                                        $('#calendar').fullCalendar('removeEvents', (event._id = id));
                                        llenarCalendario(id, '%')
                                    } else {
                                        jQuery.gritter.add({
                                            title: '¡Se Ha Producido Un Error!',
                                            text: item.StrError,
                                            class_name: 'growl-danger',
                                            image: 'images/screen.png',
                                            sticky: false,
                                            time: ''
                                        })
                                    }
                                })
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
                            })
                        }
                    })
                } else {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: 'Se Ha Producido Un Error, Porfavor Intentar de Nuevo',
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    })
                }
            }
        });
        $("#BtnReimprimir").click(function () {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/ReImprimirReservacion",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                data: "{Id:'" + $("#TxtIdDevuelve").val() + "'}",
                success: function (data) {
                    if (data.d.length != 0) {
                        $.each(data.d, function (index, item) {
                            if (item.StrError == "0") {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Exito!',
                                    text: 'La Operacion Se Ha Realizado Correctamente.',
                                    class_name: 'growl-info',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                                window.open("ReservacionAprobada.txt", '_blank');
                                //window.location = "ReservacionAprobada.txt";
                                $('.ModalDevuelve').modal('toggle')
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                })
                            }
                        })
                    }
                },
                error: function (data) {
                    console.log(data.responseText);
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    })
                }
            })
        });
        $(".BtnReasignarUnidad").click(function () {
            llenarModal($("#TxtIdEntrega").val(), "%");
            $('.bs-example-modal-static').modal('toggle')
        })
    });

    function llenarCalendario(id, Estado) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/ReservacionesVehiculos",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Id:'" + id + "', Estado:'" + Estado + "'}",
            success: function (data) {
                if (data.d.length != 0) {
                    $.each(data.d, function (index, item) {
                        if (item.StrError == "0") {
                            var titulo = item.title;
                            if (item.vehiculo != 0) {
                                titulo = titulo + " | " + item.vehiculo
                            }
                            var myEvent = {
                                id: item.id,
                                title: titulo,
                                allDay: item.allDay,
                                start: item.start,
                                end: item.ends,
                                status: item.status,
                                tipoVehiculo: item.tipoVehiculo,
                                destino: item.destino,
                                observacion: item.observacion,
                                vehiculo: item.vehiculo,
                                backgroundColor: item.color,
                                borderColor: item.color,
                                fechaEntrega: item.FechaEntrega,
                                fechaDevolucion: item.FechaDevolucion,
                                horaEntrega: item.HoraEntrega,
                                horaDevolucion: item.HoraDevolucion,
                                fechaReservacion: item.FechaReservacion,
                                fechaAutorizacion: item.FechaAutorizacion,
                                horaReservacion: item.HoraReservacion,
                                horaAutorizacion: item.HoraAutorizacion,

                                fechaAsignacion: item.FechaAsignacion,
                                horaAsignacion: item.HoraAsignacion


                            };
                            
                          
                                    $(".TablaVehiculos table tbody").append("<tr><td>" + item.FechaReservacion + "</td><td>" + item.HoraReservacion + "</td><td>" + item.start + "</td><td>" + item.ends + "</td><td>" + item.FechaAutorizacion + "</td><td>" + item.HoraAutorizacion + "</td><td>" + item.FechaAsignacion + "</td><td>" + item.HoraAsignacion + "</td>><td>" + item.FechaEntrega + "</td><td>" + item.HoraEntrega + "</td><td>" + item.FechaDevolucion + "</td><td>" + item.HoraDevolucion + "</td><td>" + item.vehiculo + "</td><td>" + titulo + "</td></tr>");
                     



                            jQuery('#calendar').fullCalendar('renderEvent', myEvent, true);
                            if (item.status == 0) {
                                $("#event_" + item.id).remove();
                                $("#external-events").append("<div class='external-event' id='event_" + item.id + "' data-toggle='modal' data-target='.bs-example-modal-static' style='background-color:#cc0202'>" + item.title + "</div>")
                            }
                        } else { }
                    })
                }
            }
        })
    };

    function llenarModal(id, estado) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/CargarVehiculosReservacion",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Id:'" + id + "'}",
            success: function (data) {
                if (data.d.length != 0) {
                    var Empresa = "";
                    $("#DropVehiculo").html("");
                    $.each(data.d, function (index, item) {
                        if (item.StrError == "0") {
                            if (item.Empresa != Empresa) {
                                $("#DropVehiculo").append("<optgroup label='" + item.Empresa + "'></optgroup>");
                                Empresa = item.Empresa
                            }
                            $("#DropVehiculo").append("<option value='" + item.Id + "'>" + item.Codigo + "</option>")
                        } else { }
                    })
                }
            }
        });
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        $("#LblNombreReservacion").html(array[0].title);
        $("#LblTipoVehiculoReservacion").html(array[0].tipoVehiculo);
        $("#LblFechaInicioReservacion").html(array[0].start);
        $("#LblFechaFinReservacion").html(array[0].end);
        $("#LblDestinoReservacion").html("");

        $("#lblFechaTransaccionR").html(array[0].fechaReservacion);
        $("#lblFechaAprobacionR").html(array[0].fechaAsignacion);

        $("#lblHoraTransaccionR").html(array[0].horaReservacion);
        $("#lblHoraAprobacionR").html(array[0].horaAsignacion);



        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoReservacion").append(item.Destino)
            } else {
                $("#LblDestinoReservacion").append("<br />" + item.Destino)
            }
        });
        $("#LblObservacionReservacion").html(array[0].observacion);
        $("#TxtIdReservacion").val(array[0].id)
    };

    function llenarModalEntrega(id, estado) {
        console.log(event)
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        $("#LblNombreEntrega").html(array[0].title);
        $("#LblTipoVehiculoEntrega").html(array[0].tipoVehiculo);
        $("#LblFechaInicioEntrega").html(array[0].start);
        $("#LblFechaFinEntrega").html(array[0].end);

        $("#lblFechaReservacion").html(array[0].fechaReservacion);
        $("#LblFechaAprobacionEn").html(array[0].fechaAsignacion);
        $("#LblFechaAsignacionEn").html(array[0].fechaAutorizacion);
        $("#lblHoraReservacion").html(array[0].horaReservacion);
        $("#LblHoraAprobacionEn").html(array[0].horaAsignacion);
        $("#LblHoraAsignacionEN").html(array[0].horaAutorizacion)



        $("#LblDestinoEntrega").html("");
        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoEntrega").append(item.Destino)
            } else {
                $("#LblDestinoEntrega").append("<br />" + item.Destino)
            }
        });
        $("#LblObservacionEntrega").html(array[0].observacion);
        $("#LblVehiculoEntrega").html(array[0].vehiculo);
        $("#TxtIdEntrega").val(array[0].id)
    };

    function llenarModalRegreso(id, estado) {
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));


        $("#LblFechaReservacionD").html(array[0].fechaReservacion);
        $("#LblFechaAprobacion").html(array[0].fechaAsignacion);
        $("#LblFechaAsiganacion").html(array[0].fechaAutorizacion);
        $("#LblHoraReservacion").html(array[0].horaReservacion);
        $("#LblHoraAprobacion").html(array[0].horaAsignacion);

        $("#LblHoraAsiganacion").html(array[0].horaAutorizacion)

        $("#LblNombreDevuelve").html(array[0].title);
        $("#LblTipoVehiculoDevuelve").html(array[0].tipoVehiculo);

        $("#LblFechaInicioDevuelve").html(array[0].start);
        $("#LblFechaFinDevuelve").html(array[0].end);

        $("#LblFechaEntrega").html(array[0].fechaEntrega);
        $("#LblHoraEntrega").html(array[0].horaEntrega);


        $("#LblDestinoDevuelve").html("");
        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoDevuelve").append(item.Destino)
            } else {
                $("#LblDestinoDevuelve").append("<br />" + item.Destino)
            }
        });
        $("#LblObservacionDevuelve").html(array[0].observacion);
        $("#LblVehiculoDevuelve").html(array[0].vehiculo);
        $("#TxtIdDevuelve").val(array[0].id)
    };

    function llenarModalInfo(id, estado) {
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        $("#LblNombreInfo").html(array[0].title);
        $("#LblTipoVehiculoInfo").html(array[0].tipoVehiculo);
        $("#LblFechaInicioInfo").html(array[0].start);
        $("#LblFechaFinInfo").html(array[0].end);
        $("#LblDestinoInfo").html("");

        $("#LblFechaEntregaD").html(array[0].fechaEntrega);

        $("#LblFechaDevolucion").html(array[0].fechaDevolucion);
        $("#LblHoraEntregaD").html(array[0].horaEntrega);
        $("#LblHoraDevolucion").html(array[0].horaDevolucion);

        $("#LblFechaTransaccionInfo").html(array[0].fechaReservacion);
        $("#LblFechaAprobacionInfo").html(array[0].fechaAsignacion);
        $("#LblFechaAsignacionInfo").html(array[0].fechaAutorizacion);
        $("#LblHoraTransaccionInfo").html(array[0].horaReservacion);
        $("#LblHoraAprobacionInfo").html(array[0].horaAsignacion);

        $("#LblHoraAsignacionInfo").html(array[0].horaAutorizacion)
        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoInfo").append(item.Destino)
            } else {
                $("#LblDestinoInfo").append("<br />" + item.Destino)
            }
        });
        $("#LblObservacionInfo").html(array[0].observacion);
        $("#LblVehiculoInfo").html(array[0].vehiculo);
        $("#TxtIdInfo").val(array[0].id)
    };



    $("#btnExport").click(function () {




        window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.TablaVehiculos').html()));
        e.preventDefault();

    });







</script>
</body>
</html>
