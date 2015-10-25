<<%@ Page Language="VB" AutoEventWireup="false" CodeFile="calendarizacionvehiculo.aspx.vb" Inherits="privado_calendarizacionvehiculo" %>
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
      <h2><i class="fa fa-calendar"></i> Calendario Vehiculo <span>Reservaciones...</span></h2>
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
                   <label class="col-md-12">Vehiculo:</label>
                   <div class="col-md-12">
                        <asp:DropDownList ID="DropVehiculo" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                   </div>
                </div>
              </div>
            </div>
          <div class="mb20"></div>
        </div><!-- col-sm-6 -->
        <div class="col-md-9">
          <div id="calendar"></div>
        </div><!-- col-md-9 -->
      </div>
    </div>
  </div><!-- mainpanel -->
<div class="modal fade modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Especificación: <i><label id="LblNombreReservacion"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="TxtIdReservacion" />
            <div class="form-group">
                <label class="col-md-3">Destino:</label>
                <label id="LblDestinoReservacion" class="col-md-3"></label>
                <label class="col-md-3">Observacion:</label>
                <label id="LblObservacionReservacion" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Fecha Inicio:</label>
                <label id="LblFechaInicioReservacion" class="col-md-3"></label>
                <label class="col-md-3">Fecha Fin:</label>
                <label id="LblFechaFinReservacion" class="col-md-3"></label>
            </div>
            <div class="form-group">
                <label class="col-md-3">Fecha Entrega:</label>
                <label id="LblFechaEntregaReservacion" class="col-md-3"></label>
                <label class="col-md-3">Fecha Devolucion:</label>
                <label id="LblFechaDevolucionReservacion" class="col-md-3"></label>
           
                <label class="col-md-3">Hora Entrega:</label>
                <label id="LblHoraEntregaReservacion" class="col-md-3"></label>
                <label class="col-md-3">Hora Devolucion:</label>
                <label id="LblHoraDevolucionReservacion" class="col-md-3"></label>
            </div>
            <!--<div class="form-group">
                <div class="col-md-5">
                    <div class="btn-demo">
                        <input type="button" id="BtnAprobarReservacion" class="btn btn-primary" value="Aprobar" />
                        <input type="button" class="btn btn-primary BtnCancelarReservacion" value="Cancelar Reservación" />
                    </div>
                </div>
            </div>-->
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
<script src="js/chosen.jquery.min.js"></script>
<script>
    jQuery(document).ready(function () {
        $("#<%=DropVehiculo.ClientID %>").chosen({ 'width': '100%', 'white-space': 'nowrap' });
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
                llenarModal(calEvent.id);
                $('.modal').modal('toggle');
                // if (calEvent.status == 0) {
                //   llenarModal(calEvent.id, calEvent.status);
                // $('.bs-example-modal-static').modal('toggle');
                //}
                //if (calEvent.status == 1) {
                //  llenarModalEntrega(calEvent.id, calEvent.status);
                //$('.ModalEntrega').modal('toggle');
                //}
                //if (calEvent.status == 3) {
                //   llenarModalRegreso(calEvent.id, calEvent.status);
                //  $('.ModalDevuelve').modal('toggle');
                //}
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
        //llenarCalendario(0, "%");
        //----QUITAR EVENTO
        //                $("#external-events").on('click', '.external-event', function (event) {
        //                    var id = this.id.split("_")
        //                    $('#calendar').fullCalendar('removeEvents', function (event) {
        //                        if (event.id = id[1])
        //                            return true;
        //                    });
        //                });


        $("#<%=DropVehiculo.ClientID %>").change(function () {
            $('#calendar').fullCalendar('removeEvents');
            llenarCalendario($(this).val());
        });
    });

    function llenarCalendario(id) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/CalendarioVehiculo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{IdVehiculo:'" + id + "'}",
            success: function (data) {
                console.log(data);
                if (data.d.length != 0) {
                    $.each(data.d, function (index, item) {
                        if (item.StrError == "0") {
                            var myEvent = {
                                id: item.id,
                                title: item.title,
                                allDay: item.allDay,
                                start: item.start,
                                end: item.ends,
                                status: item.status,
                                tipoVehiculo: item.tipoVehiculo,
                                destino: item.destino,
                                observacion: item.observacion,
                                FechaEntrega: item.FechaEntrega,
                                FechaDevolucion: item.FechaDevolucion,
                                HoraEntrega: item.HoraEntrega,
                                HoraDevolucion: item.HoraDevolucion,
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
    function llenarModal(id) {
        var array = $('#calendar').fullCalendar('clientEvents', (event._id = id));
        $("#LblNombreReservacion").html(array[0].title);
        $("#LblFechaInicioReservacion").html(array[0].start);
        $("#LblFechaFinReservacion").html(array[0].end);
        $("#LblFechaEntregaReservacion").html(array[0].FechaEntrega);
        $("#LblFechaDevolucionReservacion").html(array[0].FechaDevolucion);
        $("#LblHoraEntregaReservacion").html(array[0].HoraEntrega);
        $("#LblHoraDevolucionReservacion").html(array[0].HoraDevolucion);
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
</script>
</body>
</html>
