<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Reservaciones.aspx.vb" Inherits="privado_Reservaciones" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es"
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Reservación de Vehiculos | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/fullcalendar.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
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
      <h2><i class="fa fa-calendar"></i> Reservaciones <span>Extras...</span></h2>
      <div class="breadcrumb-wrapper">
      </div>
    </div>
    
    <div class="contentpanel">
      <%--<p class="mb20"><a href="http://arshaw.com/fullcalendar/" target="_blank">FullCalendar</a> is a jQuery plugin that provides a full-sized, drag & drop calendar like the one below. It uses AJAX to fetch events on-the-fly for each month and is easily configured to use your own feed format (an extension is provided for Google Calendar).</p>--%>
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
          <div class="mb20"></div>
          
          <div class="row">
            <div class="col-xs-12">
              <div class="panel panel-default panel-dark panel-alt">
                <div class="panel-heading">
                  <h4 class="panel-title">Detalle de Colores</h4>
                </div>
                <div class="panel-body">
                  <div id='Div1'>
                    <div class="external-event" style="background-color:#cc0202">Solicitud</div>
                    <div class="external-event" style="background-color:gray">Cancelado</div>
                    <div class="external-event" style="background-color:green">Aprobado</div>
                    <div class="external-event" style="background-color:#428BCA">Entregado</div>
                    <div class="external-event" style="background-color:#1f598a">Devuelto</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div><!-- col-sm-6 -->
        <div class="col-md-9">
          <div id="calendar"></div>
        </div><!-- col-md-9 -->
      </div>
    </div>
    
  </div><!-- mainpanel -->
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
                <label class="col-md-3">Observacion:</label>
                <label id="LblObservacionDevuelve" class="col-md-3"></label>
                <label class="col-md-3">Vehiculo:</label>
                <label id="LblVehiculoDevuelve" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <div class="col-md-5">
                    
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
                <%--<label class="col-md-3">Vehiculo:</label>
                <div class="col-md-3">
                    <select id="DropVehiculo" class="form-control">
                    </select>
                </div>--%>
            </div>
            <%--<div class="form-group">
                <label class="col-md-3">Observacion:</label>
                <div class="col-md-4">
                    <textarea class="form-control" id="TxtObservacion"></textarea>
                </div>
            </div>--%>
            <div class="form-group">
                <div class="col-md-5">
                    
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
<script>
    jQuery(document).ready(function () {
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
        /* initialize the calendar
        -----------------------------------------------------------------*/
        jQuery('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            eventClick: function (calEvent, jsEvent, view) {
                if (calEvent.status == 0) {
                    llenarModal(calEvent.id, calEvent.status);
                    $('.bs-example-modal-static').modal('toggle');
                }
                if (calEvent.status == 1) {
                    llenarModalEntrega(calEvent.id, calEvent.status);
                    $('.ModalEntrega').modal('toggle');
                }
                if (calEvent.status == 3) {
                    llenarModalRegreso(calEvent.id, calEvent.status);
                    $('.ModalDevuelve').modal('toggle');
                }
                if (calEvent.status == 4) {
                    llenarModalInfo(calEvent.id, calEvent.status);
                    $('.ModalInfo').modal('toggle');
                }
                // if (calEvent.status == 3) {
                //   llenarModalRegreso(calEvent.id, calEvent.status);
                //     $('.ModalDevuelve').modal('toggle');
                // }
                //                alert('Event: ' + calEvent.title);
                //                // alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
                //                alert('status: ' + calEvent.status);

                // change the border color just for fun
                //$(this).css('border-color', 'red');

            },
            editable: false,
            droppable: false, // this allows things to be dropped onto the calendar !!!
            drop: function (date, allDay) { // this function is called when something is dropped

                // retrieve the dropped element's stored Event Object
                var originalEventObject = jQuery(this).data('eventObject');

                // we need to copy it, so that multiple events don't have a reference to the same object
                var copiedEventObject = $.extend({}, originalEventObject);

                // assign it the date that was reported
                copiedEventObject.start = date;
                copiedEventObject.allDay = allDay;

                // render the event on the calendar
                // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                jQuery('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

                // is the "remove after drop" checkbox checked?
                if (jQuery('#drop-remove').is(':checked')) {
                    // if so, remove the element from the "Draggable Events" list
                    jQuery(this).remove();
                }

            }
        });
        llenarCalendario(0, "%");
        //----QUITAR EVENTO
        //                $("#external-events").on('click', '.external-event', function (event) {
        //                    var id = this.id.split("_")
        //                    $('#calendar').fullCalendar('removeEvents', function (event) {
        //                        if (event.id = id[1])
        //                            return true;
        //                    });
        //                });

        $("#external-events").on('click', '.external-event', function (event) {
            var id = this.id.split("_")
            llenarModal(id[1]);
            $('.bs-example-modal-static').modal('toggle');
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
                                $("#TxtObservacion").val("");
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                            }
                        });
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
                    });
                }
            });
        });
        $("#<%=DropEstadoReservacion.ClientID %>").change(function () {
            $('#calendar').fullCalendar('removeEvents');
            llenarCalendario("0", $(this).val());
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
                                // console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Exito!',
                                    text: 'La Operacion Se Ha Realizado Correctamente.',
                                    class_name: 'growl-info',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                                $('#calendar').fullCalendar('removeEvents', (event._id = $("#TxtIdEntrega").val()));
                                llenarCalendario($("#TxtIdEntrega").val(), '%');
                                $('.ModalEntrega').modal('toggle');
                                // if (jQuery.browser.Mozilla) {
                                window.location = "ReservacionAprobada.txt";

                                //} else {
                                //location.href = "privado/ReservacionAprobada.txt"
                                // alert("...");
                                //}
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                            }
                        });
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
                    });
                }
            });
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
                                // console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Exito!',
                                    text: 'La Operacion Se Ha Realizado Correctamente.',
                                    class_name: 'growl-info',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                                $('#calendar').fullCalendar('removeEvents', (event._id = $("#TxtIdDevuelve").val()));
                                llenarCalendario($("#TxtIdDevuelve").val(), '%');
                                $('.ModalDevuelve').modal('toggle');
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                            }
                        });
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
                    });
                }
            });
        });
        $(".BtnCancelarReservacion").click(function () {
            var pregunta = confirm("Seguro Que Quiere Cancelar Reservación?");
            if (pregunta == true) {
                var id = 0;
                if ($(".bs-example-modal-static").is(":visible")) {
                    id = $("#TxtIdReservacion").val();
                }
                if ($(".ModalEntrega").is(":visible")) {
                    id = $("#TxtIdEntrega").val();
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
                                            $('.bs-example-modal-static').modal('toggle');
                                        }
                                        if ($(".ModalEntrega").is(":visible")) {
                                            $('.ModalEntrega').modal('toggle');
                                        }
                                        $('#calendar').fullCalendar('removeEvents', (event._id = id));
                                        llenarCalendario(id, '%');
                                    } else {
                                        jQuery.gritter.add({
                                            title: '¡Se Ha Producido Un Error!',
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
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: 'Se Ha Producido Un Error, Porfavor Intentar de Nuevo',
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
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
                                window.location = "ReservacionAprobada.txt";
                                $('.ModalDevuelve').modal('toggle');
                            } else {
                                console.log(item.StrError);
                                jQuery.gritter.add({
                                    title: 'Ha Ocurrido Un Error!',
                                    text: item.StrError,
                                    class_name: 'growl-danger',
                                    image: 'images/screen.png',
                                    sticky: false
                                });
                            }
                        });
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
                    });
                }
            });
        });
        $(".BtnReasignarUnidad").click(function () {
            llenarModal($("#TxtIdEntrega").val(), "%");
            $('.bs-example-modal-static').modal('toggle');
        });
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
                                titulo = titulo + " | " + item.vehiculo;
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
                                borderColor: item.color
                            };
                            jQuery('#calendar').fullCalendar('renderEvent', myEvent, true);
                            if (item.status == 0) {
                                $("#event_" + item.id).remove();
                                $("#external-events").append("<div class='external-event' id='event_" + item.id + "' data-toggle='modal' data-target='.bs-example-modal-static' style='background-color:#cc0202'>" + item.title + "</div>")
                            }
                        } else {
                            console.log(data.d);
                        }
                    });
                }
            }
        });
    }
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
                                Empresa = item.Empresa;
                            }
                            $("#DropVehiculo").append("<option value='" + item.Id + "'>" + item.Codigo + "</option>");
                        } else {
                            //console.log(data.d);
                        }
                    });
                }
            }
        });
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        $("#LblNombreReservacion").html(array[0].title);
        $("#LblTipoVehiculoReservacion").html(array[0].tipoVehiculo);
        $("#LblFechaInicioReservacion").html(array[0].start);
        $("#LblFechaFinReservacion").html(array[0].end);
        $("#LblDestinoReservacion").html("");
        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoReservacion").append(item.Destino);
            } else {
                $("#LblDestinoReservacion").append("<br />" + item.Destino);
            }
        });
        $("#LblObservacionReservacion").html(array[0].observacion);
        $("#TxtIdReservacion").val(array[0].id);
    }
    function llenarModalEntrega(id, estado) {
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        //console.log(array)
        $("#LblNombreEntrega").html(array[0].title);
        $("#LblTipoVehiculoEntrega").html(array[0].tipoVehiculo);
        //var fechaInicio = .getFullYear() + "-" + parseInt(array[0].start.getMonth() + 1) + "-" + array[0].start.getDate() + " " + array[0].start.getHours() + ":" + array[0].start.getMinutes() + ":" + array[0].start.getSeconds();
        $("#LblFechaInicioEntrega").html(array[0].start);
        $("#LblFechaFinEntrega").html(array[0].end);
        $("#LblDestinoEntrega").html("");
        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoEntrega").append(item.Destino);
            } else {
                $("#LblDestinoEntrega").append("<br />" + item.Destino);
            }
        });
        $("#LblObservacionEntrega").html(array[0].observacion);
        $("#LblVehiculoEntrega").html(array[0].vehiculo);
        $("#TxtIdEntrega").val(array[0].id);
    }
    function llenarModalRegreso(id, estado) {
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        //console.log(array)
        $("#LblNombreDevuelve").html(array[0].title);
        $("#LblTipoVehiculoDevuelve").html(array[0].tipoVehiculo);
        //var fechaInicio = .getFullYear() + "-" + parseInt(array[0].start.getMonth() + 1) + "-" + array[0].start.getDate() + " " + array[0].start.getHours() + ":" + array[0].start.getMinutes() + ":" + array[0].start.getSeconds();
        $("#LblFechaInicioDevuelve").html(array[0].start);
        $("#LblFechaFinDevuelve").html(array[0].end);
        $("#LblDestinoDevuelve").html("");
        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoDevuelve").append(item.Destino);
            } else {
                $("#LblDestinoDevuelve").append("<br />" + item.Destino);
            }
        });
        $("#LblObservacionDevuelve").html(array[0].observacion);
        $("#LblVehiculoDevuelve").html(array[0].vehiculo);
        $("#TxtIdDevuelve").val(array[0].id);
    }
    function llenarModalInfo(id, estado) {
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        //console.log(array)
        $("#LblNombreInfo").html(array[0].title);
        $("#LblTipoVehiculoInfo").html(array[0].tipoVehiculo);
        //var fechaInicio = .getFullYear() + "-" + parseInt(array[0].start.getMonth() + 1) + "-" + array[0].start.getDate() + " " + array[0].start.getHours() + ":" + array[0].start.getMinutes() + ":" + array[0].start.getSeconds();
        $("#LblFechaInicioInfo").html(array[0].start);
        $("#LblFechaFinInfo").html(array[0].end);
        $("#LblDestinoInfo").html("");
        $.each(array[0].destino, function (index, item) {
            if (index == 0) {
                $("#LblDestinoInfo").append(item.Destino);
            } else {
                $("#LblDestinoInfo").append("<br />" + item.Destino);
            }
        });
        $("#LblObservacionInfo").html(array[0].observacion);
        $("#LblVehiculoInfo").html(array[0].vehiculo);
        $("#TxtIdInfo").val(array[0].id);
    }
</script>
</body>
</html>
